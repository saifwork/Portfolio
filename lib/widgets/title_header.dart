
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class TitleHeader extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  const TitleHeader({
    super.key,
    required this.title,
    required this.content,
    this.color = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: kH20),
        Container(
          height: 7,
          width: 35,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: kH15),
        Text(
          textAlign: TextAlign.center,
          content,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.w100, color: color),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ],
    );
  }
}