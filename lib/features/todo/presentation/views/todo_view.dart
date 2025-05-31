import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/utils/app_methods.dart';
import 'package:tatbeeqi/features/todo/presentation/manager/todo_cubit.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_list_view_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_empty_state.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_error_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_loading_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_no_data_aviable_widget.dart';
import 'package:tatbeeqi/l10n/app_localizations.dart';

class TodoView extends StatefulWidget {
  static String routePath = '/todoView';

  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView>
    with SingleTickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fabScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fabAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.todoMyToDos),
      ),
      body: BlocConsumer<ToDoCubit, ToDoState>(
        listener: (context, state) {
          if (state is ToDoActionSuccessState) {
            showSnackBarMethod(
                message: state.message!, context: context, isError: false);
          } else if (state is ToDoActionFailureState) {
            showSnackBarMethod(
                message: 'state.message', context: context, isError: true);
          }
        },
        builder: (context, state) {
          if (state is ToDoLoadingState) {
            return const TodoLoadingWidget();
          } else if (state is ToDoErrorState) {
            return ToDoErrorWidget(message: state.message);
          } else if (state is ToDoLoadedState) {
            final todos = state.todos;
            if (todos.isEmpty) {
              return const TodoEmptyState();
            }
            return ToDoListViewWidget(todos: todos);
          }

          return const ToDoNoDataAvaiableWidget();
        },
      ),
      floatingActionButton: _buildToDoViewScaleTransitionFAB(context),
    );
  }

  ScaleTransition _buildToDoViewScaleTransitionFAB(BuildContext context) {
    final theme = Theme.of(context);
    return ScaleTransition(
      scale: _fabScaleAnimation,
      child: FloatingActionButton(
        onPressed: () => showAddEditTodoBottomSheet(context),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 4,
        child: const Icon(Icons.add),
      ),
    );
  }
}
