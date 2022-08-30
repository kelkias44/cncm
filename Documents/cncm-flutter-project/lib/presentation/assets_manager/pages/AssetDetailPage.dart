import 'package:cncm_flutter_new/core/colors.dart';
import 'package:cncm_flutter_new/core/constants.dart';
import 'package:cncm_flutter_new/presentation/common/extension/string_capitalization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'AssetManagePage.dart';


class AssetDetailPage extends StatelessWidget {
  const AssetDetailPage({Key? key,required this.assetDetailViewArg}) : super(key: key);
  final AssetDetailArgument assetDetailViewArg;
  static const String assetDetailRouteName =
      'assetDetailPageRouteName';
  final Kpadding = 15.0;
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
        title: const Text("Asset Detail"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //card one for asset detail
              Card(
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    ///yellow container with icon and title
                    Container(
                      padding:const EdgeInsets.all(10),
                      color: lightYellow,
                      height: 150,
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: SvgPicture.asset(
                                'assets/${assetDetailViewArg.assetData.department!.type}.svg',
                                width: 60,
                                height: 60,
                              ),),
                              Expanded(
                              flex: 2,
                              child: Text(
                                assetDetailViewArg.assetData.department!.type!.inCaps,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    /// green border container with earned amount
                    Container(
                      height: 65  ,
                      margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: green),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Expanded(
                              flex:2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:const [
                                  Icon(Icons.clean_hands,color: green,),
                                  SizedBox(height:5),
                                  Text("30000 Times",style: TextStyle(fontWeight: FontWeight.bold),)
                                ]
                              ),
                            ),
                         const SizedBox(width: 10,),
                            Container(
                              width: 1,
                              height: 45,
                              color: green,
                            ),
                         const SizedBox(width: 10,),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:const[
                                Icon(Icons.clean_hands,color: green,),
                                SizedBox(height:5),
                                Text("30000 ETB",style: TextStyle(fontWeight: FontWeight.bold),)
                              ]
                        ),
                          ),

                      ],),
                    ),
                    ( assetDetailViewArg.assetData.department!.type == theatreAndDrama || assetDetailViewArg.assetData.department!.type == audioVisualAndFilm) ?
                    Padding(
                      padding:   EdgeInsets.only(left: Kpadding,top:8.0),
                      child: const Text("Genere" ,style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black26)),
                    ):
                      Padding(
                      padding:   EdgeInsets.only(left: Kpadding,top:8.0),
                      child: const Text("Description" ,style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black26)),
                    ),
                    ( assetDetailViewArg.assetData.department!.type == theatreAndDrama || assetDetailViewArg.assetData.department!.type == audioVisualAndFilm) ?
                    Padding(
                      padding:  EdgeInsets.all( Kpadding),
                      child:  Text(
                        assetDetailViewArg.assetData.assetMetaData!.genre!
                        ,
                        overflow: TextOverflow.clip,
                      ),
                    ):
                    Padding(
                      padding:  EdgeInsets.all( Kpadding),
                      child:  Text(
                        assetDetailViewArg.assetData.description!,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const Divider(),

                    buildDetailRow(title1:"Author",value1:assetDetailViewArg.assetData.assetMetaData!.author!,
                        title2:"Title",value2:assetDetailViewArg.assetData.name!),
                    buildDetailRow(title1:"Language",value1:assetDetailViewArg.assetData.assetMetaData!.language!,
                        title2:"Subject",value2:assetDetailViewArg.assetData.assetMetaData!.subject!),
                   // buildDetailRow(),
                    assetDetailViewArg.assetData.department!.type == literature ?
                    buildDetailRowOne(title:"Page Number" ,value: assetDetailViewArg.assetData.assetMetaData!.numberOfPages.toString()) :
                    ( assetDetailViewArg.assetData.department!.type == theatreAndDrama || assetDetailViewArg.assetData.department!.type == audioVisualAndFilm) ?
                    buildDetailRow(title1:"Duration",value1:assetDetailViewArg.assetData.assetMetaData!.runtime!,
                        title2:"Production",value2:assetDetailViewArg.assetData.assetMetaData!.production!)

                        :buildDetailRowOne(title:"Duration" ,value: assetDetailViewArg.assetData.assetMetaData!.runtime!),
                    const Divider(),
                   buildDetailRow(title1:"Copyright Status",value1:assetDetailViewArg.assetData.assetMetaData!.copyrightStatus!,
                       title2:"Release Date",value2:assetDetailViewArg.assetData.assetMetaData!.releaseDate!),

          ( assetDetailViewArg.assetData.department!.type == theatreAndDrama || assetDetailViewArg.assetData.department!.type == audioVisualAndFilm) ?
        buildDetailRow(title1:"Director Name",value1:assetDetailViewArg.assetData.assetMetaData!.director!,
              title2:"Writer Name",value2:assetDetailViewArg.assetData.assetMetaData!.writer!)

             :buildDetailRow(title1:"Publisher Name",value1:assetDetailViewArg.assetData.assetMetaData!.publisher!.name!,
                        title2:"Ownership Percentage",value2:assetDetailViewArg.assetData.assetMetaData!.publisher!.sharePercentage!),
                    //const Divider(),

                    //buildDetailRow(),
                  ],
                ),
              ),
              /// car for Actors only displayed when there is actor
              (assetDetailViewArg.assetData.assetMetaData!.actors!.isNotEmpty && assetDetailViewArg.assetData.assetMetaData!.type != music )?
              Card(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          topLeft: Radius.circular(12.0),
                        ),
                      ),
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          const Text("Actors",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: green),),
                          Text("${assetDetailViewArg.assetData.assetMetaData!.actors!.length.toString()} Actors",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),),

                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 0,
                          child: Container(
                            height:  ((assetDetailViewArg.assetData.assetMetaData!.actors!.length) * 70),
                            width: 2,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            height:  ((assetDetailViewArg.assetData.assetMetaData!.actors!.length) * 70),
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: assetDetailViewArg.assetData.assetMetaData!.actors!.length,
                                itemBuilder: (context, i) {
                                  return buildActorsDetailRow(fulName: assetDetailViewArg.assetData.assetMetaData!.actors![i].name!,role: assetDetailViewArg.assetData.assetMetaData!.actors![i].role!);
                                }),
                          ),
                        ),
                      ],),

                  ],
                ),
              ):Container(),


              //card two for contributors
              Card(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12.0),
                          topLeft: Radius.circular(12.0),
                        ),
                      ),
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                         const Text("Contributors",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: green),),
                          Text("${assetDetailViewArg.assetData.assetMetaData!.contributors!.length.toString()} Contributors",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.white),),

                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        height:  ((assetDetailViewArg.assetData.assetMetaData!.contributors!.length) * 70),
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        height:  ((assetDetailViewArg.assetData.assetMetaData!.contributors!.length) * 70),
                        child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: assetDetailViewArg.assetData.assetMetaData!.contributors!.length,
                        itemBuilder: (context, i) {
                          return buildContributorsDetailRow(fulName: assetDetailViewArg.assetData.assetMetaData!.contributors![i].name!,percentage: assetDetailViewArg.assetData.assetMetaData!.contributors![i].sharePercentage.toString(),role: assetDetailViewArg.assetData.assetMetaData!.contributors![i].role!);
                        }),
                      ),
                    ),
                  ],),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// build detail row contain two items in row
    Padding buildDetailRow(
        {required String title1, required String value1,required String title2,required String value2}){
      return Padding(
                padding:  EdgeInsets.all(Kpadding),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children:   [
                          Text(
                            title1,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black26),
                          ),
                         const SizedBox(
                            height: 3,
                          ),
                          Text(
                            value1,
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
                          Text(
                            title2,
                            style:const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black26),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            value2,
                            style:const TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
    }

  /// build detail row contain one item in row
  Padding buildDetailRowOne({required String title,required String value}){
    return Padding(
      padding:  EdgeInsets.all(Kpadding),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children:   [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                ),
                const SizedBox(
                  height: 3
                ),
                Text(
                  value,
                  style:const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w700),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
  /// build Actors detail row contain two items in row
  Padding buildActorsDetailRow({required String fulName,required String role}){
    return Padding(
      padding:  EdgeInsets.all(Kpadding),
      child: Row(
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
                  "Full Name",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                ),
                const SizedBox(
                    height: 3
                ),
                Text(
                  fulName,
                  style:const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w700),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children:  [
                const   Text(
                  "Role",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                ),
                const  SizedBox(
                    height: 3
                ),
                Text(
                  role,
                  style:const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  /// build contributors detail row contain three items in row
  Padding buildContributorsDetailRow({required String fulName,required String percentage,required String role}){
    return Padding(
      padding:  EdgeInsets.all(Kpadding),
      child: Row(
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
                  "Full Name",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                ),
                const SizedBox(
                  height: 3
                ),
                Text(
                  fulName,
                  style:const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w700),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children:  [
                const Text(
                  "Percentage",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                ),
                const SizedBox(
                  height: 3
                ),
                Text(
                  "$percentage%",
                  style:const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w700),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children:  [
                const   Text(
                  "Role",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26),
                ),
                const  SizedBox(
                  height: 3
                ),
                Text(
                  role,
                  style:const TextStyle(
                      fontSize: 14,
                      fontWeight:
                      FontWeight.w700),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



}
