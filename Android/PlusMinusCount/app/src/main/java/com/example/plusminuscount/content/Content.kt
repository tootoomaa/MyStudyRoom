package com.example.plusminuscount.content

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.widthIn
import androidx.compose.material3.Button
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.plusminuscount.mainview.MainViewModel
import com.example.plusminuscount.ui.theme.PlusMinusCountTheme

@Composable
fun CounterGreeting(
    modifier: Modifier = Modifier,
    viewModel: MainViewModel,
    onCancel: () -> Unit
) {

    Column(
        modifier = Modifier.fillMaxWidth().padding(top = 50.dp),
        verticalArrangement = Arrangement.SpaceEvenly,
    ) {
        Row(
            modifier = modifier,
            horizontalArrangement = Arrangement.SpaceAround,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Button(
                onClick = { viewModel.decrease()  }
            ) {
                Text(text = "-")
            }

            Text(
                text = viewModel.counter.value.toString(),
                fontSize = 50.sp
            )

            Button(onClick = {
                viewModel.increase()
            }) {
                Text(text = "+")
            }

        }

        Button(
            onClick = onCancel
        ) {
            Text(
                modifier = modifier,
                text = "Back to main"
            )
        }
    }
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    PlusMinusCountTheme {
        CounterGreeting(
            modifier = Modifier.fillMaxWidth(),
            viewModel = MainViewModel(),
            onCancel = { }
        )
    }
}