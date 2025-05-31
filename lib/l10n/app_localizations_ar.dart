// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get homeGreeting => 'مرحبا عبود';

  @override
  String get homeContinueLearning => 'واصل التعلم, انت تصنع مستقبلك';

  @override
  String get homeLatestNewsAndEvents => 'آخر الاخبار والاحداث';

  @override
  String get homeNoNewsAvailable => 'لا توجد أخبار متاحة';

  @override
  String get homeAnotherNewsItem => 'خبر آخر';

  @override
  String get homeNewsDescription => 'وصف للخبر الثاني هنا.';

  @override
  String get homeThirdEvent => 'الحدث الثالث';

  @override
  String get homeThirdEventDetails => 'تفاصيل حول الحدث الثالث القادم قريبًا.';

  @override
  String get homeTodayTasks => 'مهام اليوم';

  @override
  String get homeStartNewChallenge => 'ابدأ تحدي جديد اليوم';

  @override
  String get homeNoTasksForToday => 'لا توجد مهام لليوم!';

  @override
  String get homeReviewChapterOne => 'مراجعة الفصل الاول';

  @override
  String get homeSolveMathHomework => 'حل واجب الرياضيات';

  @override
  String get homeContinueStudying => 'تابع الدراسة';

  @override
  String get homeRecentlyAdded => 'المضافة مؤخرا';

  @override
  String get homeAdvancedSoftwareEngineering =>
      'هندسة برمجيات متقدمة - الفصل 3';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navCourses => 'المقررات';

  @override
  String get navCommunity => 'المجتمع';

  @override
  String get navMore => 'المزيد';

  @override
  String get todoMyToDos => 'مهامي';

  @override
  String get todoEditTask => 'تعديل المهمة';

  @override
  String get todoAddNewTask => 'اضافة مهمة جديدة';

  @override
  String get todoNoTasks => 'لا توجد مهام بعد';

  @override
  String get todoAddFirstTask => 'أضف مهمتك الأولى بالنقر على زر + أدناه';

  @override
  String get todoSetDueDate => 'تعيين تاريخ الاستحقاق (اختياري)';

  @override
  String todoDueDate(String date) {
    return 'الاستحقاق: $date';
  }

  @override
  String get todoUpdateTask => 'تحديث المهمة';

  @override
  String get todoAddTask => 'إضافة مهمة';

  @override
  String get todoMarkAsCompleted => 'وضع علامة كمكتمل';

  @override
  String get todoLoadingTasks => 'جاري تحميل المهام...';

  @override
  String get todoNoDataAvailable => 'لا توجد بيانات متاحة';

  @override
  String get newsNoNewsAvailable => 'لا توجد أخبار متاحة';

  @override
  String get newsCheckBackLater => 'تحقق لاحقًا للحصول على التحديثات';

  @override
  String get tryAgain => 'حاول مرة اخرى';

  @override
  String get todoTitle => 'العنوان';

  @override
  String get todoEnterTitle => 'الرجاء إدخال عنوان';

  @override
  String get todoDescription => 'الوصف';

  @override
  String get todoImportance => 'الأهمية';

  @override
  String get todoImportanceLow => 'منخفضة';

  @override
  String get todoImportanceMedium => 'متوسطة';

  @override
  String get todoImportanceHigh => 'عالية';

  @override
  String get todoNoDueDate => 'لا يوجد تاريخ استحقاق';

  @override
  String get todoConfirmDelete => 'تأكيد الحذف';

  @override
  String get todoDeleteConfirmation => 'هل أنت متأكد أنك تريد حذف هذا العنصر؟';

  @override
  String get todoCancel => 'إلغاء';

  @override
  String get todoDelete => 'حذف';
}
