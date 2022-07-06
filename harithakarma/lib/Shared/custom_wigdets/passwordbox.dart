import 'package:flutter/material.dart';

class PasswordBox extends StatefulWidget {
  final Function(String) onChange;
  final Function(bool) isValid;
  final RegExp regexValue;

  const PasswordBox(
      {Key? key,
      required this.onChange,
      required this.regexValue,
      required this.isValid})
      : super(key: key);
  @override
  State<PasswordBox> createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  final TextEditingController formCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool valid = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                controller: formCtrl,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !passwordVisible,

                // validates whether value entered is empty or according to regex
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !widget.regexValue.hasMatch(value)) {
                    valid = false;
                    return 'Include at least : \n 8 characters \n 1 UpperCase \n 1 LowerCase \n 1 Numeric Character \n 1 Special Character';
                  } else {
                    valid = true;
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: passwordVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        setState(() => passwordVisible = !passwordVisible);
                      },
                    ),
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
