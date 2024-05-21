package com.example.tinderclone

import android.util.Log
import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import com.example.tinderclone.data.Event
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.storage.FirebaseStorage
import dagger.hilt.android.lifecycle.HiltViewModel
import java.lang.Exception
import javax.inject.Inject

@HiltViewModel
class TCViewModel @Inject constructor(
    val auth: FirebaseAuth,
    val db: FirebaseFirestore,
    val storage: FirebaseStorage
) : ViewModel() {

    val inProgress = mutableStateOf(false)
    val popupNotification = mutableStateOf<Event<String>?>(Event("Test"))

    private fun handleException(exception: Exception? = null, customMessage: String = "") {
        Log.e("TinerClone", "Tinder execption", exception)
        exception?.printStackTrace()

        val errorMsg = exception?.localizedMessage ?: ""
        val message = if (customMessage.isEmpty()) errorMsg else "$customMessage: $errorMsg"
        popupNotification.value = Event(message)
        inProgress.value = false
    }
}