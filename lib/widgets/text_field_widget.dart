import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget{

  final String? placeholder;
  final bool? secure;

  const TextFieldWidget({
    super.key,
    this.placeholder,
    this.secure,
});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: placeholder,
        ),
        obscureText: secure ?? false,
      ),
    );
  }
}