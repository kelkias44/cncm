import 'package:cached_network_image/cached_network_image.dart';
import 'package:cncm_flutter_new/core/util/local_storage_service.dart';
import 'package:cncm_flutter_new/data/models/LoginUser.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/homepage.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/bloc/payment_history_bloc.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/pages/membership.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/pages/payment_history.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/pages/tab_element_account.dart';
import 'package:cncm_flutter_new/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../splash/welcome_screen.dart';

class TabProfilePage extends StatelessWidget {
  const TabProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onWillPop(){
    Navigator.pushReplacementNamed(context, HomePage.homePageRouteName); 
  }
    return WillPopScope(
      onWillPop: ()async{
        _onWillPop();
        return true;
      },
      child: FutureBuilder<User>(
        future: getUserInfo(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                        color: Colors.black,

                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            IconButton(
                              onPressed: () {
                                sl<LocalStorageService>().remove("login");
                                sl<LocalStorageService>().remove("user");
                                sl<LocalStorageService>().remove("token");
                                sl<LocalStorageService>().remove("userId");
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    WelcomeScreen.welcomeScreenRouteName,
                                    (route) => false);
                              },
                              icon: const Icon(
                                Icons.login_outlined,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                        Container(
                          color: Colors.grey.withOpacity(0.2),
                          width: double.infinity,
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            children: [
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data?.picture ?? '',
                                  imageBuilder: (context, imageProvider) => CircleAvatar(
                                    radius: 70,
                                    backgroundColor: Color(0XFFF1F1F7),
                                    backgroundImage: imageProvider,

                                  ),

                                  // imageUrl: "https://images.pexels.com/photos/259915/pexels-photo-259915.jpeg",
                                  // fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.person,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                ),


                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${snapshot.data?.firstName} ${snapshot.data?.middleName}  ${snapshot.data?.lastName} ',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          AccountInfoPage.accountInfoPage,
                                          arguments: {
                                            'accountInfo': snapshot.data,
                                          });
                                    },
                                    leading: const Icon(Icons.person,
                                        color: Colors.black),
                                    title: const Text(
                                      'Account',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: const Icon(Icons.chevron_right,
                                        color: Colors.black),
                                  ),
                                  const Divider(),
                                ],
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        Membership.membershipPageRouteName,
                                      );
                                    },
                                    leading: const Icon(Icons.group,
                                        color: Colors.black),
                                    title: const Text(
                                      'My Membership',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: const Icon(Icons.chevron_right,
                                        color: Colors.black),
                                  ),
                                  const Divider(),
                                ],
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        PaymentHistory
                                            .paymentHistoryPageRouteName,
                                      );
                                      sl<PaymentHistoryBloc>().add(onLoadedPaymentHistory());
                                    },
                                    leading: const Icon(Icons.history,
                                        color: Colors.black),
                                    title: const Text(
                                      'Payment History',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: const Icon(Icons.chevron_right,
                                        color: Colors.black),
                                  ),
                                  const Divider(),
                                ],
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    leading: const Icon(Icons.money,
                                        color: Colors.black),
                                    title: const Text(
                                      'Bank Account',
                                      style:
                                          TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    trailing: const Icon(Icons.chevron_right,
                                        color: Colors.black),
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      // ]))
                    ],
                  ),
                ),
              );
              // return Text((snapshot.data as Map)['first_name'] ?? '');
            }
            return const Center(
              child: Text('Cannot find user information!'),
            );
          } else if (snapshot.data == []) {
            return const Center(
              child: Text('Cannot find user information!'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        })
        );
  }
}

Future<User> getUserInfo() async {
  late User authData;
  try {
    print('auth data is here: before');
    authData = User.fromJson(await sl<LocalStorageService>().read('user'));
    print('auth data is here: $authData');
  } on Exception {
    // do something
    authData = [] as User;
    if (kDebugMode) {
      print('user loading is failed: in profile page');
    }
  }
  return authData;
}
