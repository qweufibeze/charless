import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'widget_input_code.dart';

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

   AnimationController? _controllerSendButton;
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
    _controllerSendButton?.forward();
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