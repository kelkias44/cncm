
import 'package:cncm_flutter_new/presentation/assets_manager/pages/AssetManagePage.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/pages/add_assets_page.dart';
import 'package:cncm_flutter_new/presentation/auth/register_pages/register_department.dart';
import 'package:cncm_flutter_new/presentation/earning/pages/earnings.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/homepage.dart';
import 'package:cncm_flutter_new/presentation/auth/login_page/login_page.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/notification_page.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/trailer_detail.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/pages/membership.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/pages/payment_history.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/pages/tab_element_account.dart';
import 'package:cncm_flutter_new/presentation/splash/welcome_screen.dart';
import 'package:cncm_flutter_new/presentation/splash/splach_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../presentation/assets_manager/pages/AssetDetailPage.dart';
import '../presentation/auth/register_pages/register.dart';
import '../presentation/auth/register_pages/password_page.dart';
import '../presentation/homepage/pages/tab_home.dart';

class AppRoute {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    dynamic args = routeSettings.arguments;
    switch (routeSettings.name) {
      case SplashScreenPage.splashScreenRouteName:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreenPage();
        });
      case WelcomeScreen.welcomeScreenRouteName:
        return MaterialPageRoute(builder: (context) {
          return const WelcomeScreen();
        });

      case LoginPage.loginPageRouteName:
        return MaterialPageRoute(builder: (context) {
          return LoginPage();
        });
      case RegisterPage.registerPageRouteName:
        return MaterialPageRoute(builder: (context) {
          return  RegisterPage();
        });
      case HomePage.homePageRouteName:
        return MaterialPageRoute(builder: (context) {
          return const HomePage();
        });
      case RegisterDepartment.registerDepartment:
        RegisterArguments args = routeSettings.arguments as RegisterArguments;
        return MaterialPageRoute(builder: (context) {
          return  RegisterDepartment(registerArguments:args);
        });
      case Register_Password.registerPassword:
        RegisterWithDepartmentsData args = routeSettings.arguments as RegisterWithDepartmentsData;
        return MaterialPageRoute(builder: (context) {
          return  Register_Password(registerWithDepartmentsDataArgument: args);
        });

      case PaymentHistory.paymentHistoryPageRouteName:
        return MaterialPageRoute(builder: (context) {
          return const PaymentHistory();
        });
      case Membership.membershipPageRouteName:
        return MaterialPageRoute(builder: (context) {
          return  Membership();
        });
      case AssetManagePage.assetManageListPageRouteName:
        return MaterialPageRoute(builder: (context) {
          return  AssetManagePage();
        });
      case AssetDetailPage.assetDetailRouteName:
        AssetDetailArgument args = routeSettings.arguments as AssetDetailArgument;
        return MaterialPageRoute(builder: (context) {
          return   AssetDetailPage(assetDetailViewArg: args);
        });
      case AddAssetPage.addAssetPage:
        AssetTypeArgument args = routeSettings.arguments as AssetTypeArgument;
        return MaterialPageRoute(builder: (context) {
          return AddAssetPage(assetTypeArgument: args);
        });
      case EarningsPage.earningsPageRouteName:  //earnings
        return MaterialPageRoute(builder: (context) {
          return  EarningsPage();
        });
        case TrailerDetailView.trailerDetailPage:  //earnings
          TrailerDetailArgument args = routeSettings.arguments as TrailerDetailArgument;
          return MaterialPageRoute(builder: (context) {
          return   TrailerDetailView(trailerDetailViewArg: args);
        });
      case AccountInfoPage.accountInfoPage:
        return MaterialPageRoute(builder: (context) {
          return AccountInfoPage(
            accountInfo: args['accountInfo'],
          );
        });
        case NotificationPage.notificationPageRouteName:
        return MaterialPageRoute(
          builder: (context){
            return NotificationPage();
          });
      
    }
  }
}
