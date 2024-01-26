import 'package:flutter/material.dart';

class InformationItem extends StatelessWidget {
  const InformationItem({
    super.key,
    required this.title,
    required this.value,
    this.isPhoneVareified,
  });

  final String title;
  final String value;
  final bool? isPhoneVareified;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }
}
