//Opening the dialog box

import 'package:flutter/material.dart';

import '../../database/database_service.dart';
import '../../utils.dart';

// ignore: must_be_immutable
class OpenAddDialog extends StatefulWidget {
  // final BuildContext context;
  const OpenAddDialog({super.key});

  @override
  State<OpenAddDialog> createState() => _OpenAddDialogState();
}

class _OpenAddDialogState extends State<OpenAddDialog> {
  final TextEditingController myController = TextEditingController();
  String? dropDownValue = dropDownMenu['weight'];
  String? selectedTab = tabMenu['all'];

  //cleaning up the TextEditingController
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  //For adding data to database
  Future<void> addTab() async {
    final dbServiceInstance = DatabaseService();
    await dbServiceInstance.addActivity({
      DatabaseService.type: dropDownValue!.toLowerCase(),
      DatabaseService.data: double.parse(myController.text),
      DatabaseService.date: DateTime.now().toString()
    });
    myController.clear();
    if (!mounted) return;
    Navigator.of(context).pop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StatefulBuilder(
        builder: (_, StateSetter stateSetter) {
          return SizedBox(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    'Add',
                    style: textStyle(28, Colors.black, FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 2,
                        child: TextFormField(
                          controller: myController,
                          decoration: InputDecoration(
                              hintText: dropDownValue == dropDownMenu['weight']
                                  ? 'In kg'
                                  : dropDownValue == dropDownMenu['set']
                                      ? 'Set'
                                      : 'Rep',
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black))),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: DropdownButton(
                          hint: Text(
                            'Choose',
                            style: textStyle(
                              18,
                              Colors.black,
                              FontWeight.w600,
                            ),
                          ),
                          onChanged: (dynamic value) {
                            stateSetter(() {
                              dropDownValue = value;
                            });
                          },
                          dropdownColor: Colors.white70,
                          value: dropDownValue,
                          items: [
                            DropdownMenuItem(
                              value: dropDownMenu['weight'],
                              child: Text(
                                'Weight',
                                style: textStyle(
                                  18,
                                  Colors.black,
                                  FontWeight.w600,
                                  fontType: 3,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: dropDownMenu['set'],
                              child: Text(
                                'Height',
                                style: textStyle(
                                  18,
                                  Colors.black,
                                  FontWeight.w600,
                                  fontType: 3,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: dropDownMenu['repetition'],
                              child: Text(
                                'Height',
                                style: textStyle(
                                  18,
                                  Colors.black,
                                  FontWeight.w600,
                                  fontType: 3,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: IconButton(
                      color: Colors.redAccent,
                      iconSize: 60,
                      icon: const Icon(
                        Icons.double_arrow_outlined,
                      ),
                      onPressed: () async => await addTab(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
