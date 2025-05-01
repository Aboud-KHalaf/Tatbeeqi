import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tatbeeqi/features/news/domain/entities/news_item_entity.dart';
import 'package:tatbeeqi/features/news/domain/usecases/get_news_items_usecase.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetNewsItemsUsecase _getNewsItemsUSeCase;

  NewsCubit({required GetNewsItemsUsecase getNewsItemsUsecase})
      : _getNewsItemsUSeCase = getNewsItemsUsecase,
        super(NewsInitialState());

  Future<void> fetchNews() async {
    emit(NewsLoadingState());
    final failureOrNews = await _getNewsItemsUSeCase();
    failureOrNews.fold(
      (failure) => emit(NewsErrorState(failure.message)),
      (news) => emit(NewsLoadedState(news)),
    );
  }
}
