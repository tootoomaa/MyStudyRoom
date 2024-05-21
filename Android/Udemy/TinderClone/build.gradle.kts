// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.jetbrains.kotlin.android) apply false
    alias(libs.plugins.google.gms.google.services) apply false
    id("com.google.dagger.hilt.android") version "2.48" apply false
//    id("com.google.gms.google-services") version "4.4.1" apply false
}

buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.1")
        classpath("com.google.dagger:hilt-android-gradle-plugin:2.48")
    }
}

//buildscript {
//    dependencies {
//        classpath("com.google.gms:google-services:4.3.15")
//    }
//}// Top-level bu ild file where you can add configuration options common to all sub-projects/modules.
//plugins {
//    id("com.android.application") version "8.0.0" apply false
//    id("com.android.library") version "8.0.0" apply false
//    id("org.jetbrains.kotlin.android") version "1.7.20" apply false
//    id("com.google.dagger.hilt.android") version "2.42" apply false
//}