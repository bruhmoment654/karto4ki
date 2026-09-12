plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")

}

// Конфигурации подписи из keystore/*.properties.
// Применяется до android {} — блок ниже ссылается на signingConfigs по имени.
apply(from = "../keystore/signingConfigs.gradle")

android {
    namespace = "dev.urbaev.c4rds"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "28.2.13676358"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        jvmToolchain(17)
    }

    defaultConfig {
        applicationId = "dev.urbaev.c4rds"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            ndk {
                debugSymbolLevel = "FULL"
            }
        }
    }

    flavorDimensions += "release-type"

    productFlavors {
        create("dev") {
            dimension = "release-type"
            applicationIdSuffix = ".dev"
            // dev-keystore может отсутствовать (CI, чужая машина) — тогда debug-подпись.
            signingConfig =
                signingConfigs.findByName("dev") ?: signingConfigs.getByName("debug")
        }

        create("prod") {
            dimension = "release-type"
            signingConfig = signingConfigs.getByName("prod")
        }
    }

    splits {
        abi {
            isEnable = !gradle.startParameter.taskNames.any {
                it.lowercase().contains("prod")
            }
            reset()
            include("x86", "x86_64", "armeabi-v7a", "arm64-v8a")
            isUniversalApk = true
        }
    }
}

flutter {
    source = "../.."

}

dependencies {
    // Последняя стабильная. Версии credentials и credentials-play-services-auth
    // обязаны совпадать.
    implementation("androidx.credentials:credentials:1.6.0")
    implementation("androidx.credentials:credentials-play-services-auth:1.6.0")
    implementation("com.google.android.libraries.identity.googleid:googleid:1.2.0")
    // lifecycleScope в MainActivity. Приезжает и транзитивно с эмбеддингом
    // Flutter, но полагаться на это нельзя — используем, значит объявляем.
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.7.0")
}
