import 'package:flutter/material.dart';

class AuthBottomButton extends StatelessWidget {
  final String title;
  final String pageName;
  final VoidCallback onTap;
  const AuthBottomButton({
    super.key,
    required this.title,
    required this.pageName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              GestureDetector(
                onTap: onTap,
                child: Text(
                  " $pageName",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
