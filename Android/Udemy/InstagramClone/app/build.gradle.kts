
plugins {
    alias(libs.plugins.androidApplication)
    alias(libs.plugins.jetbrainsKotlinAndroid)

    kotlin("kapt") version "1.9.0"
    id("com.google.dagger.hilt.android") version "2.44" apply false
    id("com.google.gms.google-services")
//    id("kotlin-kapt")
//    id("com.google.dagger:hilt-android-gradle-plugin:2.38.1")
}

android {
    namespace = "com.example.instagramclone"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.instagramclone"
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
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
    androidTestImplementation(platform(libs.androidx.compose.bom))
    androidTestImplementation(libs.androidx.ui.test.junit4)
    debugImplementation(libs.androidx.ui.tooling)
    debugImplementation(libs.androidx.ui.test.manifest)


    implementation("androidx.navigation:navigation-compose:2.4.0-beta01")

    implementation("com.google.firebase:firebase-auth:19.2.0")
    implementation("com.google.firebase:firebase-bom:32.7.4")

    // https://firebase.google.com/docs/android/kotlin-migration?hl=ko#ktx-apis-to-main-how-to-migrate
    // 마이그레이션 방법
    implementation("com.google.firebase:firebase-auth:16.0.5")                   // 해당 모듀 지원 종료 bom으로 통합
    implementation("com.google.firebase:firebase-firestore:18.0.0")              // ktx 제거
    implementation("com.google.firebase:firebase-storage:16.0.1")              // ktx 제거

    implementation("com.google.dagger:hilt-android:2.38.1")
    implementation("androidx.hilt:hilt-navigation-compose:1.0.0-beta01")
    kapt("com.google.dagger:hilt-android-compiler:2.38.1")

    implementation("io.coil-kt:coil-compose:1.3.2")                             // 이미지 관리 라이브러리

    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.3.9")

//    implementation("com.google.dagger:hilt-android:2.44")
//    kapt("com.google.dagger:hilt-android-compiler:2.44")
    implementation("com.google.android.gms:play-services-location:21.2.0")
}

// Allow references to generated code
kapt {
    correctErrorTypes = true
}