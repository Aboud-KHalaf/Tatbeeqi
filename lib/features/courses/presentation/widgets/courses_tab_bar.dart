import 'package:flutter/material.dart';
import 'course_tab_item.dart'; // Import the new widget

class CoursesTabBar extends StatelessWidget {
  final TabController tabController;
  final Function(int) onTabSelected;

  const CoursesTabBar({
    super.key,
    required this.tabController,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isNarrow = screenWidth < 360;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: isNarrow ? 8.0 : 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacity(0.7),
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: TabBar(
          controller: tabController,
          onTap: onTabSelected,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withBlue(
                    (Theme.of(context).primaryColor.blue + 20).clamp(0, 255)),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          labelColor: Theme.of(context).colorScheme.onPrimary,
          unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          splashBorderRadius: BorderRadius.circular(26.0),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return Theme.of(context).primaryColor.withOpacity(0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return Theme.of(context).primaryColor.withOpacity(0.2);
              }
              return null;
            },
          ),
          tabs: [
            _buildTab(context, 'الفصل الأول', 0),
            _buildTab(context, 'الفصل الثاني', 1),
            _buildTab(context, "اخرى", 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String text, int index) {
    final isSelected = tabController.index == index;

    return Tab(
      height: 46,
      child: CourseTabItem(
        text: text,
        isSelected: isSelected,
      ),
    );
  }
}
