package dev.urbaev.c4rds

import android.app.Activity
import androidx.credentials.ClearCredentialStateRequest
import androidx.credentials.CredentialManager
import androidx.credentials.CustomCredential
import androidx.credentials.GetCredentialRequest
import androidx.credentials.GetCredentialResponse
import androidx.credentials.exceptions.GetCredentialCancellationException
import androidx.credentials.exceptions.NoCredentialException
import com.google.android.libraries.identity.googleid.GetSignInWithGoogleOption
import com.google.android.libraries.identity.googleid.GoogleIdTokenCredential
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.launch

class GoogleAuthApiImpl(
    private val activity: Activity,
    private val scope: CoroutineScope,
) : GoogleAuthApi {

    private val credentialManager = CredentialManager.create(activity)

    private var signInJob: Job? = null

    override fun signIn(
        nonce: String,
        serverClientId: String,
        callback: (Result<GoogleSignInResult>) -> Unit,
    ) {
        if (signInJob?.isActive == true) {
            callback(
                Result.success(
                    result(GoogleSignInStatus.FAILURE, null, "Вход уже выполняется"),
                ),
            )

            return
        }

        signInJob = scope.launch {
            callback(Result.success(requestIdToken(nonce, serverClientId)))
        }
    }

    override fun signOut(callback: (Result<Unit>) -> Unit) {
        scope.launch {
            try {
                credentialManager.clearCredentialState(ClearCredentialStateRequest())
                callback(Result.success(Unit))
            } catch (e: Exception) {
                callback(Result.failure(FlutterError("sign_out_failed", e.message)))
            }
        }
    }

    override fun test() {
        print("ANDROID_NATIVE_METHOD: TEST")
    }


    private suspend fun requestIdToken(
        nonce: String,
        serverClientId: String,
    ): GoogleSignInResult = try {

        val option = GetSignInWithGoogleOption.Builder(serverClientId)
            .setNonce(nonce)
            .build()
        val request = GetCredentialRequest.Builder()
            .addCredentialOption(option)
            .build()
        val token = credentialManager
            .getCredential(activity, request)
            .extractIdToken()

        result(GoogleSignInStatus.SUCCESS, token, null)
    } catch (e: GetCredentialCancellationException) {
        // Сюда попадает и настоящая отмена пользователем, и сбои GMS:
        // «[16] Account reauth failed» — это CommonStatusCodes.CANCELED,
        // а не действие человека. По типу исключения их не отличить, поэтому
        // сообщение тащим наружу, иначе сбой становится невидимым.
        //
        // `?.toString()`, а не `.toString()`: у настоящей отмены поле пустое,
        // и `.toString()` дал бы строку "null" вместо null.
        result(GoogleSignInStatus.CANCELLED, null, e.errorMessage?.toString() ?: e.message)
    } catch (e: NoCredentialException) {
        result(GoogleSignInStatus.NO_CREDENTIAL, null, e.message)
    } catch (e: Exception) {
        result(GoogleSignInStatus.FAILURE, null, e.message ?: e.javaClass.simpleName)
    }

    private fun result(
        status: GoogleSignInStatus,
        idToken: String?,
        errorMessage: String?,
    ) = GoogleSignInResult(status, idToken, errorMessage)

    private fun GetCredentialResponse.extractIdToken(): String {
        val credential = credential
        if (credential !is CustomCredential ||
            credential.type != GoogleIdTokenCredential.TYPE_GOOGLE_ID_TOKEN_CREDENTIAL
        ) {
            throw IllegalStateException("Unexpected credential: ${credential.type}")
        }

        // idToken не логировать никогда — это полноценный credential.
        return GoogleIdTokenCredential.createFrom(credential.data).idToken
    }
}
