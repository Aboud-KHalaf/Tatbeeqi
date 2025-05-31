import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tatbeeqi/core/error/exceptions.dart';
import 'package:tatbeeqi/core/utils/app_logger.dart';
import 'package:tatbeeqi/features/news/data/models/news_item_model.dart';

abstract class NewsRemoteDataSource {
  /// Fetches the list of [NewsItemModel] from the remote source (Supabase).
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<NewsItemModel>> getNewsItems();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final SupabaseClient supabaseClient;

  NewsRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<NewsItemModel>> getNewsItems() async {
    try {
      final response = await supabaseClient
          .from('news')
          .select()
          .order('date', ascending: false); // Order by creation date

      return response.map((item) => NewsItemModel.fromJson(item)).toList();
    } on PostgrestException catch (e) {
      AppLogger.error('Supabase Error: ${e.message}');
      throw ServerException(e.message);
    } catch (e) {
      AppLogger.error('Generic Error fetching news: $e');
      throw ServerException('Failed to load news items');
    }
  }
}
