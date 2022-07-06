import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final Function(String) onChange;
  final Function(bool) isValid;
  final RegExp regexValue;
  final IconData specifiedIcon;
  final String label;
  final String errorText;
  final TextInputType keyboard;

  const InputBox(
      {Key? key,
      required this.onChange,
      required this.regexValue,
      required this.specifiedIcon,
      required this.label,
      required this.errorText,
      required this.keyboard,
      required this.isValid})
      : super(key: key);
  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController formCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool valid = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                controller: formCtrl,
                keyboardType: widget.keyboard,
                // validates whether value entered is empty or according to regex
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !widget.regexValue.hasMatch(value)) {
                    valid = false;
                    return widget.errorText;
                  } else {
                    valid = true;
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: widget.label,
                    suffixIcon: Icon(widget.specifiedIcon),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (val) => {
                      _formKey.currentState!.validate(),
                      widget.onChange(val),
                      widget.isValid(valid)
                    }),
          ],
        ));
  }
}
