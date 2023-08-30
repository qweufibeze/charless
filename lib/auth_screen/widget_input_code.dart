import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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