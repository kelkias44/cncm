import 'package:cncm_flutter_new/data/models/LoginUser.dart';
import 'package:cncm_flutter_new/data/repositories/membership_payment_repository.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/custom_button.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/tab_profile.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/bloc/payment_history_bloc.dart';
import 'package:cncm_flutter_new/presentation/profile/payment_history/pages/payment_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/colors.dart';
import '../../../../service_locator.dart';
import '../../widgets/PaymentHistoryCard.dart';
import 'package:url_launcher/url_launcher.dart';

class Membership extends StatelessWidget {
  Membership({Key? key}) : super(key: key);
  final Uri _url = Uri.parse('https://api.a2p.et:3331/checkout/a0bc8aeb-60a4-47d9-b3a9-fee55d9ea161');
  static const String membershipPageRouteName = 'membership_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Membership'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const <Widget> [
                                    Icon(
                                  Icons.star,
                                  color: green,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star,
                                  color: green,
                                  size: 15,
                                ),
                                  ],
                                ),
                                const Icon(
                                  Icons.groups_outlined,
                                  color: green,
                                  size: 35,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text("Monthly membership payment",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: greyText)),
                              const SizedBox(
                                height: 2,
                              ),
                              FutureBuilder<User>(
                                  future: getUserInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data != null) {
                                        return Text(
                                          '${snapshot.data!.payments.membership.amount} ETB',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    } else {
                                      return const SizedBox();
                                    }
                                  })
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: FutureBuilder<User>(
                            future: getUserInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  return (snapshot.data!.payments.membership
                                              .amount == 0) ?
                                       customButton(
                                          text: 'Pay now', onClick: (){},)
                                     :
                                     customButton(
                                          text: 'Pay now',
                                          onClick: () {
                                           sl<MembershipPaymentRepository>().paymentRequest();
                                          });
                                } else {
                                  return const SizedBox();
                                }
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Previous Transaction",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: greyText)),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PaymentHistory.paymentHistoryPageRouteName,
                        );
                          sl<PaymentHistoryBloc>().add(onLoadedPaymentHistory());
                      },
                      child: const Text("See All",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: green),
                      ),

                  ),



                ],
              ),
            ),
            BlocBuilder<PaymentHistoryBloc, PaymentHistoryState>(
  builder: (context, state) {
    if(state is PaymentHistoryLoading){
      return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (ctx,i){
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor:Colors.grey[100]!,
                          child: Container(
                            height: 130,
                            color: Colors.white,
                          ),                 
                        ),
                      );
                    }
                  ),
                );
    }else if(state is PaymentHistoryLoaded){
      if(state.payments.isNotEmpty){
        return SizedBox(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (cxt, i) {
                return PaymentHistoryCard(payment: state.payments[i]);
              },
                  ),
          );}else{
        return const Center(child: Text('No Payment History Yet',style: TextStyle(fontSize: 20,),));
      }
    }else if(state is PaymentHistoryError){
      return Text(state.message);
    }else{
      return const SizedBox();
    }
  },
)

          ],
        ),
      ),
    );
  }
}


