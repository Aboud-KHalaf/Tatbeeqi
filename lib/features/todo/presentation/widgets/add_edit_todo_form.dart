import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/manager/todo_cubit.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/add_edit_todo_form_content_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_bottom_sheet_container_widget.dart';
import 'package:uuid/uuid.dart';

class AddEditToDoForm extends StatefulWidget {
  final ToDoEntity? initialToDo;

  const AddEditToDoForm({super.key, this.initialToDo});

  @override
  State<AddEditToDoForm> createState() => _AddEditToDoFormState();
}

class _AddEditToDoFormState extends State<AddEditToDoForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  ToDoImportance _selectedImportance = ToDoImportance.low;
  DateTime? _selectedDueDate;
  bool _isCompleted = false;

  bool get _isEditing => widget.initialToDo != null;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeAnimation();
  }

  void _initializeControllers() {
    final initial = widget.initialToDo;
    _titleController = TextEditingController(text: initial?.title ?? '');
    _descriptionController =
        TextEditingController(text: initial?.description ?? '');
    _selectedImportance = initial?.importance ?? ToDoImportance.low;
    _selectedDueDate = initial?.dueDate;
    _isCompleted = initial?.isCompleted ?? false;
  }

  void _initializeAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuad,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );

    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: (mounted) ? context : context,
      initialTime: TimeOfDay.fromDateTime(_selectedDueDate ?? DateTime.now()),
    );

    setState(() {
      _selectedDueDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime?.hour ?? _selectedDueDate?.hour ?? 12,
        pickedTime?.minute ?? _selectedDueDate?.minute ?? 0,
      );
    });
  }

  void _clearDueDate() => setState(() => _selectedDueDate = null);

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    final ToDoEntity todo = ToDoEntity(
      id: widget.initialToDo?.id ?? const Uuid().v4(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      importance: _selectedImportance,
      dueDate: _selectedDueDate,
      isCompleted: _isCompleted, orderIndex: 0,
    );

    _isEditing
        ? context.read<ToDoCubit>().updateToDo(todo)
        : context.read<ToDoCubit>().addToDo(todo);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return FractionallySizedBox(
          heightFactor: 0.1 + (_animation.value * 0.75),
          child: TodoBottomSheetContainerWidget(
            child: FormContent(
              formKey: _formKey,
              isEditing: _isEditing,
              titleController: _titleController,
              descriptionController: _descriptionController,
              selectedImportance: _selectedImportance,
              selectedDueDate: _selectedDueDate,
              isCompleted: _isCompleted,
              onImportanceChanged: (importance) =>
                  setState(() => _selectedImportance = importance),
              onSelectDate: () => _selectDate(context),
              onClearDate: _clearDueDate,
              onCompletionChanged: (value) =>
                  setState(() => _isCompleted = value ?? false),
              onSubmit: _submitForm,
            ),
          ),
        );
      },
    );
  }
}
