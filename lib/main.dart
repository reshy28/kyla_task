import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kyla_task/controller/homescreen_controller.dart';
import 'package:provider/provider.dart';

import 'view/Edit_screen/widget/bottomNavBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          storageBucket: "gs://kyla-ba739.appspot.com",
          apiKey: 'AIzaSyClMxkOFeBpsnQ4y7BX7LG7bSqiVs1QqAQ',
          appId: '1:780923505219:android:5776978ba83011dff322f6',
          messagingSenderId: '',
          projectId: 'kyla-ba739'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeScreenController(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNav(),
      ),
    );
  }
}
