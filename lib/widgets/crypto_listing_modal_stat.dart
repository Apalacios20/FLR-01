import 'package:flutter/material.dart';

class ModalStatistic extends StatelessWidget {
  final String label;
  final String stat;
  const ModalStatistic({required this.label, required this.stat, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          stat,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
