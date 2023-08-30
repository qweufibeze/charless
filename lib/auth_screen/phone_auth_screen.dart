import 'package:flutter/material.dart';
import 'widget_input_phone.dart';
import 'widget_input_code.dart';

class PhoneAuthScreenContent extends StatelessWidget {
  const PhoneAuthScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(100, 21, 6, 39),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
             Center(
               child: Text(
                  'CHARLESS',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade600,
                ),
            ),
             ),
            const SizedBox(height: 50),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade600,
              ),
            ),
            const SizedBox(height: 5),
             Text(
              'To Discover Connections Beyond Words',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade600,
              ),
            ),
            const SizedBox(height: 25),
            const PhoneInputField(),
          ],
        ),
      ),
    );
  }
}
void main(){
  runApp(
      const MaterialApp(
          home: PhoneAuthScreenContent()
      )
  );
}