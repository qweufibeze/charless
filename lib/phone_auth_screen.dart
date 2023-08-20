import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum PhoneAuthEvent {
  startVerification,
  completeVerification,
}

enum PhoneAuthState {
  initial,
  codeSent,
  codeVerified,
}

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  PhoneAuthBloc() : super(PhoneAuthState.initial);

  @override
  Stream<PhoneAuthState> mapEventToState(PhoneAuthEvent event) async* {
    switch (event) {
      case PhoneAuthEvent.startVerification:
        yield PhoneAuthState.codeSent;
        break;
      case PhoneAuthEvent.completeVerification:
        yield PhoneAuthState.codeVerified;
        break;
    }
  }
}

class PhoneAuthScreen extends StatelessWidget {
  const PhoneAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneAuthBloc(),
      child: const PhoneAuthScreenContent(),
    );
  }
}

class PhoneAuthScreenContent extends StatelessWidget {
  const PhoneAuthScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/phone_auth_image.png', height: 150), // Добавьте изображение в папку assets
            const SizedBox(height: 20),
            Text(
              'Enter your phone number:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            PhoneInputField(),
          ],
        ),
      ),
    );
  }
}

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({super.key});

  @override
  _PhoneInputFieldState createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<PhoneAuthBloc>(context).add(PhoneAuthEvent.startVerification);
              }
            },
            child: const Text('Send Verification Code'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              minimumSize: Size(double.infinity, 0),
            ),
          ),
        ],
      ),
    );
  }
}
