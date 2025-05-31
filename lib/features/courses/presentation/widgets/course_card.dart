import 'package:flutter/material.dart';
import 'package:tatbeeqi/core/utils/app_functions.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';
import 'course_card_header.dart';
import 'course_card_progress.dart';

class CourseCard extends StatefulWidget {
  final CourseEntity course;
  final int index;

  const CourseCard({super.key, required this.course, required this.index});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500 + (widget.index * 80)),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).colorScheme.surface;
    final progressText = '${(1 * 100).toInt()}%';

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovering = true),
            onExit: (_) => setState(() => _isHovering = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: _isHovering
                  ? (Matrix4.identity()..translate(0, -5, 0))
                  : Matrix4.identity(),
              child: Card(
                elevation: _isHovering ? 8.0 : 4.0,
                shadowColor: Theme.of(context).shadowColor.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: _isHovering
                        ? Theme.of(context).primaryColor.withOpacity(0.5)
                        : Colors.transparent,
                    width: 1.5,
                  ),
                ),
                margin: const EdgeInsets.all(8.0), // Keep margin on Card
                child: InkWell(
                  onTap: () {
                    // TODO: Navigate to course details screen
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  highlightColor:
                      Theme.of(context).primaryColor.withOpacity(0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          cardColor,
                          cardColor.withOpacity(0.95),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CourseCardHeader(
                            iconData: getIconByCourseId(widget.course.id),
                            title: widget.course.courseName,
                          ),
                          const Spacer(),
                          CourseCardProgress(
                            progress: 1.0,
                            progressText: progressText,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
