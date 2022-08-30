import 'package:cncm_flutter_new/data/models/news_feed.dart';
import 'package:cncm_flutter_new/data/services/newsfeed_service.dart';
import 'package:dartz/dartz.dart';

import '../models/ErrorResponse.dart';

abstract class NewsFeedRepository {
  Future<Either<ErrorResponse, NewsFeedResponse>> loadNewsFeed();
  Future<Either<ErrorResponse, NewsFeedResponse>> loadTrailerFeed();
}

class NewsFeedRepositoryImpl extends NewsFeedRepository {
  final NewsFeedService newsFeedService;
  NewsFeedRepositoryImpl({required this.newsFeedService});

  ///this one loads [newsFeed]
  @override
  Future<Either<ErrorResponse, NewsFeedResponse>> loadNewsFeed() async {
    var response = await newsFeedService.loadNewsFeed();
    return response.fold((errorResponse) => Left(errorResponse), (
        loginResponse) => Right(loginResponse));
  }
  ///this one loads [trailer]
  @override
  Future<Either<ErrorResponse, NewsFeedResponse>> loadTrailerFeed() async {
    var response = await newsFeedService.loadTrailerFeed();
    return response.fold((errorResponse) => Left(errorResponse), (
        loginResponse) => Right(loginResponse));
  }

}
