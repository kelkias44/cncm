import 'package:cncm_flutter_new/core/colors.dart';
import 'package:cncm_flutter_new/presentation/auth/register_pages/register.dart';
import 'package:cncm_flutter_new/presentation/auth/register_pages/password_page.dart';
import 'package:flutter/material.dart';

import '../../common/widgets/custom_button.dart';


class RegisterDepartment extends StatefulWidget {
  const RegisterDepartment({Key? key, required this.registerArguments})
      : super(key: key);
  final RegisterArguments registerArguments;
  static const String registerDepartment = 'register_department';

  @override
  State<RegisterDepartment> createState() => _RegisterDepartmentState();
}

class _RegisterDepartmentState extends State<RegisterDepartment> {
  final TextEditingController _addressController = TextEditingController();
  String departmentvalue = 'male';

  // List of items in our dropdown menu

  List<DropdownMenuItem<String>> get departmentValues{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Male"),value: "male"),
      const  DropdownMenuItem(child: Text("Female"),value: "female"),
    ];
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width:double.infinity,
            padding: const EdgeInsets.all(10),
            child: Column(children: <Widget>[


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

              Container(
                width: double.infinity,
                height: 50,
                color: const Color(0XFFf0f0f0),
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(left: RegisterPage.kPadding),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.green, width: 1),
                    ),
                    hintText: ' Department',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ///Title of the user
              Container(
                width: double.infinity,
                height: 50,
                color: const Color(0XFFf0f0f0),
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    contentPadding:const EdgeInsets.only(left: RegisterPage.kPadding),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.green, width: 1),
                    ),
                    hintText: ' Title',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ///associate
              Container(
                width: double.infinity,
                height: 50,
                color: const Color(0XFFf0f0f0),
                child: DropdownButtonFormField(

                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0XFFf0f0f0),
                    contentPadding: EdgeInsets.only(left: RegisterPage.kPadding + 5),
                  ),
                  dropdownColor: Colors.white,
                  value: departmentvalue,
                  focusColor: Colors.green,

                  onChanged: (String? newValue) {
                    setState(() {
                      departmentvalue = newValue!;
                    });
                  },
                  items: departmentValues,
                ),
              ),
              const SizedBox(height: 20),
              const  Divider(thickness: 2),

              const SizedBox(height: 20),
              ///choose bank
              Container(
                width: double.infinity,
                height: 50,
                color: const Color(0XFFf0f0f0),
                child: DropdownButtonFormField(

                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0XFFf0f0f0),
                    contentPadding: EdgeInsets.only(left: RegisterPage.kPadding + 5),
                  ),
                  dropdownColor: Colors.white,
                  value: departmentvalue,
                  focusColor: Colors.green,

                  onChanged: (String? newValue) {
                    setState(() {
                      departmentvalue = newValue!;
                    });
                  },
                  items: departmentValues,
                ),
              ),
              const SizedBox(height: 20),

              ///account num
              Container(
                width: double.infinity,
                height: 50,
                color: const Color(0XFFf0f0f0),
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    contentPadding:const EdgeInsets.only(left: RegisterPage.kPadding),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.green, width: 1),
                    ),
                    hintText: ' Account No',
                  ),
                ),
              ),
              const SizedBox(height: 35),
              customButton(
                text: 'Next',
                onClick: () {
                  Navigator.pushNamed(
                    context,
                    Register_Password.registerPassword,
                    arguments: RegisterWithDepartmentsData(
                      widget.registerArguments,
                      departmentvalue,
                      departmentvalue,
                      departmentvalue,
                      departmentvalue,
                      departmentvalue
                        ),
                  );
                  // BlocProvider.of<AuthBloc>(context).add(
                  //     SendAuthData(
                  //         username:
                  //         _usernameController.value.text,
                  //         password:
                  //         _passwordController.value.text));
                },
              ),

            ]),
          ),
        ),
      ),
    );
  }
}

class RegisterWithDepartmentsData {
 final RegisterArguments registerArguments;
 final String department;
 final String title;
 final String association;
 final String bank;
 final String accountNo;

 RegisterWithDepartmentsData(this.registerArguments, this.department,
      this.title, this.association, this.bank, this.accountNo);
}
