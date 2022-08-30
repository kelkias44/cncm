import 'package:cncm_flutter_new/data/models/BanksResponse.dart';
import 'package:cncm_flutter_new/data/models/DepartmentResponse.dart';
import 'package:cncm_flutter_new/data/models/TitlesResponse.dart';
import 'package:cncm_flutter_new/data/models/UserSearchResponse.dart';
import 'package:cncm_flutter_new/data/services/department_service.dart';
import 'package:dartz/dartz.dart';

import '../models/AssociationResponse.dart';
import '../models/ErrorResponse.dart';
import '../models/MembershipPaymentResponse.dart';


abstract class DepartmentRepository {
  Future<Either<ErrorResponse, DepartmentResponse>> getDepartments();
  Future<Either<ErrorResponse, AssociationsResponse>> getAssociations(String departmentId);
  Future<Either<ErrorResponse, TitlesResponse>> getTitles();
  Future<Either<ErrorResponse, BanksResponse>> getBanks();
  Future<Either<ErrorResponse, MembershipPaymentResponse>> getMembershipPayment();
  Future<Either<ErrorResponse, UserSearchResponse>> searchUsers(String query);
}

class DepartmentRepositoryImpl extends DepartmentRepository {
  final DepartmentService departmentService;
  DepartmentRepositoryImpl({required this.departmentService});

  ///this one loads [departmentLists]
  @override
  Future<Either<ErrorResponse, DepartmentResponse >> getDepartments() async {
    var response = await departmentService.getDepartments();
    return response.fold((errorResponse) => Left(errorResponse), (
        departmentResponse) => Right(departmentResponse));
  }

  ///this one loads [list of associations within that selected department_bloc]
  @override
  Future<Either<ErrorResponse, AssociationsResponse>> getAssociations(String departmentId) async {
    var response = await departmentService.getAssociations(departmentId);
    return response.fold((errorResponse) => Left(errorResponse), (
        loginResponse) => Right(loginResponse));
  }

  ///this one loads [list of titles for the art personals]
  @override
  Future<Either<ErrorResponse, TitlesResponse>> getTitles() async {
    var response = await departmentService.getTitles();
    return response.fold((errorResponse) => Left(errorResponse), (
        loginResponse) => Right(loginResponse));
  }

  /// this one loads list of banks for registration
  @override
  Future<Either<ErrorResponse, BanksResponse>> getBanks() async {
    var response = await departmentService.getBanks();
    return response.fold((errorResponse) => Left(errorResponse), (
        bankResponse) => Right(bankResponse));
  }

  /// this is used to search [contributors]  or [publisherName]
  @override
  Future<Either<ErrorResponse, UserSearchResponse>> searchUsers(String query) async{
    var response = await departmentService.searchUsers(query);
    return response.fold((errorResponse) => Left(errorResponse), (
        searchResponse) => Right(searchResponse));
  }

  /// this is used to check if the user membership payment is available and help to proceed to pay or not
  @override
  Future<Either<ErrorResponse, MembershipPaymentResponse>> getMembershipPayment() async{
    var response = await departmentService.getMembershipPayment();
    return response.fold((errorResponse) => Left(errorResponse), (
        membershipResponse) => Right(membershipResponse));
  }

}