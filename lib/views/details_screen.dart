import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_osolutions/core/services/api_service.dart';
import 'package:todo_osolutions/models/category_model.dart';
import 'package:todo_osolutions/models/task_model.dart';
import 'package:todo_osolutions/providers/api_provider.dart';

class DetailsScreen extends ConsumerWidget {
  static const String id = 'details-screen';
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final TaskModel task = args['task'];
    final CategoryModel category = args['category'];
    final String catIconUrl = args['catIconUrl'];

    final taskAsync = ref.watch(singleTaskProvider(task.id.toString()));

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEDEBFF), // light lavender/purple
            Color(0xFFFFF8E7), // pale yellow/cream
          ],
        ),
      ),
      child: taskAsync.when(
        data: (task) => Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: Icon(Icons.arrow_back, color: Colors.black),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await ref.read(apiServiceProvider).deleteTask(task);
                  ref.invalidate(tasksProvider);
                  Navigator.of(context).pop();
                },
                icon: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Icon(Icons.delete, color: Colors.black),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: width,
                      height: height * 0.45,
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Image.network(
                          task.imageUrl ?? ' ',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.04,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                task.title,
                                style: theme.textTheme.headlineLarge,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(width: width * 0.05),
                            Container(
                              decoration: BoxDecoration(
                                color: task.priority == 'high'
                                    ? Color.fromARGB(255, 254, 224, 224)
                                    : task.priority == 'low'
                                    ? Color.fromARGB(255, 255, 253, 227)
                                    : Color.fromARGB(255, 227, 240, 255),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    // Image.asset(
                                    //   width: width * 0.05,
                                    //   height: height * 0.05,
                                    //   'assets/images/fire.png',
                                    //   color: task.priority == 'high'
                                    //       ? Color.fromARGB(255, 254, 88, 88)
                                    //       : task.priority == 'low'
                                    //       ? Color.fromARGB(255, 252, 180, 0)
                                    //       : Color.fromARGB(255, 30, 135, 255),
                                    // ),s
                                    Icon(
                                      Icons.priority_high,
                                      color: task.priority == 'high'
                                          ? Color.fromARGB(255, 254, 88, 88)
                                          : task.priority == 'low'
                                          ? Color.fromARGB(255, 252, 180, 0)
                                          : Color.fromARGB(255, 30, 135, 255),
                                    ),
                                    SizedBox(width: width * 0.01),
                                    Text(
                                      task.priority?.toUpperCase() ?? ' ',
                                      style: TextStyle(
                                        color: task.priority == 'high'
                                            ? Color.fromARGB(255, 254, 88, 88)
                                            : task.priority == 'low'
                                            ? Color.fromARGB(255, 252, 180, 0)
                                            : Color.fromARGB(255, 30, 135, 255),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          task.description ?? ' ',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 68, 68, 68),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          children: [
                            Container(
                              width: width * 0.05,
                              height: height * 0.05,
                              child: SvgPicture.network(catIconUrl),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Category:",
                              style: theme.textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 5),
                            Text(
                              category.name,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: theme.primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Due Date:",
                              style: theme.textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 5),
                            Text(
                              task.dueDate ?? ' ',
                              style: theme.textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: theme.primaryColor,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(
                              "Created at:",
                              style: theme.textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 5),
                            Text(
                              task.createdAt?.split('T')[0] ?? ' ',
                              style: theme.textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: height * 0.05,
                left: width * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: width * 0.2,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        task.completed == true ? Icons.check : Icons.timer,
                        color: theme.primaryColor,
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    Container(
                      width: width * 0.65,
                      height: height * 0.07,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: task.completed == true
                              ? Color.fromARGB(255, 117, 82, 225)
                              : theme.primaryColor,
                        ),
                        onPressed: () async {
                          task.completed == true
                              ? task.completed = false
                              : task.completed = true;
                          final ApiService service = ref.watch(
                            apiServiceProvider,
                          );
                          final responseTask = await service.editTask(task);
                          ref.invalidate(
                            singleTaskProvider(task.id.toString()),
                          );
                          ref.invalidate(tasksProvider);
                        },
                        child: Text(
                          task.completed == true
                              ? "Completed"
                              : "Mark As Completed",
                          style: theme.textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        error: (error, stackTrace) =>
            Center(child: Text("Something went wrong: $error")),
        loading: () =>
            Expanded(child: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
