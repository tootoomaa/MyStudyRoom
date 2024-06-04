package com.example.exmapleofheartrate

import android.app.Application
import com.example.exmapleofheartrate.data.HealthServiceRepository

const val TAG = "Measure Data Sample"
const val PERMISSION = android.Manifest.permission.BODY_SENSORS

class MainApplication: Application() {
   val healthServiceRepository by lazy { HealthServiceRepository(this) }
}