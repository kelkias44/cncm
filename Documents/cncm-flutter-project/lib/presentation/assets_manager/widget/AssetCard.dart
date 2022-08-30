import 'package:cncm_flutter_new/core/constants.dart';
import 'package:cncm_flutter_new/data/repositories/asset_payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


import '../../../core/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../service_locator.dart';


class AssetCard extends StatelessWidget {
  const AssetCard({
    Key? key,
    required this.assetName,
    required this.assetDepartment,
    required this.status,
    required this.assetType,
    required this.id
  }) : super(key: key);

  final String assetName;
  final String assetDepartment;
  final String status;
  final String assetType;
  final String id;






  @override
  Widget build(BuildContext context) {
    //  AssetPaymentRepository? assetPaymentRepository;
    // var _height = 160;
    // print("height of asset;$_height");
    return Container(
      padding: const EdgeInsets.all(8),
      height: 160, 
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: lightYellow,
                  child: Column(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: SvgPicture.asset(
                          'assets/$assetType.svg',
                          width: 40,
                          height: 40,
                        ),),
                        Text(assetDepartment,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,),
                     const Spacer(),
                      Container(
                        height: 10,
                        decoration:  BoxDecoration(
                          color: status == pending ? Colors.orangeAccent : status == approved ? green : status == rejected ? Colors.redAccent : Colors.grey,
                          shape: BoxShape.rectangle,
                          borderRadius:const BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            topLeft: Radius.circular(15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

            Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 4),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                           const SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children:  [
                                     const Text(
                                        "Asset",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black26),
                                      ),
                                    const  SizedBox(
                                        height: 3
                                      ),
                                      Text(
                                        assetName ,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children:  [
                                      const Text(
                                        "Department",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black26),
                                      ),
                                      const  SizedBox(
                                        height: 3
                                      ),
                                      Text(
                                        assetDepartment,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children:  [
                                      const Text("Status",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: Colors.black26)),
                                      const  SizedBox(
                                        height: 3
                                      ),
                                      Text(
                                        status,
                                        style:  TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: status == pending ? Colors.orangeAccent : status == approved ? green : Colors.red),
                                      ),

                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: status == pending ?  TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20.0),
                                      ),
                                    ),
                                    child: const SizedBox(
                                      height: 25,
                                      width: 110,
                                      child: Center(
                                          child:
                                          Text('Pay to Activate'),

                                      ),
                                    ),
                                    onPressed: () {
                                      // bloc.add(AssetTypeChangedEvent(AssetType.mysql));
                                      // const url = 'https://pub.dev/packages/url_launcher';
                                      print("Asset id of button:is before $id");

                                      sl<AssetPaymentRepository>().sendPayment( assetId: id);

                                    //   String checkoutId = "b8571bf5-aef9-4129-b067-afcba3512223";
                                    //   final  _url = "https://api.a2p.et:3331/checkout/15f2bb29-abc5-4dd4-a36d-d0dd46dbcce0";
                                    // _launchUrl(_url);


                                    //   htmlOpenLink();

                                    },
                                  ) : Container(),
                                ),
                                // Container(child: customButton(text: "Pay to Activate", onClick: (){})),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }


}