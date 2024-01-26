import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinWidget extends StatelessWidget {
  const PinWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    // required this.onComplete,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  // final Function(String) onComplete;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    const length = 4;
    const borderColor = Color.fromRGBO(114, 178, 238, 1);
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromRGBO(0, 0, 0, 0.05);
    final defaultPinTheme = PinTheme(
      width: 68,
      height: 53,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 68,
      child: Pinput(
        length: length,
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        // onCompleted: onComplete,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 68,
          width: 64,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: borderColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
