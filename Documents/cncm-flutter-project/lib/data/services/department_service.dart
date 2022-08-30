import 'package:cncm_flutter_new/data/models/BanksResponse.dart';
import 'package:cncm_flutter_new/data/models/TitlesResponse.dart';
import 'package:cncm_flutter_new/data/models/UserSearchResponse.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/pages/add_assets_page.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/constants.dart';
import '../../core/util/local_storage_service.dart';
import '../../service_locator.dart';
import '../models/AssociationResponse.dart';
import '../models/DepartmentResponse.dart';
import '../models/ErrorResponse.dart';
import '../models/MembershipPaymentResponse.dart';
import '../models/news_feed.dart';

class DepartmentService {

  Dio dio = Dio(BaseOptions(
    connectTimeout: 5000000,
    receiveTimeout: 5000000,
    headers: {
      'Authorization':
      'Bearer ${sl<LocalStorageService>().getToken}',
      "Content-Type": "application/json",
    },
  ));


  Future<Either<ErrorResponse, DepartmentResponse>> getDepartments() async {
    Response? response;
    try {
      response = await dio.get('$baseUrl/departments');
      return Right(DepartmentResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorResponse.fromJson(response?.data));
      } else {
        throw Exception("Error");
      }
    }
  }

  ///loads assoc
  Future<Either<ErrorResponse, AssociationsResponse>> getAssociations(String departmentId) async {
    Response? response;
    try {
      response = await dio.get('$baseUrl/departments/$departmentId/associations');
      return Right(AssociationsResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        throw Exception("Error");
      }
    }
  }

  ///loads titles for art peoples
  Future<Either<ErrorResponse, TitlesResponse>> getTitles() async {
    Response? response;
    try {
      response = await dio.get('$baseUrl/system-configs/contributor-roles');
      return Right(TitlesResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        throw Exception("Error");
      }
    }
  }
  Future<Either<ErrorResponse, BanksResponse>> getBanks() async {
    Response? response;
    try {
      response = await dio.get('$baseUrl/system-configs/banks');
      return Right(BanksResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        throw Exception("Error");
      }
    }
  }

  Future<Either<ErrorResponse, MembershipPaymentResponse>> getMembershipPayment() async {
    Response? response;
    try {
      response = await dio.get('$baseUrl/system-configs/user-payments');
      return Right(MembershipPaymentResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        throw Exception("Error");
      }
    }
  }

  Future<Either<ErrorResponse, UserSearchResponse>> searchUsers(String user) async {
    Response? response;
    try {
      response = await dio.get('$baseUrl/users?search=$user');
      return Right(UserSearchResponse.fromJson(response.data));
    } catch (e) {
      if (e is DioError) {
        return Left(ErrorResponse.fromJson(e.response?.data));
      } else {
        throw Exception("Error");
      }
    }
  }
}