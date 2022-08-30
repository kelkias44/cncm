import 'dart:async';

import 'package:cncm_flutter_new/presentation/assets_manager/bloc/event.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/event.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/homepage.dart';
import 'package:cncm_flutter_new/presentation/splash/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../service_locator.dart';
import '../assets_manager/bloc/bloc.dart';
import '../auth/blocs/auth_bloc/auth_states.dart';
import '../auth/blocs/department_bloc/bloc.dart';
import '../auth/blocs/department_bloc/event.dart';
import '../earning/bloc/earnings_bloc.dart';
import '../homepage/blocs/newsfeed/newsfeed_bloc.dart';
import '../homepage/blocs/newsfeed/newsfeed_events.dart';
import '../homepage/blocs/trailer/bloc.dart';
import '../homepage/blocs/unreadcount_bloc/bloc/unreadcount_bloc.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);
  static const String splashScreenRouteName = 'splash screen route name';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (ctx, state) {
      if (state is AuthenticatedState) {

        sl<NewsFeedBloc>().add(LoadNewsFeed());
        sl<TrailerBloc>().add(LoadTrailerEvent());
        sl<AssetManageBloc>().add(LoadAssets());
        sl<DepartmentBloc>().add(LoadDepartments());
        sl<EarningsBloc>().add(EarningOnLoad());
        sl<UnreadcountBloc>().add(LoadUnreadNotificationEvent());

        Timer(const Duration(seconds: 4), () {
          Navigator.pushNamedAndRemoveUntil(
              context, HomePage.homePageRouteName, (route) => false);
        });

      } else {
        Timer(const Duration(seconds: 4), () {
          Navigator.pushNamedAndRemoveUntil(
              context, WelcomeScreen.welcomeScreenRouteName, (route) => false);
        });
      }
    }, builder: (context, state) {
      return  Scaffold(
        body: Column(
          children :[
            const SizedBox(height: 30),
            Image.asset(
              "assets/upperpngbanner.png",
              height: 60.0, width: MediaQuery.of(context).size.width,
            ),
            const Spacer(),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:40.0),
                child: SvgPicture.asset(
                  'assets/logo_welcome.svg',
                  width: double.infinity,
                  height: 250,
                ),
              ),
            ),
            const Spacer(),
            Image.asset(
              "assets/bottompng.png",
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ]
        ),
      );
    });
  }
}
