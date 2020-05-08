/// ********************************************************************************************************************
/// This project was developed by two undergraduates who are studying for BSc (Hons) in Information Technology         *
/// Specializing in Software Engineering at Sri Lanka Institute of Information Technology as an assignment for the     *
/// module Current Trends in Software Engineering. The intellectual and technical concepts contained herein are        *
/// proprietary to its developers and Dissemination of this information or reproduction of this material is            *
/// strictly forbidden unless prior permission is obtained.                                                            *
///                                                                                                                    *
/// @description This page contains decoration or styling applied for all the TextFormFields in the entire application.*
/// @author H.M.Y.L.W.Bandara IT1725098 lakshanwarunab@gmail.com                                                       *
///                                                                                                                    *
///*********************************************************************************************************************

import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 * @description This constant is used for styling for all TextFormFields.It
 * is used with explicitly setting the labelText and PrefixIcon
 * wherever it has been used.
 */
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
