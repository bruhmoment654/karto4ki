package dev.urbaev.c4rds

import androidx.lifecycle.lifecycleScope
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Имя канала, разбор аргументов и коды ошибок сгенерированы Pigeon —
        // здесь остаётся только связать интерфейс с реализацией.
        GoogleAuthApi.setUp(
            flutterEngine.dartExecutor.binaryMessenger,
            GoogleAuthApiImpl(activity = this, scope = lifecycleScope),
        )
    }
}
