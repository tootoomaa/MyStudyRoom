package com.example.tinderclone

import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.compose.rememberNavController
import org.checkerframework.common.subtyping.qual.Bottom

enum class BottomNavigationItem(val icon: Int, val navDestination: DestinationScreen) {
   SWIPE(R.drawable.baseline_swipe, DestinationScreen.Swipe),
   CHATLIST(R.drawable.baseline_chat, DestinationScreen.ChatList),
   PROFILE(R.drawable.baseline_person, DestinationScreen.Profile)
}

@Composable
fun BottomNavigationMenu(selectedItem: BottomNavigationItem, navController: NavController) {
   Row(
      modifier = Modifier
         .fillMaxWidth()
         .wrapContentHeight()
         .padding(top = 4.dp)
         .background(Color.White),
      horizontalArrangement = Arrangement.Absolute.SpaceAround
   ) {
      for (item in BottomNavigationItem.values()) {
         Image(painter = painterResource(id = item.icon), contentDescription = null)
      }
   }
}

@Preview(showBackground = true)
@Composable
fun BottomNavigationMenuPreview() {
   BottomNavigationMenu(
      selectedItem = BottomNavigationItem.PROFILE,
      navController = rememberNavController()
   )
}
