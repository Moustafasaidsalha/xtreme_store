import 'package:flutter/material.dart';

class ReusableTextButton extends StatelessWidget {
  const ReusableTextButton({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
