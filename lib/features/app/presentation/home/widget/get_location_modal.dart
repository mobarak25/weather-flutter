import 'package:flutter/material.dart';
import 'package:weather/core/utils/colors.dart';
import 'package:weather/core/widget/text.dart';

Future<dynamic> getLocationModal(BuildContext context,
    {required Function pressSubmit}) {
  final locationTextEditingController = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Enter your location'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: locationTextEditingController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            label: const TextB(
              text: 'Type Location',
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: bDark),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: bDark),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            pressSubmit(locationTextEditingController.text);
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}
