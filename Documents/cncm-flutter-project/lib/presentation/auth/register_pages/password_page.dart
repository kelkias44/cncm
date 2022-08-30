import 'package:cncm_flutter_new/presentation/auth/register_pages/register_department.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/custom_button.dart';
import '../../homepage/pages/homepage.dart';

class Register_Password extends StatefulWidget {
  Register_Password(
      {Key? key, required this.registerWithDepartmentsDataArgument})
      : super(key: key);
  final RegisterWithDepartmentsData registerWithDepartmentsDataArgument;
  static const String registerPassword = 'register_password';

  @override
  State<Register_Password> createState() => _Register_PasswordState();
}

class _Register_PasswordState extends State<Register_Password> {
  final double kPadding = 10;
  bool _isObscure = true;
  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Register',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
                const SizedBox(width: 25),

                // const Spacer(),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                ///username

                Container(
                  width: double.infinity,
                  height: 50,
                  color: const Color(0XFFf0f0f0),
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: kPadding),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 1),
                      ),
                      hintText: ' Password',
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                ///password
                Container(
                  width: double.infinity,
                  height: 50,
                  color: const Color(0XFFf0f0f0),
                  child: TextField(
                    controller: _confirmPassword,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: kPadding),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.green, width: 1),
                      ),
                      hintText: ' Confirm Password',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: customButton(
                    text: 'Done',
                    onClick: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          HomePage.homePageRouteName, (route) => false);
                      // Navigator.pushNamed(
                      //   context,
                      //   Register_Password.registerPassword,
                      // arguments: RegisterWithDepartmentsData(
                      //     widget.registerArguments,
                      //     departmentvalue,
                      //     departmentvalue,
                      //     departmentvalue,
                      //     departmentvalue,
                      //     departmentvalue
                      // ),
                      // );
                      // BlocProvider.of<AuthBloc>(context).add(
                      //     SendAuthData(
                      //         username:
                      //         _usernameController.value.text,
                      //         password:
                      //         _passwordController.value.text));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}
