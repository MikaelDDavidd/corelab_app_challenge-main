import 'package:corelab_app_challenge/app/modules/controllers/home_controller.dart';
import 'package:corelab_app_challenge/app/modules/controllers/search_controller.dart';
import 'package:corelab_app_challenge/app/modules/views/navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => SearchLogicController()),
      ],
      child: MaterialApp(
        title: 'Your App',
        home: NavigationView(),
      ),
    );
  }
}