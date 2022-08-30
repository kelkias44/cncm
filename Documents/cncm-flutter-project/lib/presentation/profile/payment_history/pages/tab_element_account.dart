import 'package:cached_network_image/cached_network_image.dart';
import 'package:cncm_flutter_new/data/models/LoginUser.dart';
import 'package:flutter/material.dart';

class AccountInfoPage extends StatelessWidget {
  final User? accountInfo;
  const AccountInfoPage({Key? key, this.accountInfo}) : super(key: key);

  static const String accountInfoPage = 'account info page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       Icons.notification_important,
        //       color: Colors.white,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey.withOpacity(0.2),
            width: double.infinity,
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      imageUrl: accountInfo?.picture ?? '',
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0XFFF1F1F7),
                        backgroundImage: imageProvider,

                      ),
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => const Icon(
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
                  '${accountInfo?.firstName} ${accountInfo?.middleName} ${accountInfo?.lastName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          //
          ListView(
            shrinkWrap: true,
            children: [
              /// name
              InfoItem(data: '${accountInfo?.firstName} ${accountInfo?.middleName} ${accountInfo?.lastName}', icon: Icons.person),
              /// phone
              InfoItem(data: accountInfo?.phone, icon: Icons.phone),
              ///age
              InfoItem(data: accountInfo?.age.toString(), icon: Icons.female),
              ///sex
              InfoItem(data: accountInfo?.gender, icon: Icons.supervised_user_circle),
              ///title
              InfoItem(data: accountInfo?.title ?? "No Title", icon: Icons.title),
            ],
          ),
        ],
      ),
    );
  }
}

///for profile detail items
class InfoItem extends StatelessWidget {
  const InfoItem({
    Key? key,
    required this.data,
    required this.icon
  }) : super(key: key);

  final String? data;
  final  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          leading: Icon(
            icon,
            color: Colors.green,
          ),
          title:  Text(
            data!,
          ),
        ),
        const Divider(),
      ],
    );
  }
}
