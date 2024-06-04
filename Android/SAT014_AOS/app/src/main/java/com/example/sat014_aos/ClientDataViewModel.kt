package com.example.sat014_aos

import android.annotation.SuppressLint
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import com.google.android.gms.wearable.DataClient
import com.google.android.gms.wearable.DataEvent
import com.google.android.gms.wearable.DataEventBuffer
import com.google.android.gms.wearable.MessageClient

class ClientDataViewModel:
   ViewModel(),
   DataClient.OnDataChangedListener {

   var count by mutableIntStateOf(0)

   @SuppressLint("VisibleForTests")
   override fun onDataChanged(dataEvents: DataEventBuffer) {
      var data = dataEvents.metadata
      println(data)
   }
}

