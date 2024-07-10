import 'package:flutter/material.dart';

class ModalStatistic extends StatefulWidget {
  final String label;
  final String stat;
  final bool? isPercentage;
  const ModalStatistic({
    required this.label,
    required this.stat,
    this.isPercentage,
    super.key,
  });

  @override
  State<ModalStatistic> createState() => _ModalStatisticState();
}

class _ModalStatisticState extends State<ModalStatistic> {
  bool? isPositivePercentage;

  @override
  void initState() {
    super.initState();

    if (widget.isPercentage == true) {
      isPositivePercentage = isPositiveRemoveSymbols(widget.stat);
    }
  }

  bool isPositiveRemoveSymbols(String number) {
    String cleanedString = number.replaceAll('%', '');
    double percent = double.parse(cleanedString);
    return percent >= 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.label),
        Text(
          widget.stat,
          style: widget.isPercentage == true
              ? TextStyle(
                  color:
                      isPositivePercentage == true ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                )
              : const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
        ),
      ],
    );
  }
}
