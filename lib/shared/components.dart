import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextInput({
  bool isObscureText = false,
  required TextEditingController fromController,
  Function(String)? onFieldSubmit,
  Function(String)? onChange,
  String? Function(String?)? validationCallBack,
  required TextInputType keyboardType,
  String label = "Text Field",
  required String hint,
  IconData prefixIcon = Icons.edit,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  VoidCallback? onTap,
}) =>
    TextFormField(
      obscureText: isObscureText,
      controller: fromController,
      onFieldSubmitted: onFieldSubmit,
      onChanged: onChange,
      keyboardType: keyboardType,
      validator: validationCallBack,
      onTap: onTap,
      decoration: InputDecoration(
          hintText: label,
          labelText: hint,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null
              ? IconButton(icon: Icon(suffixIcon), onPressed: suffixPressed)
              : null,
          border: const OutlineInputBorder()),
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        void Function(String)? onSubmit,
        void Function(String)? onChange,
        void Function()? onTap,
        bool isPassword = false,
        required String? Function(String?) validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        void Function()? suffixPressed}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(
                  icon: Icon(suffix),
                  onPressed: suffixPressed!,
                )
              : null,
          border: OutlineInputBorder()),
    );

Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        bool isUpperCase = true,
        double radius = 10.0,
        required Function function,
        required String text}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      // decoration: BoxDecoration(),
      // borderRadius: BorderRadius.circular(radius), color: background),
    );

Widget defaultTextButton(
        {required Function function(), required String text}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

void navigateTo(BuildContext context, Widget toWidget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => toWidget));

void navigateAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
      (route) {
        return false;
      },
    );

void showToast({required String message, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: colorMapper[state],
        textColor: Colors.white,
        fontSize: 16.0);

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Map<ToastStates, Color> colorMapper = {
  ToastStates.SUCCESS: Colors.green,
  ToastStates.ERROR: Colors.red,
  ToastStates.WARNING: Colors.yellow,
};

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
