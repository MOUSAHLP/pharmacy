import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInput extends StatelessWidget {
  final String hint;
  final TextEditingController mycontroller;
  final bool isText;
  final int? maxLength;
  final IconData icon;
  final Function(String) function;
  final String? Function(String?)? validatorFun;
  final TextInputAction textInputAction;

  const MyInput({
    super.key,
    required this.hint,
    required this.mycontroller,
    this.isText = true,
    required this.function,
    required this.icon,
    this.validatorFun,
    this.maxLength,
    this.textInputAction = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    FocusNode focus = FocusNode();
    return TextFormField(
      maxLength: maxLength,
      validator: validatorFun,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: mycontroller,
      onTap: () {
        if (mycontroller.selection ==
            TextSelection.fromPosition(
              TextPosition(offset: mycontroller.text.length - 1),
            )) {
          mycontroller.selection = TextSelection.fromPosition(
            TextPosition(offset: mycontroller.text.length),
          );
        }
      },
      onChanged: (w) {
        focus.addListener(() {
          if (mycontroller.selection ==
              TextSelection.fromPosition(
                TextPosition(offset: mycontroller.text.length - 1),
              )) {
            mycontroller.selection = TextSelection.fromPosition(
              TextPosition(offset: mycontroller.text.length),
            );
          }
        });
        if (mycontroller.selection ==
            TextSelection.fromPosition(
              TextPosition(offset: mycontroller.text.length - 1),
            )) {
          mycontroller.selection = TextSelection.fromPosition(
            TextPosition(offset: mycontroller.text.length),
          );
        }
        function(w);
      },
      focusNode: focus,
      style: TextStyle(color: Get.theme.primaryColor),
      cursorColor: Get.theme.primaryColor,
      textAlign: TextAlign.end,
      textInputAction: textInputAction,
      onEditingComplete: () {
        focus.nextFocus();
      },
      textDirection: TextDirection.ltr,
      autocorrect: false,
      enableIMEPersonalizedLearning: false,
      keyboardType: isText ? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        hintStyle: Get.theme.textTheme.bodyText1!
            .copyWith(fontSize: 12, fontWeight: FontWeight.normal),
        hintText: hint,
        hintTextDirection: TextDirection.ltr,
        prefixIcon: Icon(
          icon,
          color: Get.theme.primaryColor,
        ),
        prefixIconColor: Get.theme.primaryColor,
        fillColor: Get.theme.backgroundColor,
        filled: true,
      ),
    );
  }
}
