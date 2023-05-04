import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigation_dashboard/infrastructure/helpers/app_persistent_store.dart';
import 'app/app_state.dart';

void main() async {
  await _initializeFirebase();
  await AppPersistentStore.initialize();
  runApp(const AppState());
}

_initializeFirebase() {
  WidgetsFlutterBinding.ensureInitialized();
    return Firebase.initializeApp(
      options:const FirebaseOptions(
        apiKey: "AIzaSyA1idIZxxFgV3DB6NxcLx-gTRokPkX5LIw",
        authDomain: "proyect-4c6f6.firebaseapp.com",
        databaseURL: "https://proyect-4c6f6-default-rtdb.firebaseio.com",
        projectId: "proyect-4c6f6",
        storageBucket: "proyect-4c6f6.appspot.com",
        messagingSenderId: "612423341288",
        appId: "1:612423341288:web:5d059efe7df1f26d98655d",
        measurementId: "G-2H2LEBEP5B"
      )
    );
}
