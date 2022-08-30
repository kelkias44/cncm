import 'package:cncm_flutter_new/presentation/auth/blocs/banks_bloc/event.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/department_bloc/event.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/title_bloc/event.dart';
import 'package:cncm_flutter_new/presentation/auth/login_page/login_page.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../service_locator.dart';
import '../auth/blocs/banks_bloc/bloc.dart';
import '../auth/blocs/department_bloc/bloc.dart';
import '../auth/blocs/title_bloc/bloc.dart';
import '../auth/register_pages/register.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String welcomeScreenRouteName = 'welcome screen route name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        // color: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const Spacer(),
           const Spacer(),
            SvgPicture.asset(
              'assets/logo.svg',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 20),
            customButton(
              text: 'Login',
              onClick: () {
                Navigator.pushNamed(context, LoginPage.loginPageRouteName);
              },
              backgroundColor: Colors.green,
              textColor: Colors.white,
            ),
            const SizedBox(height: 20),
            customButton(
              text: 'Register',
              onClick: () {
                /// make department and title and bank load

                Navigator.pushNamed(context, RegisterPage.registerPageRouteName);
              },
              backgroundColor: Colors.white,
              textColor: Colors.green,
              borderColor: Colors.green,
            ),
            Spacer(),
            Image.asset(
              "assets/bottompng.png",
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}
