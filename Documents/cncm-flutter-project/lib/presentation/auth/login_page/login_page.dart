import 'package:cncm_flutter_new/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:cncm_flutter_new/presentation/common/ui_helper/snackbar.dart';

import 'package:cncm_flutter_new/presentation/homepage/pages/homepage.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cncm_flutter_new/service_locator.dart';
import '../../assets_manager/bloc/bloc.dart';
import '../../assets_manager/bloc/event.dart';
import '../../earning/bloc/earnings_bloc.dart';
import '../../homepage/blocs/newsfeed/newsfeed_bloc.dart';
import '../../homepage/blocs/newsfeed/newsfeed_events.dart';
import '../../homepage/blocs/trailer/bloc.dart';
import '../../homepage/blocs/trailer/event.dart';
import '../blocs/auth_bloc/auth_events.dart';
import '../blocs/auth_bloc/auth_states.dart';
import '../blocs/department_bloc/bloc.dart';
import '../blocs/department_bloc/event.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  static const String loginPageRouteName = 'login page route name';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //var bloc = sl<AuthBloc>();
  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      color: const Color(0XFFf0f0f0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthenticatedState) {
            sl<NewsFeedBloc>().add(LoadNewsFeed());
            sl<TrailerBloc>().add(LoadTrailerEvent());
            sl<AssetManageBloc>().add(LoadAssets());
            sl<DepartmentBloc>().add(LoadDepartments());
            sl<EarningsBloc>().add(EarningOnLoad());

            Navigator.pushNamedAndRemoveUntil(
                context, HomePage.homePageRouteName, (route) => false);
          } else if (state is ErrorSendingAuthData) {
            showSnackBar(state.errorResponse.message, context);
          }
          debugPrint('$state');
        }, builder: (context, state) {
          return Stack(
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const Spacer(),
                Image.asset(
                  "assets/bottompng.png",
                  // height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                  ]
                  ),
              ),          
             Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                color: Colors.transparent,
            
            
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const SizedBox(width: 25 ),
                    IconButton(
                      onPressed: () {
                        () => SystemChannels.textInput.invokeMethod('TextInput.hide');
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),

                    const Text(
                      'Log In',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    const SizedBox(
                      width: 25,
                    ),                    // const Spacer(),
                  ],
                ),
                // const SizedBox(height: 40),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/logo.svg',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 60),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: buildBoxDecoration(),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.green, width: 1),
                          ),
                          hintText: 'Username',
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: buildBoxDecoration(),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.green, width: 1),
                          ),
                          hintText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    state is SendingAuthData
                        ? const Center(child: CircularProgressIndicator())
                        : customButton(
                            text: 'Log In',
                            isBold: true,
                            onClick: () {
                              if (_usernameController.text.length < 3 ||
                                  _passwordController.text.length < 3) {
                                showSnackBar(
                                    "Please fill fields correctly", context);
                              } else {
                                BlocProvider.of<AuthBloc>(context).add(
                                    SendAuthData(
                                        username:
                                            _usernameController.value.text,
                                        password:
                                            _passwordController.value.text));
                              }
                            },
                          ),
                  ],
                ),
                
              ],
            ),
          )]);
        }),)
      );
  }
}
