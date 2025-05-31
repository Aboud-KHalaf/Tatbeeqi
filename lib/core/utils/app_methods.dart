import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/add_edit_todo_form.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarMethod(
    {required String message,
    required BuildContext context,
    required bool isError}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

/////
void showAddEditTodoBottomSheet(BuildContext context, {ToDoEntity? todo}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AddEditToDoForm(initialToDo: todo),
  );
}
