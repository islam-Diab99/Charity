

import 'package:flutter/material.dart';

import '../styles/colors.dart';


Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 0.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: Color.fromRGBO(37, 90, 123,1)),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white,fontSize: 20),
        ),
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
  Color? color,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
  int? lines,
}) =>
    Container(
      decoration: BoxDecoration(
          color:  Color.fromRGBO(37, 90, 123,.1),
        borderRadius: BorderRadius.circular(50)
      ),

      child: TextFormField(

        cursorColor: defaultColor,
        cursorRadius: Radius.circular(40),
        cursorHeight: 25,
        controller: controller,

        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        maxLines: lines,
        validator: validate,
        decoration: InputDecoration(
          errorStyle: TextStyle(color: Colors.redAccent,fontSize: 14),


          hintText: label,
          hintStyle: TextStyle(fontSize: 17),
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: suffix != null
              ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ),
          )
              : null,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.transparent,

            ),
          ),
          border:  InputBorder.none,
        ),
      ),
    );






