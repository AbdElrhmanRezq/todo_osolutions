import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_osolutions/core/services/api_service.dart';
import 'package:todo_osolutions/models/category_model.dart';
import 'package:todo_osolutions/models/task_model.dart';

final apiServiceProvider = StateProvider<ApiService>((ref) => ApiService());

//Fliters
final limitFilterProvider = StateProvider<String>((ref) => '');
final offsetFilterProvider = StateProvider<String>((ref) => '');
final categoryFilterProvider = StateProvider<String>((ref) => '');
final completedFilterProvider = StateProvider<String>((ref) => '');
final priorityFilterProvider = StateProvider<String>((ref) => '');

final tasksProvider = FutureProvider<List<TaskModel>>((ref) async {
  final service = ref.watch(apiServiceProvider);
  List<String> filters = [];
  filters.add(ref.watch(limitFilterProvider));
  filters.add(ref.watch(offsetFilterProvider));
  filters.add(ref.watch(categoryFilterProvider));
  filters.add(ref.watch(completedFilterProvider));
  filters.add(ref.watch(priorityFilterProvider));
  return await service.getTasks(filters);
});

final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final service = ref.watch(apiServiceProvider);

  return await service.getCategories();
});
