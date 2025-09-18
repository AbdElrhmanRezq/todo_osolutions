import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_osolutions/models/category_model.dart';
import 'package:todo_osolutions/models/task_model.dart';
import 'package:todo_osolutions/providers/api_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String id = 'home-screen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenConsumerState();
}

class _HomeScreenConsumerState extends ConsumerState<HomeScreen> {
  int currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String currentType = ref.watch(completedFilterProvider);

    final tasksAsync = ref.watch(tasksProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    int taskCount = 0;

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
                  child: Text("Tasks", style: theme.textTheme.headlineMedium),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * .005),

                  child: Container(
                    height: height * 0.05,
                    child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: index == 0
                              ? _typeCardBuilder('', width, theme, ref)
                              : index == 1
                              ? _typeCardBuilder('false', width, theme, ref)
                              : index == 2
                              ? _typeCardBuilder('true', width, theme, ref)
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffece8fe),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: categoriesAsync.when(
                                    data: (categories) => IconButton(
                                      onPressed: () {
                                        _showButtomSheet(
                                          context,
                                          width,
                                          height,
                                          ref,
                                          theme,
                                          categories,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.filter_alt_rounded,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                    error: (error, stackTrace) => Center(
                                      child: Text(
                                        "Something went wrong: $error",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                    ),
                                    loading: () => Expanded(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
                tasksAsync.when(
                  data: (tasks) {
                    taskCount = tasks.length;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height * .005),
                        child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return categoriesAsync.when(
                              data: (categories) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: _taskCardBuilder(
                                    tasks[index],
                                    height,
                                    width,
                                    theme,
                                    categories,
                                  ),
                                );
                              },
                              error: (error, stackTrace) => Center(
                                child: Text(
                                  "Something went wrong: $error",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                              loading: () => Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text("Something went wrong: $error")),
                  loading: () => Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (ref.watch((offsetFilterProvider)) != '0') {
                          ref.read(offsetFilterProvider.notifier).state =
                              (int.parse(ref.watch((offsetFilterProvider))) - 1)
                                  .toString();
                        }
                      },
                      icon: Icon(Icons.arrow_back, color: theme.primaryColor),
                    ),
                    Text(
                      (int.parse(ref.watch((offsetFilterProvider))) + 1)
                          .toString(),
                      style: theme.textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: () {
                        if (taskCount ==
                            int.parse(ref.watch(limitFilterProvider))) {
                          ref.read(offsetFilterProvider.notifier).state =
                              (int.parse(ref.watch((offsetFilterProvider))) + 1)
                                  .toString();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('No More tasks')),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
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
    List<CategoryModel> categories,
  ) {
    final cat = categories.firstWhere(
      (element) => element.id == task.categoryId,
    );

    final catIconUrl = cat.iconUrl.split('?')[0];
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
              Row(
                children: [
                  Container(
                    width: width * 0.035,
                    height: height * 0.035,
                    child: SvgPicture.network(catIconUrl),
                  ),
                  SizedBox(width: width * 0.02),
                  Text(cat.name, style: theme.textTheme.labelSmall),
                ],
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
                  task.priority?.toUpperCase() ?? ' ',
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

  Widget _typeCardBuilder(
    String type,
    double width,
    ThemeData theme,
    WidgetRef ref,
  ) {
    return GestureDetector(
      onTap: () {
        ref.watch(completedFilterProvider.notifier).state = type;
        ref.invalidate(tasksProvider);
      },
      child: Container(
        decoration: BoxDecoration(
          color: ref.watch(completedFilterProvider) == type
              ? theme.primaryColor
              : Color(0xffece8fe),
          borderRadius: BorderRadius.circular(12),
        ),
        width: width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              type == ''
                  ? "All"
                  : type == 'true'
                  ? "Completed"
                  : "Not completed",
              style: ref.watch(completedFilterProvider) == type
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

  _showButtomSheet(
    BuildContext context,
    double width,
    double height,
    WidgetRef ref,
    ThemeData theme,
    List<CategoryModel> categories,
  ) {
    showModalBottomSheet(
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return Container(
          height: height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: ListView(
            children: [
              SizedBox(height: height * 0.01),

              Divider(
                color: Colors.grey,
                radius: BorderRadius.circular(12),
                endIndent: width * 0.35,
                indent: width * 0.35,
                thickness: 4,
              ),
              SizedBox(height: height * 0.01),
              Center(
                child: Text("Filters", style: theme.textTheme.headlineMedium),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Text("Priority"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * 0.05,
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      List<String> prios = ['low', 'medium', 'high'];
                      return index == 0
                          ? _priorityCardBuilder('', width, theme, ref)
                          : _priorityCardBuilder(
                              prios[index - 1],
                              width,
                              theme,
                              ref,
                            );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Text("Date order"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height * 0.05,
                  child: ListView.builder(
                    itemCount: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      List<String> orders = ['desc', 'asc'];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: GestureDetector(
                          onTap: () {
                            index == 0
                                ? ref.read(orderFilterProvider.notifier).state =
                                      'desc'
                                : ref.read(orderFilterProvider.notifier).state =
                                      'asc';
                            ref.invalidate(tasksProvider);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  ref.watch(orderFilterProvider) ==
                                      orders[index]
                                  ? theme.primaryColor
                                  : Color(0xffece8fe),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: width * 0.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  orders[index],
                                  style:
                                      ref.watch(orderFilterProvider) ==
                                          orders[index]
                                      ? theme.textTheme.displaySmall
                                      : theme.textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date order"),
                    DropdownButton<CategoryModel>(
                      dropdownColor: Colors.white,
                      items: categories.map(_buildMenuItems).toList(),
                      value: categories.firstWhere(
                        (element) =>
                            element.id.toString() ==
                            ref.watch(categoryFilterProvider),
                        orElse: () =>
                            categories.first, // fallback to avoid crash
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(categoryFilterProvider.notifier).state =
                              (value.id).toString();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DropdownMenuItem<CategoryModel> _buildMenuItems(CategoryModel category) =>
      DropdownMenuItem<CategoryModel>(
        value: category,
        child: Text(category.name),
      );

  Widget _priorityCardBuilder(
    String priority,
    double width,
    ThemeData theme,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          ref.read(priorityFilterProvider.notifier).state = priority;
          ref.invalidate(tasksProvider);
        },
        child: Container(
          decoration: BoxDecoration(
            color: ref.watch(priorityFilterProvider) == priority
                ? theme.primaryColor
                : Color(0xffece8fe),
            borderRadius: BorderRadius.circular(12),
          ),
          width: width * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                priority == '' ? "All" : priority,
                style: ref.watch(priorityFilterProvider) == priority
                    ? theme.textTheme.displaySmall
                    : theme.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
