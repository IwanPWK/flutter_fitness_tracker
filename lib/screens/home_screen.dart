import 'package:flutter/material.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:intl/intl.dart';

import '../database/database_service.dart';
// import '../global_var.dart';
import '../models/activity.dart';
import '../utils.dart';
import 'widgets/build_tab.dart';
import 'widgets/open_add_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final TextEditingController myController = TextEditingController();
  // String dropDownValue = dropDownMenu['weight']!;
  String selectedTab = tabMenu['all']!; // Nilai selectedTab

  // @override
  // void dispose() {
  //   myController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // selectedTab = tabMenu['all'];
    return Scaffold(
      backgroundColor: Colors.orange[50],
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Chip(
          elevation: 8,
          padding: const EdgeInsets.all(8),
          backgroundColor: Colors.redAccent,
          deleteIcon: const Icon(Icons.add, color: Colors.white, size: 26),
          onDeleted: () {
            // print('push');
            showDialog(
              context:
                  context, // Gunakan context yang valid dari mana Anda memanggil Chip
              builder: (BuildContext context) {
                return const OpenAddDialog();
              },
            );
          },
          label: const Text(
            'Add',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          //Heading and Chips section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Text(
                    'Iwan Fitness Tracker',
                    style: textStyle(
                      40,
                      Colors.blueGrey,
                      FontWeight.w600,
                      fontType: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        BuildTab(
                          text: 'All',
                          selectedTab: selectedTab,
                          onTabSelected: (tabText) {
                            setState(() {
                              selectedTab =
                                  tabText; // Update nilai selectedTab saat tab dipilih
                            });
                          },
                        ),
                        BuildTab(
                          text: 'Weight',
                          selectedTab: selectedTab,
                          onTabSelected: (tabText) {
                            setState(() {
                              selectedTab =
                                  tabText; // Update nilai selectedTab saat tab dipilih
                            });
                          },
                        ),
                        BuildTab(
                          text: 'Set',
                          selectedTab: selectedTab,
                          onTabSelected: (tabText) {
                            setState(() {
                              selectedTab =
                                  tabText; // Update nilai selectedTab saat tab dipilih
                            });
                          },
                        ),
                        BuildTab(
                          text: 'Repetition',
                          selectedTab: selectedTab,
                          onTabSelected: (tabText) {
                            setState(() {
                              selectedTab =
                                  tabText; // Update nilai selectedTab saat tab dipilih
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          //Activites/Rows section
          FutureBuilder<List<Map<String, Object?>>>(
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              //If the Future is resolved
              if (snapshot.connectionState == ConnectionState.done) {
                //If the Future has resolved with error
                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  );
                }
                //If the Future has resolved with data
                else if (snapshot.hasData) {
                  List<Activity> activityList = List<Activity>.generate(
                    snapshot.data!.length,
                    (index) => Activity(
                      snapshot.data![index][DatabaseService.columnId],
                      snapshot.data![index][DatabaseService.date],
                      snapshot.data![index][DatabaseService.data],
                      snapshot.data![index][DatabaseService.type],
                    ),
                  );
                  return SliverGroupedListView<Activity, String>(
                    elements: activityList,
                    groupBy: (Activity activity) => DateFormat.MMMd().format(
                      DateTime.parse(activity.date),
                    ),
                    groupSeparatorBuilder: (String groupByValue) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        groupByValue,
                        style: textStyle(
                          20,
                          Colors.black,
                          FontWeight.w600,
                          fontType: 1,
                        ),
                      ),
                    ),
                    itemBuilder: (BuildContext context, Activity activity) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image(
                                width: 50,
                                height: 50,
                                image: activity.type == 'weight'
                                    ? const AssetImage(
                                        'assets/images/weight.png')
                                    : const AssetImage(
                                        'assets/images/height.png'),
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                activity.type == 'weight'
                                    ? '${activity.data} kg'
                                    : activity.type == 'set'
                                        ? '${activity.data} set'
                                        : 'rep',
                                style: textStyle(
                                  20,
                                  Colors.black,
                                  FontWeight.w600,
                                  fontType: 3,
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () async => await deleteTab(activity),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              //If the Future has not resolved yet
              return const SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            future: DatabaseService().getActivities(selectedTab),
          ),
        ],
      ),
    );
  }

  Future<void> deleteTab(Activity activity) async {
    await DatabaseService().deleteActivity(activity.id);
    setState(() {});
  }
}
