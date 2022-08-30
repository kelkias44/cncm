import 'package:cncm_flutter_new/core/api_util/ApiBaseHelper.dart';
import 'package:cncm_flutter_new/core/util/connectivity_service.dart';
import 'package:cncm_flutter_new/core/util/local_storage_service.dart';
import 'package:cncm_flutter_new/data/repositories/asset_payment_repository.dart';
import 'package:cncm_flutter_new/data/repositories/department_repository.dart';
import 'package:cncm_flutter_new/data/repositories/earning_repository.dart';
import 'package:cncm_flutter_new/data/repositories/membership_payment_repository.dart';
import 'package:cncm_flutter_new/data/services/asset_payment_service.dart';
import 'package:cncm_flutter_new/data/services/auth_service.dart';
import 'package:cncm_flutter_new/data/services/department_service.dart';
import 'package:cncm_flutter_new/data/services/membership_payment_service.dart';
import 'package:cncm_flutter_new/data/services/newsfeed_service.dart';
import 'package:cncm_flutter_new/data/repositories/auth_repository.dart';
import 'package:cncm_flutter_new/data/repositories/newsfeed_repository.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/register_asset_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/register_bulk_asset_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/search_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/association_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/banks_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/department_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/membership_payment_bloc/membership_payment_bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/register_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/title_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/earning/bloc/earnings_bloc.dart';
import 'package:cncm_flutter_new/presentation/earning/chartBloc/bloc/chart_bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/markallread_bloc/bloc/markallread_bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/unreadcount_bloc/bloc/unreadcount_bloc.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/bloc/payment_history_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/asset_resoisitory.dart';
import 'data/repositories/chart_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'data/services/asset_service.dart';
import 'data/services/chart_service.dart';
import 'data/services/earning_services.dart';
import 'data/services/notification_service.dart';
import 'presentation/notification_bloc/bloc/notification_bloc.dart';

final sl = GetIt.instance;

Future initServiceLocator() async {
  /** Data providers */
  sl.registerSingleton<Dio>(Dio());
  sl.registerFactory<ApiBaseHelper>(() => ApiBaseHelper());

  var instance = await LocalStorageService.getInstance();
  sl.registerSingleton<LocalStorageService>(instance);
  sl.registerFactory<ConnectivityService>(() => ConnectivityService());

  //data providers
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerFactory<NewsFeedService>(() => NewsFeedService());
  sl.registerFactory<DepartmentService>(() => DepartmentService());
  sl.registerFactory<AssetService>(() => AssetService());
  sl.registerFactory<NotificationServiece>(() => NotificationServiece());
  sl.registerFactory<EarningService>(() => EarningService());
  sl.registerFactory<ChartService>(() => ChartService());
  sl.registerFactory<AssetPaymentService>(() => AssetPaymentService());
  sl.registerFactory<MembershipPaymentService>(() => MembershipPaymentService());
  //sl.registerFactory(() => null)

  //repositories
  sl.registerFactory<NotificationRepository>(() => NotificationRepositoryImpl(notificationServiece: sl()));
  sl.registerFactory<AssetPaymentRepository>(() => AssetPaymentImpl(assetPaymentService:sl()));
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(authService: sl()));
  sl.registerFactory<NewsFeedRepository>(() => NewsFeedRepositoryImpl(newsFeedService: sl()));
  sl.registerFactory<DepartmentRepository>(() => DepartmentRepositoryImpl(departmentService: sl()));
  sl.registerFactory<AssetRepository>(() => AssetRepositoryImpl(assetService: sl()));
  sl.registerFactory<ChartRepository>(() => ChartRepositoryImpl(chartService: sl()));
  sl.registerFactory<EarningRepository>(() => EarningRepositoryImpl(earningService: sl()));
  sl.registerFactory<MembershipPaymentRepository>(() => MembershipPaymentRepositoryImpl(sl()));

  //blocs
  sl.registerLazySingleton<NotificationBloc>(() => NotificationBloc(sl()));
  sl.registerLazySingleton<MarkallreadBloc>(() => MarkallreadBloc(sl()));
  sl.registerLazySingleton<UnreadcountBloc>(() => UnreadcountBloc(sl()));




  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(sl()));
  sl.registerLazySingleton<NewsFeedBloc>(() => NewsFeedBloc(sl()));
  sl.registerLazySingleton<TrailerBloc>(() => TrailerBloc(sl()));
  sl.registerLazySingleton<RegisterBloc>(() => RegisterBloc(sl()));
  sl.registerLazySingleton<TitleBloc>(() => TitleBloc(sl()));
  sl.registerLazySingleton<DepartmentBloc>(() => DepartmentBloc(sl()));
  sl.registerLazySingleton<AssociationBloc>(() => AssociationBloc(sl()));
  sl.registerLazySingleton<BanksBloc>(() => BanksBloc(sl()));
  sl.registerLazySingleton<RegisterBulkAssetBloc>(() => RegisterBulkAssetBloc(sl()));
  sl.registerLazySingleton<RegisterAssetBloc>(() => RegisterAssetBloc(sl()));
  sl.registerLazySingleton<AssetManageBloc>(() => AssetManageBloc(sl()));
  sl.registerLazySingleton<SearchedUserBloc>(() => SearchedUserBloc(sl()));
  sl.registerLazySingleton<ChartBloc>(() => ChartBloc(sl()));
  sl.registerLazySingleton<MembershipPaymentBloc>(() => MembershipPaymentBloc(sl()));
  sl.registerLazySingleton<EarningsBloc>(() => EarningsBloc(sl()));
  sl.registerLazySingleton<PaymentHistoryBloc>(()=>PaymentHistoryBloc(sl()));

  // Hive boxes
  // await Hive.openBox('authData');

  debugPrint('Initialized all dependency injection elements');
}
