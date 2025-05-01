import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskItemEntity {
  final String title;
  bool isDone;

  TaskItemEntity({required this.title, this.isDone = false});
}

class TodayTasksSection extends StatefulWidget {
  const TodayTasksSection({super.key});

  @override
  State<TodayTasksSection> createState() => _TodayTasksSectionState();
}

class _TodayTasksSectionState extends State<TodayTasksSection> {
  final List<TaskItemEntity> _tasks = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // "Start a new challenge" Button
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary.withOpacity(0.8),
                colorScheme.primaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add_circle_outline, size: 20),
            label: Text(
              l10n.homeStartNewChallenge,
              style: textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              backgroundColor: Colors.transparent,
              foregroundColor: colorScheme.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {
              // TODO: Implement action for adding a new challenge/task
            },
          ),
        ),
        const SizedBox(height: 20.0),

        _buildTasksList(context),
      ],
    );
  }

  Widget _buildTasksList(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    if (_tasks.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: colorScheme.outline.withOpacity(0.1)),
        ),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.task_alt,
                size: 40,
                color: colorScheme.outline.withOpacity(0.7),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.homeNoTasksForToday,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: task.isDone
                ? colorScheme.surfaceContainerHighest.withOpacity(0.3)
                : colorScheme.surfaceContainerHighest.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: task.isDone
                  ? colorScheme.outline.withOpacity(0.1)
                  : colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                    color: task.isDone
                        ? colorScheme.outline
                        : colorScheme.onSurfaceVariant,
                    fontWeight:
                        task.isDone ? FontWeight.normal : FontWeight.w500,
                  ),
                ),
              ),
              Transform.scale(
                scale: 1.1,
                child: Checkbox(
                  value: task.isDone,
                  onChanged: (bool? value) {
                    setState(() {
                      task.isDone = value ?? false;
                    });
                    // TODO: Update task status (e.g., call Cubit method)
                  },
                  activeColor: colorScheme.primary,
                  checkColor: colorScheme.onPrimary,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(
                    color: task.isDone
                        ? colorScheme.primary
                        : colorScheme.outline.withOpacity(0.7),
                    width: 1.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
    );
  }
}
