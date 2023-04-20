import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBR2SHiyYuqVgbe-1AC7kjnxpuvO4vHBT8",
            authDomain: "pokedex-f4b3e.firebaseapp.com",
            projectId: "pokedex-f4b3e",
            storageBucket: "pokedex-f4b3e.appspot.com",
            messagingSenderId: "368876537959",
            appId: "1:368876537959:web:7cf3a609e5d0f350c52cc2"));
  } else {
    await Firebase.initializeApp();
  }
}
