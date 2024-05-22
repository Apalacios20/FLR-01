import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class ToggleTab extends StatelessWidget {
  final RxInt selectedIndex;
  final List<String> labels;

  const ToggleTab({
    super.key,
    required this.selectedIndex,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterToggleTab(
        // TODO: MAKE WIDTH DYNAMIC
        width: 27,
        height: 30,
        borderRadius: 15,
        selectedBackgroundColors: const [Colors.black87],
        selectedTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unSelectedTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
        labels: labels,
        selectedIndex: selectedIndex.value,
        selectedLabelIndex: (index) {
          selectedIndex.value = index;
        },
      ),
    );
  }
}
