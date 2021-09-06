import 'package:flutter/material.dart';

Widget fictionFormField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  required TextInputType textInputType,
}) =>
    TextFormField(
      keyboardType: textInputType,
      showCursor: false,
      style: TextStyle(color: Colors.white),
      controller: controller,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.deepOrange),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.deepOrange,
            fontSize: 18,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.deepOrange,
          )),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
