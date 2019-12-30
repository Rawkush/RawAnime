import 'package:flutter/material.dart';

class CustomTextFormField {
  static Widget MyTextFormField(
      TextEditingController _textEditingController, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        controller: _textEditingController,
        textInputAction: TextInputAction.go,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          suffixIcon: IconButton(icon: Icon(Icons.search,color: Colors.white), onPressed: () {}),
          labelText: "Enter the Episode Number",
          labelStyle: TextStyle(
          color: Colors.white,
        ), 
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(),
          ),
          //fillColor: Colors.green
        ),
        onChanged: (currentValue) {},
        keyboardType: TextInputType.text,
        onFieldSubmitted: (value) async {},
      ),
    );
  }
}
