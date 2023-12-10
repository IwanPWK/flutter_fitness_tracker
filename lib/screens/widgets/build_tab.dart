import 'package:flutter/material.dart';

// import '../../global_var.dart';
import '../../utils.dart';

class BuildTab extends StatefulWidget {
  final String text;
  String selectedTab;
  final Function(String) onTabSelected;
  BuildTab(
      {super.key,
      required this.text,
      required this.onTabSelected,
      required this.selectedTab});

  @override
  State<BuildTab> createState() => _BuildTabState();
}

class _BuildTabState extends State<BuildTab> {
  // String? selectedTab = tabMenu['all']; // Nilai selectedTab
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: InkWell(
        onTap: () => setState(() {
          widget.selectedTab = widget.text;
          widget.onTabSelected(widget.text);
        }),
        child: Chip(
          elevation: 10,
          backgroundColor: widget.selectedTab == widget.text
              ? Colors.redAccent
              : Colors.white,
          label: Text(
            widget.text,
            style: widget.selectedTab == widget.text
                ? textStyle(18, Colors.white, FontWeight.w600)
                : textStyle(18, Colors.blueGrey, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
