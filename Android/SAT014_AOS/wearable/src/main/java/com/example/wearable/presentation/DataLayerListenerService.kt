package com.example.wearable.presentation

import android.annotation.SuppressLint
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateListOf
import androidx.lifecycle.ViewModel
import com.google.android.gms.wearable.CapabilityClient
import com.google.android.gms.wearable.CapabilityInfo
import com.google.android.gms.wearable.DataClient
import com.google.android.gms.wearable.DataEvent
import com.google.android.gms.wearable.DataEventBuffer
import com.google.android.gms.wearable.MessageClient
import com.google.android.gms.wearable.MessageEvent

class DataLayerListenerService :
   ViewModel(),
   DataClient.OnDataChangedListener {

   private val _count = mutableIntStateOf(0)

   val count: Int = _count.value

   override fun onDataChanged(dataEventBuffer: DataEventBuffer) {

      println(dataEventBuffer)


   }
}
