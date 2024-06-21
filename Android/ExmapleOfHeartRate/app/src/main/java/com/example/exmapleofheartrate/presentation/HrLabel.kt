package com.example.exmapleofheartrate.presentation

import com.example.exmapleofheartrate.R

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.HeartBroken
import androidx.compose.material.icons.filled.MonitorHeart
import androidx.compose.material.icons.filled.QuestionMark
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.health.services.client.data.DataTypeAvailability
import androidx.wear.compose.material.Icon
import androidx.wear.compose.material.MaterialTheme
import androidx.wear.compose.material.Text

@Composable
fun HrLabel(
   hr: Double,
   availability: DataTypeAvailability
) {
   val icon = when (availability) {
      DataTypeAvailability.AVAILABLE -> Icons.Default.Favorite
      DataTypeAvailability.ACQUIRING -> Icons.Default.MonitorHeart
      DataTypeAvailability.UNAVAILABLE,
      DataTypeAvailability.UNAVAILABLE_DEVICE_OFF_BODY -> Icons.Default.HeartBroken
      else -> Icons.Default.QuestionMark
   }
   val text = if (availability == DataTypeAvailability.AVAILABLE) {
      hr.toInt().toString()
   } else {
      "no hr reading"
   }
   Row(
      modifier = Modifier.fillMaxWidth(),
      horizontalArrangement = Arrangement.Center,
      verticalAlignment = Alignment.CenterVertically
   ) {
      Icon(
         imageVector = icon,
         contentDescription = "Icon",
         tint = Color.Red
      )
      Text(
         text = text,
         style = MaterialTheme.typography.display1
      )
   }
}