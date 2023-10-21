import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class HistoryItem extends StatefulWidget {
  const HistoryItem({super.key});

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      surfaceTintColor: primaryColor,
      elevation: 2,
    );
  }
}
