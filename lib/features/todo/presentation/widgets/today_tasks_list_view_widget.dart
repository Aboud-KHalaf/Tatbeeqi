import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/empty_today_tasks_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/today_tasks_list_view_item_widget.dart';

class ToDayTasksListViewWidget extends StatelessWidget {
  const ToDayTasksListViewWidget({super.key, required this.toDayToDos});
  final List<ToDoEntity> toDayToDos;
  @override
  Widget build(BuildContext context) {
    if (toDayToDos.isEmpty) {
      return const EmptyToDayTasksWidget();
    }

    return MediaQuery.removePadding(
      removeBottom: true,
      context: context,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: toDayToDos.length,
        itemBuilder: (context, index) {
          final task = toDayToDos[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ToDayTaskListViewItemWidget(task: task),
          );
        },
      ),
    );
  }
}
