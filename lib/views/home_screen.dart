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
  String currentType = 'All';
  final service = ApiService();

  List<TaskModel> tasks = [
    TaskModel(
      id: 1,
      title: "Market Research",
      description: "Grocery shopping app design",
      priority: "high",
      categoryId: 1,
      dueDate: "2025-05-25",
      completed: true,
      imageUrl: "https://picsum.photos/400/300?random=101&grayscale",
      createdAt: "2025-05-20T09:00:00Z",
      updatedAt: "2025-05-21T09:00:00Z",
    ),
    TaskModel(
      id: 2,
      title: "Competitive Analysis",
      description: "Grocery shopping app design",
      priority: "medium",
      categoryId: 1,
      dueDate: "2025-05-25",
      completed: false,
      imageUrl: "https://picsum.photos/400/300?random=102&grayscale",
      createdAt: "2025-05-20T10:00:00Z",
      updatedAt: "2025-05-21T10:00:00Z",
    ),
    TaskModel(
      id: 3,
      title: "Create Low-fidelity Wireframe",
      description: "Uber Eats redesign challenge",
      priority: "low",
      categoryId: 2,
      dueDate: "2025-05-25",
      completed: false,
      imageUrl: "https://picsum.photos/400/300?random=103&grayscale",
      createdAt: "2025-05-20T11:00:00Z",
      updatedAt: "2025-05-21T11:00:00Z",
    ),
    TaskModel(
      id: 4,
      title: "How to pitch a Design Sprint",
      description: "About design sprint",
      priority: "high",
      categoryId: 3,
      dueDate: "2025-05-25",
      completed: false,
      imageUrl: "https://picsum.photos/400/300?random=104&grayscale",
      createdAt: "2025-05-20T12:00:00Z",
      updatedAt: "2025-05-21T12:00:00Z",
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
                              ? _typeCardBuilder('All', width, theme)
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
      width: width * 0.6,
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
              Text(
                task.title,
                style: theme.textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(Icons.timer, color: theme.primaryColor, size: 15),
                  SizedBox(width: 5),
                  Text(
                    task.dueDate ?? ' ',
                    style: theme.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                color: task.priority == 'high'
                    ? Color.fromARGB(255, 254, 224, 224)
                    : task.priority == 'low'
                    ? Color.fromARGB(255, 255, 253, 227)
                    : Color.fromARGB(255, 227, 240, 255),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  task.priority ?? ' ',
                  style: TextStyle(
                    color: task.priority == 'high'
                        ? Color.fromARGB(255, 254, 88, 88)
                        : task.priority == 'low'
                        ? Color.fromARGB(255, 252, 180, 0)
                        : Color.fromARGB(255, 30, 135, 255),
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.2,
              height: height * 0.02,
              decoration: BoxDecoration(
                color: task.completed == true
                    ? Color(0xfffee9e0)
                    : Color(0xffe3f2ff),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  task.completed == true ? "Completed" : "Not Completed",
                  style: TextStyle(
                    color: task.completed == true
                        ? Color(0xfffe8158)
                        : Color(0xff1e95ff),
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
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
