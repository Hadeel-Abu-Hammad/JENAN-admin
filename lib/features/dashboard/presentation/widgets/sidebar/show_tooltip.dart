import 'package:flutter/material.dart';

class ShowTooltip extends StatelessWidget {
  const ShowTooltip({
    super.key,
    required this.label,
    required this.itemContent,
  });

  final String label;
  final Material itemContent;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      preferBelow: false,
      verticalOffset: 0,
      waitDuration: const Duration(milliseconds: 300),
      child: itemContent,
    );
  }
}
