package com.grupoavt.avtechnology

import io.flutter.embedding.android.FlutterActivity
import android.util.Log // Importa la clase Log

class MainActivity: FlutterActivity() {
    private val TAG = "MainActivityLifecycle" // Etiqueta para los logs

    override fun onStart() {
        super.onStart()
        Log.d(TAG, "onStart() llamado")
    }

    override fun onResume() {
        super.onResume()
        Log.d(TAG, "onResume() llamado")
    }

    override fun onPause() {
        super.onPause()
        Log.d(TAG, "onPause() llamado")
    }

    override fun onStop() {
        super.onStop()
        Log.d(TAG, "onStop() llamado")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "onDestroy() llamado")
    }
}
