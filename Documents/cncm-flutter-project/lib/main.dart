import 'package:cncm_flutter_new/bloc_observer.dart';
import 'package:cncm_flutter_new/core/colors.dart';
import 'package:cncm_flutter_new/core/route.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/register_asset_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/register_bulk_asset_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/search_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/association_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/auth_bloc/auth_events.dart';
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
import 'package:cncm_flutter_new/presentation/notification_bloc/bloc/notification_bloc.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/bloc/payment_history_bloc.dart';
import 'package:cncm_flutter_new/presentation/splash/splach_screen.dart';
import 'package:cncm_flutter_new/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///this code basically does when user taps in screen body it
///will un focus the textField
// FocusScopeNode currentFocus = FocusScope.of(context);
// if (!currentFocus.hasPrimaryFocus &&
// currentFocus.focusedChild != null) {
// FocusManager.instance.primaryFocus!.unfocus();
// }

/// packages that are not used
///  - hive
///  - path_provider

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServiceLocator();

  BlocOverrides.runZoned(
    () => runApp(
      StartApp(),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class StartApp extends StatelessWidget {
  const StartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()..add(CheckAuthOnStartUp())),
          BlocProvider<NewsFeedBloc>(create: (_) => sl<NewsFeedBloc>()),
          BlocProvider<TrailerBloc>(create: (_) => sl<TrailerBloc>()),
          BlocProvider<RegisterBloc>(create: (_) => sl<RegisterBloc>()),
          BlocProvider<DepartmentBloc>(create: (_) => sl<DepartmentBloc>()),
          BlocProvider<TitleBloc>(create: (_) => sl<TitleBloc>()),
          BlocProvider<AssociationBloc>(create: (_) => sl<AssociationBloc>()),
          BlocProvider<BanksBloc>(create: (_) => sl<BanksBloc>()),
          BlocProvider<AssetManageBloc>(create: (_) => sl<AssetManageBloc>()),
          BlocProvider<SearchedUserBloc>(create: (_) => sl<SearchedUserBloc>()),
          BlocProvider<MembershipPaymentBloc>(create: (_) => sl<MembershipPaymentBloc>()),
          BlocProvider<NotificationBloc>(create: (_)=>sl<NotificationBloc>()),
          BlocProvider<RegisterAssetBloc>(create: (_)=>sl<RegisterAssetBloc>()),
          BlocProvider<RegisterBulkAssetBloc>(create: (_)=>sl<RegisterBulkAssetBloc>()),
          BlocProvider<ChartBloc>(create: (_)=> sl<ChartBloc>()),
          BlocProvider<EarningsBloc>(create: (_)=> sl<EarningsBloc>()),
          BlocProvider<NotificationBloc>(create: (_)=>sl<NotificationBloc>()),
          BlocProvider<UnreadcountBloc>(create: (_)=>sl<UnreadcountBloc>()),
          BlocProvider<MarkallreadBloc>(create: (_)=>sl<MarkallreadBloc>()),
          BlocProvider<PaymentHistoryBloc>(create: (_)=>sl<PaymentHistoryBloc>())
        ],
        child:  MaterialApp(
          onGenerateRoute: AppRoute.onGenerateRoute,
          theme: ThemeData(primaryColor: green),
          initialRoute: SplashScreenPage.splashScreenRouteName,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
