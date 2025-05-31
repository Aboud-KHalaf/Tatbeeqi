import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/core/constants/constants.dart';
import 'package:tatbeeqi/features/courses/domain/entities/course_entity.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/fetch_courses_cubit/fetch_courses_cubit.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/fetch_courses_cubit/fetch_courses_state.dart';
import 'package:tatbeeqi/features/courses/presentation/manager/retake_courses_cubit/retake_courses_cubit.dart';
import 'package:tatbeeqi/features/courses/presentation/widgets/courses_app_bar.dart';
import 'package:tatbeeqi/features/courses/presentation/widgets/courses_grid_widget.dart';
import 'package:tatbeeqi/features/courses/presentation/widgets/courses_tab_bar.dart';
import 'package:tatbeeqi/features/courses/presentation/widgets/empty_courses_widget.dart';
import 'package:tatbeeqi/features/courses/presentation/widgets/retake_courses_bottom_sheet.dart'; // Add this import

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (!_tabController.indexIsChanging &&
        mounted &&
        _tabController.index != _selectedTabIndex) {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: const CoursesAppBar(),
      body: BlocBuilder<FetchCoursesCubit, FetchCoursesState>(
        builder: (context, state) {
          if (state is CoursesError) {
            return const Center(child: Text('Error loading courses'));
          } else if (state is CoursesLoaded) {
            return _buildCoursesContent(state.courseEntities, isTablet);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildCoursesContent(List<CourseEntity> courses, bool isTablet) {
    final filteredCourses = courses
        .where((course) => course.semester == _selectedTabIndex + 1)
        .toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CoursesTabBar(
            tabController: _tabController,
            onTabSelected: (index) => _tabController.animateTo(index),
          ),
        ),
        if (filteredCourses.isEmpty)
          SliverFillRemaining(
            child: EmptyCoursesWidget(
              key: ValueKey('empty_$_selectedTabIndex'),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            sliver: CoursesGridWidget(
              courses: filteredCourses,
              isTablet: isTablet,
              selectedTabIndex: _selectedTabIndex,
            ),
          ),
        const SliverToBoxAdapter(
          child: SizedBox(height: AppConstants.totalBottomPaddingForContent),
        ),
      ],
    );
  }

  Widget? _buildFloatingActionButton(BuildContext context) {
    if (_selectedTabIndex != 2) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(
          bottom:
              AppConstants.totalBottomPaddingForContent), // Use your constant
      child: FloatingActionButton(
        onPressed: _onAddCoursePressed, // This will now call the updated method
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 4,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }

  void _onAddCoursePressed() {
    const int currentUserStudyYear = 3;
    const int currentUserDepartmentId = 1;

    context.read<RetakeCoursesCubit>().fetchAllCoursesForRetake(
          studyYear: currentUserStudyYear,
          departmentId: currentUserDepartmentId,
        );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: BlocProvider.of<FetchCoursesCubit>(context),
          child: const RetakeCoursesBottomSheet(),
        );
      },
    );
  }
}
