import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget{

  final String? placeholder;
  final String? hintPlaceholder;
  final bool? secure;
  final TextEditingController? textEditingController;
  final Function(String)? onTextChanged;
  final TextInputType? inputType;
  final bool? textEnabled;

  const TextFieldWidget({
    super.key,
    this.placeholder,
    this.hintPlaceholder,
    this.secure,
    this.textEditingController,
    this.onTextChanged,
    this.inputType,
    this.textEnabled,
});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: textEditingController,
        onChanged: onTextChanged,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: placeholder,
          hintText: hintPlaceholder,
        ),
        obscureText: secure ?? false,
        keyboardType: inputType ?? TextInputType.text,
        enabled: textEnabled ?? true,
      ),
    );
  }
}