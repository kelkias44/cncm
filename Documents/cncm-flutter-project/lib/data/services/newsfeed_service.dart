import 'package:cncm_flutter_new/core/constants.dart';
import 'package:cncm_flutter_new/data/models/news_feed.dart';
import 'package:cncm_flutter_new/service_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../core/util/local_storage_service.dart';
import '../models/ErrorResponse.dart';



class NewsFeedService {

  Dio dio = Dio(BaseOptions(
    connectTimeout: 5000000,
    receiveTimeout: 5000000,
    headers: {
      'Authorization':
      'Bearer ${sl<LocalStorageService>().getToken}',
      "Content-Type": "application/json",
    },
  ));


  Future<Either<ErrorResponse, NewsFeedResponse>> loadNewsFeed() async {
    Response? response;
    try {
      response = await dio.get(
        '$baseUrl/news-feeds?filters=[{"columnField":"type","operatorValue":"=","value":"$newsFeed"}]&per_page=10&page=0&sort=["time","DESC"]',
      );

      return Right(NewsFeedResponse.fromJson(response.data));

    }catch (e) {
      if (e is DioError) {

        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        debugPrint("Error response from news loading service: $e");
        throw Exception("Error");
      }
    }
  }

  Future<Either<ErrorResponse, NewsFeedResponse>> loadTrailerFeed() async {
    Response? response;
    try {
      response = await dio.get(
        '$baseUrl/news-feeds?filters=[{"columnField":"type","operatorValue":"=","value":"$trailer"}]&per_page=10&page=0&sort=["time","DESC"]',
      );

      return Right(NewsFeedResponse.fromJson(response.data));

    }catch (e) {
      if (e is DioError) {
        debugPrint("THe response date fromm error trailer ${e}");
        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        throw Exception("Error");
      }
    }
  }
  }
