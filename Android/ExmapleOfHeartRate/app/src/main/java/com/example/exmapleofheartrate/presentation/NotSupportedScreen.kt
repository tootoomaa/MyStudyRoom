package com.example.exmapleofheartrate.presentation

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Warning
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.wear.compose.material.Icon
import androidx.wear.compose.material.Text

@Composable
fun NotSupportedScreen() {
   Column(
      modifier = Modifier
         .fillMaxSize()
         .padding(horizontal = 16.dp, vertical = 8.dp),
      horizontalAlignment = Alignment.CenterHorizontally,
      verticalArrangement = Arrangement.Center
   ) {
      Icon(
         imageVector = Icons.Default.Warning,
         contentDescription = "Icon",
         tint = Color.Red
      )
      Text(
         text = "사용이 불가능합니다",
         textAlign = TextAlign.Center
      )
   }
}
