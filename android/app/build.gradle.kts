plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tatbeeqi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // Note: ndkVersion is usually defined in local.properties or flutter.gradle these days, but if it works here, fine.

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true // <--- MODIFIED/ADDED
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.tatbeeqi"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Example: If you have other dependencies, they would go here.
    // implementation("androidx.core:core-ktx:1.9.0")

    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4") // <--- ADDED
}