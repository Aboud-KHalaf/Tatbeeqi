import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/todo/domain/entities/todo_entity.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/bottom_sheet_drag_handle_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_completion_checkbox_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_due_date_selector_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_form_header_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_importance_selector.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_sedcription_field_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_submit_button_widget.dart';
import 'package:tatbeeqi/features/todo/presentation/widgets/todo_title_field_widgets.dart';

class FormContent extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool isEditing;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final ToDoImportance selectedImportance;
  final DateTime? selectedDueDate;
  final bool isCompleted;
  final ValueChanged<ToDoImportance> onImportanceChanged;
  final VoidCallback onSelectDate;
  final VoidCallback onClearDate;
  final ValueChanged<bool?> onCompletionChanged;
  final VoidCallback onSubmit;

  const FormContent({
    super.key,
    required this.formKey,
    required this.isEditing,
    required this.titleController,
    required this.descriptionController,
    required this.selectedImportance,
    required this.selectedDueDate,
    required this.isCompleted,
    required this.onImportanceChanged,
    required this.onSelectDate,
    required this.onClearDate,
    required this.onCompletionChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetDragHandleWidget(),
              const SizedBox(height: 24.0),
              TodoFormHeaderWidget(isEditing: isEditing),
              const SizedBox(height: 24.0),
              TodoTitleFieldWidgets(controller: titleController),
              const SizedBox(height: 16.0),
              TodoDescriptionFieldWidget(controller: descriptionController),
              const SizedBox(height: 24.0),
              TodoImportanceSelector(
                selectedImportance: selectedImportance,
                onImportanceChanged: onImportanceChanged,
              ),
              const SizedBox(height: 24.0),
              TodoDueDateSelectorWidget(
                selectedDueDate: selectedDueDate,
                onSelectDate: onSelectDate,
                onClearDate: onClearDate,
              ),
              if (isEditing) ...[
                const SizedBox(height: 24.0),
                TodoCompletionCheckboxWidget(
                  isCompleted: isCompleted,
                  onChanged: onCompletionChanged,
                ),
              ],
              const SizedBox(height: 32.0),
              TodoSubmitButtonWidget(
                isEditing: isEditing,
                onSubmit: onSubmit,
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
