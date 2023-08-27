import 'package:charless_06/widgets/user_profile.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget{
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserProfile(),
    );
  }
}