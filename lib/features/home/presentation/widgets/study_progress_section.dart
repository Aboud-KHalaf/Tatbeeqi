import 'package:flutter/material.dart';
import 'package:tatbeeqi/core/utils/app_data.dart';

class StudyProgressSection extends StatelessWidget {
  const StudyProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SizedBox(
      height: 130, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Container(
            width: 110, // Adjust width as needed
            margin: const EdgeInsetsDirectional.only(
                end: 12.0), // Margin for spacing
            child: Card(
              elevation: 1.0,
              color: course.color
                  .withOpacity(0.15), // Use course color with opacity
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: course.color.withOpacity(0.3))),
              child: InkWell(
                // Make card tappable
                onTap: () {
                  // TODO: Navigate to course details
                },
                borderRadius: BorderRadius.circular(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        course.iconPath,
                        height: 40,
                        width: 40,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.school,
                          size: 40,
                          color: course.color,
                        ), // Fallback icon
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        course.title,
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
