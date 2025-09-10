import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final Function(String) onSubmit;
  final TextInputType keyboardType;

  const AdaptativeTextField({
    super.key,
    required this.label,
    required this.onSubmit,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CupertinoTextField(
              controller: TextEditingController(),
              keyboardType: keyboardType,
              onSubmitted: onSubmit,
              placeholder: label,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        : TextField(
            controller: TextEditingController(),
            keyboardType: keyboardType,
            onSubmitted: onSubmit,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
  }
}
