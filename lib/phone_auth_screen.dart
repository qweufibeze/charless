import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_auth;
import 'firebase_options.dart';


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
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneAuthBloc(),
      child: const PhoneAuthScreenContent(),
    );
  }
}

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
            const SizedBox(height: 200),
            Text(
              'Welcome',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade600,
              ),
            ),
            const SizedBox(height: 20),
            const PhoneInputField(),
          ],
        ),
      ),
    );
  }
}

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({Key? key}) : super(key: key);

  @override
  _PhoneInputFieldState createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final MaskTextInputFormatter _phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-0, 0), // Start at the top
      end: const Offset(-0, 1.367), // End at the center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [_phoneFormatter],
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              filled: true,
              fillColor: Colors.white,
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
            onPressed: () => {
             const CreateNewWidget(),
              _startAnimation,
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: const Color.fromARGB(255, 255, 3, 67),
              minimumSize: const Size(double.infinity, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Send Verification Code'),
          ),
        ],
      ),
    );
  }
}

class CreateNewWidget extends StatefulWidget {
  const CreateNewWidget({Key? key}) : super(key: key);

  @override
  _CreateNewWidget createState() => _CreateNewWidget();
}

class _CreateNewWidget extends State<CreateNewWidget> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TextFormField(
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: 'Enter a code',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter a code';
        }
        return null;
      },
    );
    throw UnimplementedError();
  }
}



void main(){
  runApp(
    const MaterialApp(
      home: PhoneAuthScreen()
    )
  );
}
