
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

class PhoneInputField extends StatefulWidget {
  const PhoneInputField({Key? key}) : super(key: key);

  @override
  _PhoneInputFieldState createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> with SingleTickerProviderStateMixin  {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isShowWidget= false;
  final MaskTextInputFormatter _phoneFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  void _toggleWidget() {
    setState(() {
      _isShowWidget = true;
    });
  }

  late AnimationController _controllerInputPhone;
  late Animation<Offset> _offsetAnimationInputPhone;

  late AnimationController _controllerSendButton;
  late Animation<Offset> _offsetAnimationSendButton;

  @override
  void initState() {
    super.initState();
    _controllerInputPhone = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _offsetAnimationInputPhone = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controllerInputPhone,
      curve: Curves.fastOutSlowIn,
    ));


    _offsetAnimationSendButton = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _controllerInputPhone,
      curve: Curves.fastOutSlowIn,
    ));
  }

  void _startAnimationInputPhone(){
    _controllerInputPhone.forward();
  }

  void _startAnimationSendButton(){
    _controllerSendButton.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Form(
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Column(
              children: [
                SlideTransition(
                  position: _offsetAnimationInputPhone,
                  child: TextFormField(
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
                ),
                const SizedBox(height: 20),
                SlideTransition(
                  position: _offsetAnimationSendButton,
                  child: ElevatedButton(
                    onPressed:(){
                      _startAnimationInputPhone();
                      _toggleWidget();
                      _startAnimationSendButton();
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
                ),
                if(_isShowWidget)
                  const CreateNewWidget(),
              ],
            ),
            if(_isShowWidget)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.5,
                left: 16,
                right: 16,
                child: const CreateNewWidget(),
              ),
          ],
        ),
      ),
    );
  }
}

class CreateNewWidget extends StatefulWidget {
  const CreateNewWidget({Key? key}) : super(key: key);

  @override
  _CreateNewWidget createState() => _CreateNewWidget();
}

class _CreateNewWidget extends State<CreateNewWidget> with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final MaskTextInputFormatter _phoneFormatter = MaskTextInputFormatter(
    mask: '### ###',
    filter: {'#': RegExp(r'[0-9]')},
  );

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -2.0),
      end: const Offset(0, -1.225),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: TextFormField(
        controller: _phoneController,
        inputFormatters: [_phoneFormatter],
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
      ),
    );
  }
}

void main(){
  runApp(
      const MaterialApp(
          home: PhoneAuthScreen()
      )
  );
}