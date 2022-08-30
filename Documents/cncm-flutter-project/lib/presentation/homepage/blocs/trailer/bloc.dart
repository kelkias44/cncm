import 'package:bloc/bloc.dart';

import '../../../../data/repositories/newsfeed_repository.dart';
import 'event.dart';
import 'state.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final NewsFeedRepository newsFeedRepository;

  TrailerBloc(this.newsFeedRepository) : super(InitialState()) {
    on<TrailerEvent>(
      (event, emit) async {
        if (event is LoadTrailerEvent) {
          emit(LoadingTrailer());
          var newsFeeds = await newsFeedRepository.loadTrailerFeed();
          newsFeeds.fold((error) => emit(ErrorGettingTrailer(error)),
              (news) async {
            emit(LoadedTrailer(news.results.newsFeed));
          });
        }
      },
    );
  }
}
