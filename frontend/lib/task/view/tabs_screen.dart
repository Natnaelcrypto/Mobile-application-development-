import "package:flutter/material.dart";
import "package:pro/task/view/pending_screen.dart";

import "../../LocalStroe/Store.dart";
import "../../screens/Drawer.dart";
import "../../user/model/user_model.dart";
import "add_task_screen.dart";
import "completed_tasks_screen.dart";

class TabsScreen extends StatefulWidget {
  final User user;

  const TabsScreen({required this.user});
  static const id = "tabs_screen";

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pageDetails = [
    {"pageName": const PendingTasksScreen(), "title": "Pending Task"},
    {"pageName": const CompletedTasksScreen(), "title": "Completed Task"},
  ];

  var _selectedPageIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          // ignore: prefer_const_constructors
          child: AddTaskScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_selectedPageIndex]["title"]),
        backgroundColor: Color.fromRGBO(36, 130, 50, .6),
      ),
      drawer: Drawerpage(),
      body: _pageDetails[_selectedPageIndex]["pageName"],
      floatingActionButton: _selectedPageIndex == 0
          ? UserPreferences.role.toLowerCase() == "user"
              ? FloatingActionButton(
                  onPressed: () => _addTask(context),
                  tooltip: 'Add Task',
                  child: const Icon(Icons.add),
                  backgroundColor: Color.fromRGBO(161, 103, 74, .6),
                )
              : null
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "Progressing Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: "Completed Tasks")
        ],
      ),
    );
  }
}
