import 'package:flutter/material.dart';

import '../../utils.dart';

class BuildTab extends StatefulWidget {
  final String text;
  const BuildTab({super.key, required this.text});

  @override
  State<BuildTab> createState() => _BuildTabState();
}

class _BuildTabState extends State<BuildTab> {
  String? selectedTab = tabMenu['all'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: InkWell(
        onTap: () => setState(() {
          selectedTab = widget.text;
        }),
        child: Chip(
          elevation: 10,
          backgroundColor:
              selectedTab == widget.text ? Colors.redAccent : Colors.white,
          label: Text(
            widget.text,
            style: selectedTab == widget.text
                ? textStyle(18, Colors.white, FontWeight.w600)
                : textStyle(18, Colors.blueGrey, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
