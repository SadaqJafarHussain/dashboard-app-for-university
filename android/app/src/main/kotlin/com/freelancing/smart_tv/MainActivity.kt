package com.freelancing.smart_tv

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import android.os.Bundle

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent1 = Intent(this@MainActivity, RunServiceOnBoot::class.java)
        startService(intent1)
    }
}
