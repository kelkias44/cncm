import 'package:cncm_flutter_new/data/models/news_feed.dart';
import 'package:cncm_flutter_new/data/repositories/newsfeed_repository.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newfeed_state.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newsfeed_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsFeedBloc extends Bloc<NewFeedEvent, NewsFeedState> {
  final NewsFeedRepository newsFeedRepository;

  NewsFeedBloc(this.newsFeedRepository) : super(InitialState()) {
    on<NewFeedEvent>((event, emit) async {
      if (event is LoadNewsFeed) {
         emit(LoadingNewFeed());
         var newsFeeds = await newsFeedRepository.loadNewsFeed();
         newsFeeds.fold(
                 (error) => emit(ErrorGettingFeeds(error)),
                 (news) async {emit(LoadedNewsFeed(news.results.newsFeed));});

      }
    },

    );
}
}