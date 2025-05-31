import 'package:flutter/material.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';
import 'package:tatbeeqi/features/courses/presentation/widgets/course_card.dart';

class CoursesGridWidget extends StatelessWidget {
  final List<CourseEntity> courses;
  final bool isTablet;
  final int selectedTabIndex;

  const CoursesGridWidget({
    super.key,
    required this.courses,
    required this.isTablet,
    required this.selectedTabIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isTablet ? 3 : 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 12.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return CourseCard(
            course: courses[index],
            index: index,
          );
        },
        childCount: courses.length,
      ),
    );
  }
}
