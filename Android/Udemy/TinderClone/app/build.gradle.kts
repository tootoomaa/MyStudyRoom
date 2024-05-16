
plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.jetbrains.kotlin.android)
    kotlin("kapt")
    id("com.google.dagger.hilt.android")
}

android {
    namespace = "com.example.tinderclone"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.tinderclone"
        minSdk = 30
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables {
            useSupportLibrary = true
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }
    buildFeatures {
        compose = true
    }
    composeOptions {
        kotlinCompilerExtensionVersion = "1.5.1"
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

dependencies {

    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.lifecycle.runtime.ktx)
    implementation(libs.androidx.activity.compose)
    implementation(platform(libs.androidx.compose.bom))
    implementation(libs.androidx.ui)
    implementation(libs.androidx.ui.graphics)
    implementation(libs.androidx.ui.tooling.preview)
    implementation(libs.androidx.material3)
//    implementation(libs.androidx.material3.android)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
    androidTestImplementation(platform(libs.androidx.compose.bom))
    androidTestImplementation(libs.androidx.ui.test.junit4)
    debugImplementation(libs.androidx.ui.tooling)
    debugImplementation(libs.androidx.ui.test.manifest)

    implementation ("com.google.accompanist:accompanist-systemuicontroller:0.26.1-alpha")
    implementation ("androidx.navigation:navigation-compose:2.5.3")
    implementation ("com.google.firebase:firebase-auth:21.3.0")
    implementation ("com.google.firebase:firebase-bom:29.0.0")
//    implementation ("com.google.firebase:firebase-auth-ktx")
//    implementation ("com.google.firebase:firebase-firestore-ktx")
//    implementation ("com.google.firebase:firebase-storage-ktx")
    implementation ("com.google.dagger:hilt-android:2.44")
    implementation ("androidx.hilt:hilt-navigation-compose:1.0.0")
    implementation ("com.google.firebase:firebase-firestore:24.5.0")
    kapt("com.google.dagger:hilt-android-compiler:2.44")
    implementation ("io.coil-kt:coil-compose:1.3.2")
    implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.6.1")
}

kapt {
    correctErrorTypes = true
}