import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example'),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: 100,
                height: 100,
                child: const Placeholder()
            ),
            const Text('alexander'),
            const Text('+7 (981) 816 22 45'),
            const Text('@alexandrobol')
          ],
        ),
      ),
    );
  }
}