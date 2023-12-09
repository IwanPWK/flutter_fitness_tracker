import 'package:flutter/material.dart';

import '../utils.dart';
import 'widgets/open_add_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController myController = TextEditingController();
  String? dropDownValue = dropDownMenu['weight'];

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[50],
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Chip(
            elevation: 8,
            padding: const EdgeInsets.all(8),
            backgroundColor: Colors.redAccent,
            deleteIcon: const Icon(Icons.add, color: Colors.white, size: 26),
            onDeleted: () => OpenAddDialog,
            label: const Text(
              'Add',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ));
  }
}
