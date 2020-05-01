import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 5.0),
  ),
);

const newTextInputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  filled: true,
  fillColor: Colors.black45,
  labelStyle: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
    letterSpacing: 2.0,
    color: Colors.white,
  ),
  errorStyle: TextStyle(
    fontSize: 15.0,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  ),
);
