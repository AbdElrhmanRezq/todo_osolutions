import 'package:flutter/material.dart';
import 'package:todo_osolutions/core/services/api_service.dart';
import 'package:todo_osolutions/models/task_model.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelected = 0;
  String currentType = 'all';
  final service = ApiService();

  List<TaskModel> tasks = [
    TaskModel(
      title: "Market Research",
      description: "Grocery shopping app design",
      categoryId: 1,
      dueDate: "2025-05-25",
      completed: true,
      imageUrl: null,
    ),
    TaskModel(
      title: "Competitive Analysis",
      description: "Grocery shopping app design",
      categoryId: 1,
      dueDate: "2025-05-25",
      completed: false,
      imageUrl: null,
    ),
    TaskModel(
      title: "Create Low-fidelity Wireframe",
      description: "Uber Eats redesign challenge",
      categoryId: 2,
      dueDate: "2025-05-25",
      completed: false,
      imageUrl: null,
    ),
    TaskModel(
      title: "How to pitch a Design Sprint",
      description: "About design sprint",
      categoryId: 3,
      dueDate: "2025-05-25",
      completed: false,
      imageUrl: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEDEBFF), // light lavender/purple
            Color(0xFFFFF8E7), // pale yellow/cream
          ],
        ),
      ),

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: height * .02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("ToDo", style: theme.textTheme.headlineMedium),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * .015),
                  child: Container(
                    height: height * 0.13,
                    child: ListView.builder(
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: index == 0
                              ? _allCardBuilder(index, width, theme)
                              : _dateCardBuilder(index, width, theme),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * .005),

                  child: Container(
                    height: height * 0.05,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: index == 0
                              ? _typeCardBuilder('all', width, theme)
                              : index == 1
                              ? _typeCardBuilder('Not Completed', width, theme)
                              : _typeCardBuilder('Completed', width, theme),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * .005),
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _taskCardBuilder(
                            tasks[index],
                            height,
                            width,
                            theme,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _taskCardBuilder(
    TaskModel task,
    double height,
    double width,
    ThemeData theme,
  ) {
    return Container(
      height: height * 0.12,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: height * .015),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.categoryId.toString(),
                style: theme.textTheme.labelSmall,
              ),
              Text(task.title, style: theme.textTheme.headlineSmall),
              Row(
                children: [
                  Icon(Icons.timer, color: theme.primaryColor, size: 15),
                  SizedBox(width: 5),
                  Text(task.dueDate ?? ' ', style: theme.textTheme.titleSmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeCardBuilder(String type, double width, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentType = type;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentType == type ? theme.primaryColor : Color(0xffece8fe),
          borderRadius: BorderRadius.circular(12),
        ),
        width: width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              type,
              style: currentType == type
                  ? theme.textTheme.displaySmall
                  : theme.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _allCardBuilder(int index, double width, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentSelected = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentSelected == index
              ? theme.primaryColor
              : theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: width * 0.17,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "All",
              style: currentSelected != index
                  ? theme.textTheme.bodyLarge
                  : theme.textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateCardBuilder(int index, double width, ThemeData theme) {
    List months = [
      'jan',
      'feb',
      'mar',
      'april',
      'may',
      'jun',
      'july',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec',
    ];
    List<String> weekdays = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday",
    ];
    final DateTime date = DateTime.now().add(Duration(days: index - 1));
    final String month = months[date.month - 1];
    final int day = date.day;
    final String weekday = weekdays[date.weekday - 1].substring(0, 3);
    return GestureDetector(
      onTap: () {
        setState(() {
          currentSelected = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: currentSelected == index
              ? theme.primaryColor
              : theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        width: width * 0.17,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              month,
              style: currentSelected != index
                  ? theme.textTheme.bodyMedium
                  : theme.textTheme.displayMedium,
            ),
            Text(
              day.toString(),
              style: currentSelected != index
                  ? theme.textTheme.bodyLarge
                  : theme.textTheme.displayLarge,
            ),
            Text(
              weekday.toString(),
              style: currentSelected != index
                  ? theme.textTheme.bodySmall
                  : theme.textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
