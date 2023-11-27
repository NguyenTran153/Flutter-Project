import 'package:flutter/material.dart';
import 'package:flutter_project/utils/colors.dart';

import 'HistoryItem/history_item.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      alignment: Alignment.center,
      child: ListView(
        children: [
          HistoryItem(),
          HistoryItem(),
        ],
      ),
    );
  }
}
