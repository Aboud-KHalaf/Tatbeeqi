import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/fetch_courses_cubit/fetch_courses_cubit.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/retake_courses_cubit/retake_courses_cubit.dart';

class RetakeCoursesConfirmButton extends StatelessWidget {
  final ValueNotifier<List<CourseEntity>> selectedCoursesNotifier;
  const RetakeCoursesConfirmButton({
    super.key,
    required this.selectedCoursesNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ValueListenableBuilder<List<CourseEntity>>(
      valueListenable: selectedCoursesNotifier,
      builder: (_, selectedCoursesList, __) {
        final isEnabled = selectedCoursesList.isNotEmpty;
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isEnabled
                ? () {
                    context
                        .read<RetakeCoursesCubit>()
                        .saveRetakeCourses(selectedCoursesList);

                    context.read<FetchCoursesCubit>().fetchCourses(1, 2);

                    Navigator.pop(context);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              disabledBackgroundColor: theme.primaryColor.withOpacity(0.5),
            ),
            child: Text(
              'Retake ${selectedCoursesList.length} Course${selectedCoursesList.length == 1 ? '' : 's'}',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
