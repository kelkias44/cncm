// import 'package:car_inspection/core/models/CarInformation.dart';
// import 'package:car_inspection/core/models/CompletedInspection.dart';
// import 'package:car_inspection/core/providers/Images.dart';
// import 'package:car_inspection/core/providers/Submitprovider.dart';
// import 'package:car_inspection/core/services/app_exception.dart';
// import 'package:car_inspection/core/services/global.dart';
// import 'package:car_inspection/core/services/local_storage.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../locator.dart';
//
// class SampleToken {
//   String tokenn =
//       "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI3OTFjNDkzOS00ODQ4LTQxYjQtOWI4ZS04YTE4Njk0MmQzMWIiLCJwaG9uZSI6IjA5Mzk5OTU0NTQiLCJyb2xlIjoiR0FSQUdFLUFETUlOIiwiZ2FyYWdlX2lkIjoiY2IyYzBiMzUtYzZkNy00MGI0LTk5MmUtOGM4Yzg2OGIyZjUxIn0.12MpcvlGuIMTg6CuBN0AEMIT01HcsgFjOBSPsUeXMqo";
//   String get getToken {
//     return tokenn;
//   }
// }
//
// class ApiServices {
//   double uploadProgress = 0;
//   String? token;
//
//   Dio dio = Dio(BaseOptions(
//     connectTimeout: 5000000,
//     receiveTimeout: 5000000,
//     headers: {
//       'Authorization':
//       'Bearer ${locator<LocalStorageService>().getToken ?? SampleToken().getToken}',
//       "Content-Type": "application/json",
//     },
//   ));
//
//   ///creating inspection with image upload included
//   createInspection(
//       context,
//       ) async {
//     var sendData = Provider.of<SendData>(context, listen: false);
//     var imagesProvider = Provider.of<Images>(context, listen: false);
//     Response? response;
//
//     FormData formData = new FormData.fromMap(
//       {
//         "vin": sendData.getVin,
//         "config_id": sendData.getConfigId,
//         "left": await MultipartFile.fromBytes(imagesProvider.leftImage!,
//             filename: 'left.png'),
//         "right": await MultipartFile.fromBytes(imagesProvider.rightImage!,
//             filename: 'right.png'),
//         "front": await MultipartFile.fromBytes(imagesProvider.frontImage!,
//             filename: 'front.png'),
//         "back": await MultipartFile.fromBytes(imagesProvider.rearImage!,
//             filename: 'back.png'),
//         "sign": await MultipartFile.fromBytes(imagesProvider.signatureImage!,
//             filename: 'test.png'),
//         "owner_id": sendData.getOwnerId,
//         "driver_id": sendData.getDriverId,
//         "failed_case": sendData.getFailCase,
//       },
//     );
//
//     try {
//       Options options = new Options(headers: {
//         "Content-Type": "multipart / form - data",
//       });
//
//       /// formData.files.map((e) => print(e.value));
//
//       print(formData.files.last);
//       print('this is fail case id');
//       print(sendData.getFailCase);
//
//       response = await dio.post(
//         createNewInspectionUrl,
//         data: formData,
//         options: options,
//         onSendProgress: (int sent, int total) {
//           uploadProgress = sent / total;
//           //notifyListeners();
//           print("uploading.. " + uploadProgress.toString());
//         },
//       );
//     } on DioError catch (e) {
//       sendData.clearFailCase();
//       debugPrint('this is save inspection error: e' + e.error);
//       print(e.response);
//       throw ApiCallException.fromDioError(e);
//     }
//     print(response);
//     return response;
//   }
//
//   ///search inspection by [temp by vin num] plate
//   Future<CarInformation> searchCarInfo(String query) async {
//     late Response response;
//
//     //print("this is query " + token);
//     try {
//       response = await dio.get(searchbyplate + query);
//
//       return CarInformation.fromJson(response.data);
//     } on DioError catch (e) {
//       debugPrint('this is search error: e' + e.toString());
//       return throw ApiCallException.fromDioError(e);
//     }
//   }
//
//   ///search inspection by [temp by vin num] plate
//   Future<CompletedInspections> searchCompletedCarInfo(String query) async {
//     late Response response;
//
//     try {
//       response = await dio.get(
//         searchcompleted + "${query}/inspections?page=0&per_page=8&sort=DESC",
//       );
//
//       // print('HELLO FROM completed SEARCH RESPONSE');
//       // print(response.data);
//       if (response.data['data'].length == 0) {
//         await new Future.delayed(const Duration(milliseconds: 2000));
//         return throw ApiCallException(
//             "No car is found with this license number 😐");
//       } else {
//         return CompletedInspections.fromJson(response.data);
//       }
//     } on DioError catch (e) {
//       debugPrint("error from completed" + e.error);
//       return throw ApiCallException.fromDioError(e);
//     }
//
//     ///  SearchCar.fromJson(response.data);
//   }
//
//   ///Fetch list of completed inspections
//   /// https://138.68.163.236:7881/v1/inspections/
//   Future<CompletedInspections> getCompletedInspections2(int page) async {
//     late Response response;
//     print(token);
//     try {
//       response = await dio.get(
//         completedInspections + '?page=$page&per_page=8&sort=["created_at","DESC"]',
//       );
//
//       // print(response.data);
//     } on DioError catch (e) {
//       debugPrint('error happen while fetching completed inspections' + e.error);
//
//       throw ApiCallException.fromDioError(e);
//     }
//     return CompletedInspections.fromJson(response.data);
//   }
// }
