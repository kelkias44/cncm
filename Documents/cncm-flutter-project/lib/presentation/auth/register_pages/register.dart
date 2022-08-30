import 'dart:io';
import 'dart:typed_data';

import 'package:cncm_flutter_new/data/models/RegisterRequest.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/widget/numberTextField.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/widget/textFieldWidget.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/association_bloc/event.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/association_bloc/state.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/banks_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/banks_bloc/event.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/banks_bloc/state.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/department_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/register_bloc/event.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/title_bloc/event.dart';
import 'package:cncm_flutter_new/presentation/common/ui_helper/dotted_horizontal_line.dart';
import 'package:cncm_flutter_new/presentation/common/ui_helper/snackbar.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/customLoader.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/custom_button.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/stepper_button.dart';
import 'package:cncm_flutter_new/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/colors.dart';
import '../../assets_manager/bloc/bloc.dart';
import '../../assets_manager/bloc/event.dart';
import '../../assets_manager/widget/decorations.dart';
import '../../earning/bloc/earnings_bloc.dart';
import '../../homepage/blocs/newsfeed/newsfeed_bloc.dart';
import '../../homepage/blocs/newsfeed/newsfeed_events.dart';
import '../../homepage/blocs/trailer/bloc.dart';
import '../../homepage/blocs/trailer/event.dart';
import '../../homepage/pages/homepage.dart';
import '../blocs/association_bloc/bloc.dart';
import '../blocs/association_bloc/state.dart';
import '../blocs/department_bloc/event.dart';
import '../blocs/department_bloc/state.dart';
import '../blocs/register_bloc/bloc.dart';
import '../blocs/register_bloc/state.dart';
import '../blocs/title_bloc/bloc.dart';
import '../blocs/title_bloc/state.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static const String registerPageRouteName = 'register_page';
  static const kPadding = 15.0;
  final state = _RegisterPageState();

  @override
  State<RegisterPage> createState() => _RegisterPageState();
  bool isValid() => state.validateForm();

}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _middlenameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late final TextEditingController _dateController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _bankAccountNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final TextEditingController _userName = TextEditingController();

  final double kPadding = 10;
  bool _isObscure = true;
  bool _isObscureConfirm = true;
  String phone = '251';
  String? genderValue;
  String? bankValue;
  String? associationValue;
  String? departmentValue;
  String? titleValue;
  final ImagePicker _picker = ImagePicker();



  List<DropdownMenuItem<String>> departmentDropdownItems = [];
  List<DropdownMenuItem<String>> titleDropdownItems = [];
  List<DropdownMenuItem<String>> associationDropdownItems = [];
  List<DropdownMenuItem<String>> bankDropdownItems = [];

  List<DropdownMenuItem<String>> get genderDropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Male"), value: "male"),
      const DropdownMenuItem(child: Text("Female"), value: "female"),
    ];
    return menuItems;
  }
  final forms = GlobalKey<FormState>();

  bool validateForm() {
    var isValid = forms.currentState?.validate();
    if (isValid!) forms.currentState?.save();
    return isValid;
  }
  void onSave() {
    validateForm();
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
  bool validatePhone(String value) {
    Pattern pattern =
        r"^[7|9][0-9]{8}$";
    RegExp regex = RegExp(pattern.toString());
    if (regex.hasMatch(value.toString())) {
      return true;
    } else {
      return false;
    }
  }

  String? _selectedDate;

  //1984–04–02 date format
  Color stepper2Color = Colors.grey;
  Color stepper3Color = Colors.grey;

  //Color stepper2Color = Colors.grey;
  XFile? image;
  File? picture;
  int _currentStep = 1;
  bool step1Complete = false;
  bool step2Complete = false;
  bool step3Complete = false;
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentStep == 1) {
          return true;
        } else {
          _currentStep = 1;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text("Register"),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, registerState) {
                if(registerState is LoadingRegister){
                  const CircularProgressIndicator();
                }
                if (registerState is RegisteredState) {
                  sl<NewsFeedBloc>().add(LoadNewsFeed());
                  sl<TrailerBloc>().add(LoadTrailerEvent());
                  sl<AssetManageBloc>().add(LoadAssets());
                  sl<DepartmentBloc>().add(LoadDepartments());
                  sl<EarningsBloc>().add(EarningOnLoad());
                  showSnackBar("Register Successful", context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomePage.homePageRouteName, (route) => false);
                }
                if (registerState is FieldErrorRegister) {
                  String errorMessage = "";
                  for (var data in registerState.errorResponse.errors.fieldErrors) {
                    errorMessage += data + "\n";
                  }
                  showSnackBar(errorMessage, context);
                }
                if (registerState is ErrorRegister) {
                  showSnackBar(registerState.errorResponse.message, context);
                }

              },
              builder: (context, registerState) {
                return Column(
                  children: [
                    ///stepper Icon button and text
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 90,
                        color: Colors.white,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            ///stepper Icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(flex: 1, child: Container(height: 2.5)),

                                ///person
                                stepperButton(
                                    onPressed: () {
                                      if (step1Complete){
                                        setState(() {
                                          _currentStep = 1;
                                        });
                                      }
                                    },
                                    backgroundColor: Colors.green,
                                    iconColor: Colors.white,
                                    icon: step1Complete ? Icons.check : Icons.person),

                                ///line
                                const Expanded(
                                  flex: 2,
                                  child: DottedLine(color: Colors.green),
                                ),

                                ///membership
                                stepperButton(
                                    onPressed: () {
                                      if (step1Complete){
                                        setState(() {
                                          stepper2Color = green;
                                          _currentStep = 2;
                                        });
                                      }
                                    },
                                    backgroundColor: stepper2Color,
                                    iconColor: Colors.white,
                                    icon:step2Complete ? Icons.check :  Icons.people),

                                ///line
                                const Expanded(
                                  flex: 2,
                                  child: DottedLine(color: Colors.green),
                                ),

                                ///password
                                stepperButton(
                                    onPressed: () {
                                      if(step2Complete){
                                        setState(() {
                                          stepper3Color = green;
                                          _currentStep = 3;
                                        });
                                      }
                                    },
                                    backgroundColor: stepper3Color,
                                    iconColor: Colors.white,
                                    icon: Icons.lock),

                                Expanded(flex: 1, child: Container(height: 2.5))
                              ],
                            ),
                            /// stepper texts
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(flex: 1, child: Container(height: 2.5)),

                                ///person

                                const Center(
                                  child: Text(
                                    'Basic Info',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                ///line

                                const Expanded(flex: 2, child: SizedBox()),

                                ///membership
                                Center(
                                  child: Text(
                                    'Membership',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: stepper2Color == green
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),

                                ///line

                                const Expanded(flex: 2, child: SizedBox()),

                                ///password

                                Center(
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: stepper3Color == green
                                          ? Colors.black
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1, child: Container(height: 2.5))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    _currentStep == 1
                        ?

                        ///first step registration UI
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10.0),
                             child: Column(
                                children: [
                                  /// image part is here
                                  Center(
                                      child: Stack(children: [
                                    InkWell(
                                      onTap: () async {
                                        image = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 25);
                                        if (image != null) {
                                          setState(()  {
                                            picture = File(image!.path);
                                            print("this is selected image forom ui");
                                            print(image!.path);
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: const BoxDecoration(
                                          color: Color(0XFFf0f0f0),
                                          shape: BoxShape.circle,
                                        ),
                                        child: image == null
                                            ? const SizedBox()
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50.0),
                                                child: Image.file(File(picture?.path ?? ''), fit: BoxFit.cover),
                                              ),
                                      ),
                                    ),
                                    image == null
                                        ? Positioned(
                                            top: 50,
                                            child: GestureDetector(
                                              onTap: () async {
                                                image = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 25,);
                                                if (image != null) {
                                                  setState(()  {
                                                    picture = File(image!.path);
                                                    print("this is selected image from ui");
                                                    print(image!.path);
                                                  });
                                                }
                                              },
                                              child: Container(
                                                height: 50,
                                                width: 100,
                                                color: Colors.transparent,
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.green,
                                                    shape: BoxShape.rectangle,
                                                    borderRadius: BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(50.0),
                                                      bottomRight:
                                                          Radius.circular(50.0),
                                                    ),
                                                  ),
                                                  child: const Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(),
                                  ])),

                                  const SizedBox(height: 20),

                                 Form(
                                     key: forms,
                                     child: Column(
                                       children: [
                                         buildFormField(
                                             hintText: "first name",
                                             dataValue: _firstnameController,
                                             errorMessage: "first name is required",
                                             context: context),
                                         const SizedBox(height: 20,),
                                         buildFormField(
                                             hintText: "middle name",
                                             dataValue: _middlenameController,
                                             errorMessage: "middle name is required",
                                             context: context),
                                         const SizedBox(height: 20,),

                                         buildFormField(
                                             hintText: "last name",
                                             dataValue: _lastnameController,
                                             errorMessage: "last name is required",
                                             context: context),
                                         const SizedBox(height: 20,),
                                         TextFormField(
                                           // initialValue: dataValue.text,
                                           controller: _emailController,
                                           enabled: true,
                                           // onChanged: (value) => dataValue.text = value,
                                           onSaved: (value) => _emailController.text = value!,
                                           validator: (val) => validateEmail(val.toString()) ? null : "email is not valid",

                                           decoration: InputDecoration(
                                             contentPadding: const EdgeInsets.only(left: 15),
                                             fillColor:  const Color(0XFFf0f0f0),
                                             focusedBorder: buildUnderlineInputBorder(),
                                             border:   OutlineInputBorder(
                                               borderRadius: BorderRadius.circular(8),
                                               borderSide:const BorderSide(
                                                 width: 0,
                                                 style: BorderStyle.none,
                                               ),
                                               //  borderRadius: BorderRadius.horizontal(left:Radius.circular(7.0),right: Radius.circular(7.0)),
                                             ),
                                             filled: true,
                                             hintText: 'Email',
                                           ),
                                         ),
                                         const SizedBox(height: 20,),

                                         TextFormField(

                                           controller: _phoneController,
                                           enabled: true,
                                           keyboardType: TextInputType.number,
                                           // onChanged: (value) => dataValue.text = value.toString(),

                                           onSaved: (value) => _phoneController.text  = value!.toString(),
                                           validator: (val) => validatePhone(val.toString()) ? null : "phone number is not correct ",
                                           decoration: InputDecoration(
                                             contentPadding: const EdgeInsets.only(left: 0),
                                             fillColor:  const Color(0XFFf0f0f0),
                                             prefix: const Text("+251"),
                                             focusedBorder: buildUnderlineInputBorder(),
                                             border:   OutlineInputBorder(
                                               borderRadius: BorderRadius.circular(8),
                                               borderSide:const BorderSide(
                                                 width: 0,
                                                 style: BorderStyle.none,
                                               ),
                                               //  borderRadius: BorderRadius.horizontal(left:Radius.circular(7.0),right: Radius.circular(7.0)),
                                             ),
                                             filled: true,
                                             hintText: 'Phone number',
                                           ),

                                         ),
                                         const SizedBox(height: 20,),
                                         buildFormField(
                                             hintText: "Address",
                                             dataValue: _addressController,
                                             errorMessage: "address is required",
                                             context: context),
                                         const SizedBox(height: 20,),

                                            TextFormField(
                                              onTap: _presentDatePicker,
                                             controller: _dateController,
                                             enabled: true,
                                             keyboardType: TextInputType.number,
                                             // onChanged: (value) => dataValue.text = value.toString(),

                                             onSaved: (value) => _dateController.text  = value!.toString(),
                                             decoration: InputDecoration(
                                               contentPadding: const EdgeInsets.only(left: 15),
                                               fillColor:  const Color(0XFFf0f0f0),
                                               suffixIcon: InkWell(
                                                 onTap: _presentDatePicker,
                                                 child: const Icon(
                                                Icons.date_range,
                                                color: Colors.black54,
                                              ),
                                               ),
                                               focusedBorder: buildUnderlineInputBorder(),
                                               border:   OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(8),
                                                 borderSide:const BorderSide(
                                                   width: 0,
                                                   style: BorderStyle.none,
                                                 ),
                                                 //  borderRadius: BorderRadius.horizontal(left:Radius.circular(7.0),right: Radius.circular(7.0)),
                                               ),
                                               filled: true,
                                               hintText: 'Birth date',


                                           ),
                                         ),
                                         const SizedBox(height: 20,),
                                         DropdownButtonFormField(
                                     decoration: const InputDecoration(
                                       focusedBorder: UnderlineInputBorder(
                                         borderSide:
                                         BorderSide(color: Colors.green),
                                       ),
                                       filled: true,
                                       fillColor: Color(0XFFf0f0f0),
                                       contentPadding: EdgeInsets.only(
                                           left: RegisterPage.kPadding + 5),
                                     ),
                                     dropdownColor: Colors.white,
                                     hint: const Text('Gender'),
                                     value: genderValue,
                                     focusColor: Colors.green,
                                     onChanged: (String? newValue) {
                                       setState(() {
                                         genderValue = newValue!;
                                       });
                                     },
                                     items: genderDropdownItems,
                                   ),

                                       ],
                                     )),

                                  const SizedBox(height: 35),
                                  customButton(
                                    text: 'Next',
                                    onClick: () {
                                      if (validateForm() == false ) {
                                        showSnackBar("Please fill fields correctly",
                                            context);
                                      }else if(genderValue == null){
                                        showSnackBar("please select your gender", context);
                                      }
                                      else if(_dateController.text.toString().isEmpty){
                                        showSnackBar("please select your birth day", context);
                                      }
                                      else if (image == null) {
                                        showSnackBar(
                                            "Please add profile picture", context);
                                      } else {
                                        sl<DepartmentBloc>().add(LoadDepartments());
                                        sl<BanksBloc>().add(LoadBanks());
                                        sl<TitleBloc>().add(LoadTitles());
                                        setState(() {
                                           step1Complete = true;
                                           stepper2Color = green;
                                          _currentStep = 2;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                          )
                        : _currentStep == 2
                            ?
                            /// second step Departments UI
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 50),

                                    ///department
                                    BlocConsumer<DepartmentBloc, DepartmentState>(
                                      listener: (context, departmentState) {
                                        if (departmentState
                                            is ErrorGettingDepartments) {
                                          showSnackBar(
                                              departmentState
                                                  .errorResponse.message,
                                              context);
                                        }
                                        if (departmentState
                                            is LoadedDepartments) {
                                          print(
                                              "department is loaded from bloc listener");
                                          setState(() {
                                            departmentDropdownItems =
                                                departmentState.departments
                                                    .map((department) {
                                              return DropdownMenuItem(
                                                child: Text(department.name),
                                                value: department.id.toString(),
                                              );
                                            }).toList();
                                          });
                                        }
                                      },
                                      builder: (context, departmentState) {
                                        return Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: buildBoxDecoration(),
                                          child: departmentState
                                                  is LoadingDepartments
                                              ? customLoader()
                                              : departmentState
                                                      is ErrorGettingDepartments
                                                  ? InkWell(
                                                      onTap: () {
                                                        sl<DepartmentBloc>().add(
                                                            LoadDepartments());
                                                      },
                                                      child: const Center(
                                                          child:
                                                              Text("Try again")))
                                                  : DropdownButtonFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            Color(0XFFf0f0f0),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: RegisterPage
                                                                        .kPadding +
                                                                    5),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ),
                                                      dropdownColor: Colors.white,
                                                      hint: const Text(
                                                          "Choose Department"),
                                                      value: departmentValue,
                                                      focusColor: Colors.green,
                                                      onChanged:
                                                          (String? newValue) {
                                                        sl<AssociationBloc>().add(
                                                            LoadAssociation(
                                                                associationId:
                                                                    '$newValue'));
                                                        setState(() {
                                                          departmentValue =
                                                              newValue!;
                                                        });
                                                      },
                                                      items:
                                                          departmentDropdownItems,
                                                    ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),

                                    ///Title of the user
                                    BlocConsumer<TitleBloc, TitleState>(
                                      listener: (context, titleState) {
                                        if (titleState is ErrorGettingTitles) {
                                          showSnackBar(
                                              titleState.errorResponse.message,
                                              context);
                                        }
                                        if (titleState is LoadedTitles) {
                                          print(
                                              "titles is loaded from bloc listener");
                                          setState(() {
                                            titleDropdownItems =
                                                titleState.titles.map((titles) {
                                              return DropdownMenuItem(
                                                child: Text(titles.name),
                                                value: titles.value,
                                              );
                                            }).toList();
                                          });
                                        }
                                      },
                                      builder: (context, titleState) {
                                        return Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: buildBoxDecoration(),
                                          child: titleState is LoadingTitles
                                              ? customLoader()
                                              : titleState is ErrorGettingTitles
                                                  ? InkWell(
                                                      onTap: () {
                                                        sl<TitleBloc>()
                                                            .add(LoadTitles());
                                                      },
                                                      child: const Center(
                                                          child:
                                                              Text("Try again")))
                                                  : DropdownButtonFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            Color(0XFFf0f0f0),
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: RegisterPage
                                                                        .kPadding +
                                                                    5),
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                                  Colors.green),
                                                        ),
                                                      ),
                                                      dropdownColor: Colors.white,
                                                      hint: const Text(
                                                          "Your Title"),
                                                      value: titleValue,
                                                      focusColor: Colors.green,
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          titleValue = newValue;
                                                        });
                                                      },
                                                      items: titleDropdownItems,
                                                    ),
                                        );
                                      },
                                    ),

                                    const SizedBox(height: 20),

                                    ///association
                                    BlocConsumer<AssociationBloc,
                                        AssociationState>(
                                      listener: (context, associationState) {
                                        if (associationState
                                            is ErrorGettingAssociations) {
                                          showSnackBar(
                                              associationState
                                                  .errorResponse.message,
                                              context);
                                        }
                                        if (associationState is LoadedAssociations) {
                                          associationDropdownItems =
                                              associationState.associations
                                                  .map((association) {
                                            return DropdownMenuItem(
                                              child: Text(association.name),
                                              value: association.id.toString(),
                                            );
                                          }).toList();
                                        }
                                      },
                                      builder: (context, associationState) {
                                        return Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: buildBoxDecoration(),
                                          child: associationState
                                                  is LoadingAssociations
                                              ? customLoader()
                                              : associationState is EmptyAssociation ? const Center(child:Text("No Association Found!")) :  DropdownButtonFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    filled: true,
                                                    fillColor: Color(0XFFf0f0f0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: RegisterPage
                                                                    .kPadding +
                                                                5),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                  dropdownColor: Colors.white,
                                                  hint: const Text(
                                                      "Association you are in"),
                                                  value: associationValue,
                                                  focusColor: Colors.green,
                                                  onChanged: (String? newValue) {
                                                    setState(() {
                                                      associationValue =
                                                          newValue!;
                                                    });
                                                  },
                                                  items: associationDropdownItems,
                                                ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                   // const Divider(thickness: 1),
                                    const SizedBox(height: 20),

                                    ///choose bank
                                    BlocConsumer<BanksBloc, BanksState>(
                                      listener: (context, banksState) {
                                        if (banksState is ErrorGettingBanks) {
                                          showSnackBar(
                                              banksState.errorResponse.message,
                                              context);
                                        }
                                        if (banksState is LoadedBanks) {
                                          bankDropdownItems =
                                              banksState.banks.map((bank) {
                                            return DropdownMenuItem(
                                              child: Text(bank.name),
                                              value: bank.value.toString(),
                                            );
                                          }).toList();
                                        }
                                      },
                                      builder: (context, banksState) {
                                        return Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: buildBoxDecoration(),
                                          child: banksState is LoadingBanks
                                              ? customLoader()
                                              : banksState is ErrorGettingBanks
                                                  ? InkWell(
                                                      onTap: () {
                                                        sl<BanksBloc>()
                                                            .add(LoadBanks());
                                                      },
                                                      child: const Center(
                                                          child:
                                                              Text("Try again")))
                                                  : DropdownButtonHideUnderline(
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          filled: true,
                                                          fillColor:
                                                              Color(0XFFf0f0f0),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: RegisterPage
                                                                          .kPadding +
                                                                      5),
                                                          focusedBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                        ),
                                                        hint: const Text(
                                                            'Select a bank'),
                                                        dropdownColor:
                                                            Colors.white,
                                                        value: bankValue,
                                                        focusColor: Colors.green,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            bankValue = newValue!;
                                                          });
                                                        },
                                                        items: bankDropdownItems,
                                                      ),
                                                    ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),

                                    ///account num
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      decoration: buildBoxDecoration(),
                                      // child: TextField(
                                      //   controller: _bankAccountNumber,
                                      //   maxLength: 20,
                                      //   keyboardType: TextInputType.number,
                                      //   decoration: InputDecoration(
                                      //     contentPadding: const EdgeInsets.only(
                                      //         left: RegisterPage.kPadding),
                                      //     focusedBorder: UnderlineInputBorder(
                                      //       borderRadius:
                                      //           BorderRadius.circular(10),
                                      //       borderSide: const BorderSide(
                                      //           color: Colors.green, width: 1),
                                      //     ),
                                      //     hintText: ' Account No',
                                      //     counterText: "",
                                      //   ),
                                      // ),
                                      child: buildNumberFormField(
                                          hintText: 'Account No',
                                          dataValue: _bankAccountNumber,
                                          errorMessage: "Account number is required",
                                          context: context),
                                    ),
                                    const SizedBox(height: 35),
                                    customButton(
                                      text: 'Next',
                                      onClick: () {
                                        if (associationValue != null && bankValue != null &&  titleValue != null && _bankAccountNumber.text.isNotEmpty){
                                          setState(() {
                                            step2Complete = true;
                                            stepper2Color = green;
                                            stepper3Color = green;
                                            _currentStep = 3;
                                          });
                                        }else {
                                          showSnackBar("please fill all the fields",context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : _currentStep == 3
                                ?
                                /// third step
                                Container(
                                    width: double.infinity,
                                    //  color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10.0),

                                    child: Column(
                                      children: [
                                        const SizedBox(height: 50),

                                        ///user name
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          //padding: EdgeInsets.only(left: 20),
                                          decoration: buildBoxDecoration(),
                                          child: TextField(
                                            controller: _userName,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left:
                                                          RegisterPage.kPadding),
                                              focusedBorder: UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              ),
                                              hintText: ' username',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        /// password
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: buildBoxDecoration(),
                                          child: TextField(
                                            controller: _password,
                                            obscureText: _isObscure,
                                            keyboardType: TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: kPadding, top: 15),
                                              suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _isObscure
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: green,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isObscure = !_isObscure;
                                                    });
                                                  }),
                                              focusedBorder: UnderlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              ),
                                              hintText: ' Password',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),

                                        ///confirm password
                                        Container(
                                          width: double.infinity,
                                          height: 50,
                                          decoration: buildBoxDecoration(),
                                          child: TextField(
                                            controller: _confirmPassword,
                                            obscureText: _isObscureConfirm,
                                            keyboardType: TextInputType.visiblePassword,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: kPadding, top: 15),
                                              suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _isObscureConfirm
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: green,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _isObscureConfirm =
                                                          !_isObscureConfirm;
                                                    });
                                                  }),
                                              focusedBorder: UnderlineInputBorder(borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.green,
                                                    width: 1),
                                              ),
                                              hintText: ' Confirm Password',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 100),

                                        registerState is LoadingRegister
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : customButton(
                                                text: 'Done',
                                                onClick: () {
                                                  if (_password.text != _confirmPassword.text) {
                                                    showSnackBar(
                                                        "Password Does not much",
                                                        context);
                                                  }
                                                  else if(_password.text.length < 3 || _confirmPassword.text.length < 3 && _userName.text.length < 3){
                                                    showSnackBar("please fill all the fields correctly", context);
                                                  }
                                                  else {
                                                    sl<RegisterBloc>().add(
                                                        RegisterUser(
                                                            registerRequest:
                                                                RegisterRequest(
                                                      password: _password.text
                                                          .toString(),
                                                      confirmPassword:
                                                          _confirmPassword.text
                                                              .toString(),
                                                      firstName:
                                                          _firstnameController
                                                              .text
                                                              .toString(),
                                                      middleName:
                                                          _middlenameController
                                                              .text
                                                              .toString(),
                                                      lastName:
                                                          _lastnameController.text
                                                              .toString(),
                                                      email: _emailController.text
                                                          .toString(),
                                                      phone: '0'+_phoneController.text
                                                          .toString(),
                                                      birthdate: _dateController
                                                          .text
                                                          .toString(),
                                                      accountNumber:
                                                          _bankAccountNumber.text
                                                              .toString(),
                                                      representative:
                                                          _bankAccountNumber.text
                                                              .toString(),
                                                      associationId:
                                                          associationValue!,
                                                      bank: bankValue!,
                                                      gender: genderValue!,
                                                      picture: picture!,
                                                      role: "samplerole",
                                                      title: titleValue!,
                                                      username: _userName.text
                                                          .toString(),
                                                    )));
                                                  }
                                                },
                                              ),
                                      ],
                                    ),
                                  )
                                : Container(),
                  ],
                );



              },
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(7),
      color: const Color(0XFFf0f0f0),
    );
  }

  void _presentDatePicker() {
    // showDatePicker is a pre-made function of Flutter
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: green, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.green, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _dateController.text = pickedDate.year.toString() +
            "-" +
            pickedDate.month.toString() +
            "-" +
            pickedDate.day.toString();
        _selectedDate = _dateController.text.toString();
      });
    });
  }


}

class RegisterArguments {
  final String fullName;
  final String email;
  final String phone;
  final String address;
  final String birthDate;
  final String gender;

  RegisterArguments(this.fullName, this.email, this.phone, this.address,
      this.birthDate, this.gender);

//RegisterArguments(this.username, this.password);
}
