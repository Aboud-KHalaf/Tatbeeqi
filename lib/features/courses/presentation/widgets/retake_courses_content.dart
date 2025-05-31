import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/retake_courses_cubit/retake_courses_cubit.dart';
import 'retake_course_card.dart'; // Import the new card widget

class RetakeCoursesContent extends StatelessWidget {
  final ValueNotifier<List<CourseEntity>> selectedCoursesNotifier;

  const RetakeCoursesContent({super.key, required this.selectedCoursesNotifier});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RetakeCoursesCubit, RetakeCoursesState>(
      builder: (context, state) {
        if (state is CoursesRetakeLoading) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CoursesRetakeError) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline,
                      color: theme.colorScheme.error, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    'Error: ${state.message}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else if (state is CoursesRetakeLoaded) {
          if (state.courseEntities.isEmpty) {
            return const SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'No courses available for retake.', // Consider using AppLocalizations
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5, // Max 50% of screen height
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: state.courseEntities.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final course = state.courseEntities[index];
                return ValueListenableBuilder<List<CourseEntity>>(
                  valueListenable: selectedCoursesNotifier,
                  builder: (_, selectedCoursesList, __) {
                    final isSelected = selectedCoursesList.any((selectedCourse) => selectedCourse.id == course.id);
                    return RetakeCourseCard(
                      course: course,
                      isSelected: isSelected,
                      onChanged: (selected) {
                        final currentSelected = List<CourseEntity>.from(selectedCoursesNotifier.value);
                        if (selected) {
                          if (!currentSelected.any((c) => c.id == course.id)) {
                            currentSelected.add(course);
                          }
                        } else {
                          currentSelected.removeWhere((c) => c.id == course.id);
                        }
                        selectedCoursesNotifier.value = currentSelected;
                      },
                    );
                  },
                );
              },
            ),
          );
        }
        return const SizedBox.shrink(); // For initial or other states
      },
    );
  }
}