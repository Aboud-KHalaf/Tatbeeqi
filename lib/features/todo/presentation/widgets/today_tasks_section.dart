import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/utils/app_methods.dart';
import 'package:tatbeeqi/features/todo/presentation/manager/todo_cubit.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/empty_today_tasks_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/start_new_chalenge_button_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/today_tasks_list_view_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_error_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_loading_widget.dart';

class TodayTasksSection extends StatelessWidget {
  const TodayTasksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StartNewChallengeButtonWidget(),
        const SizedBox(height: 20.0),
        BlocBuilder<ToDoCubit, ToDoState>(builder: (context, state) {
          if (state is ToDoActionSuccessState) {
            showSnackBarMethod(
                message: state.message!, context: context, isError: false);
          } else if (state is ToDoActionFailureState) {
            showSnackBarMethod(
                message: state.message, context: context, isError: true);
          } else if (state is ToDoErrorState) {
            return ToDoErrorWidget(message: state.message);
          } else if (state is ToDoLoadedState) {
            final now = DateTime.now();
            final toDayToDos = state.todos.where((todo) {
              return todo.dueDate != null &&
                  todo.dueDate!.year == now.year &&
                  todo.dueDate!.month == now.month &&
                  todo.dueDate!.day == now.day;
            }).toList();
            if (toDayToDos.isEmpty) {
              return const EmptyToDayTasksWidget();
            }
            return ToDayTasksListViewWidget(toDayToDos: toDayToDos);
          }
          return const TodoLoadingWidget();
        }),
      ],
    );
  }
}
