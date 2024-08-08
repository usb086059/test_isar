import 'package:flutter/material.dart';

InputDecoration formDecorationTerapia(
    String titleLabel, String suffixText, String? hintText) {
  return InputDecoration(
    labelText: titleLabel,
    labelStyle: const TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.white70),
    suffixText: suffixText,
    suffixStyle:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    helperStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
    errorStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(16))),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 4),
        borderRadius: BorderRadius.all(Radius.circular(16))),
    disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(16))),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(16))),
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(16))),
  );
}
