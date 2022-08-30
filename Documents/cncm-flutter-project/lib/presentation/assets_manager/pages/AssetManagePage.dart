import 'dart:developer';

import 'package:cncm_flutter_new/core/colors.dart';
import 'package:cncm_flutter_new/core/constants.dart';
import 'package:cncm_flutter_new/data/models/AssetResponse.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/pages/AssetDetailPage.dart';
import 'package:cncm_flutter_new/presentation/auth/blocs/department_bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/common/widgets/customLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../service_locator.dart';
import '../../auth/blocs/department_bloc/state.dart';
import '../../auth/blocs/title_bloc/bloc.dart';
import '../../auth/blocs/title_bloc/event.dart';
import '../../common/ui_helper/CustomDialog.dart';

import '../bloc/bloc.dart';
import '../bloc/state.dart';
import '../widget/AssetCard.dart';
import 'add_assets_page.dart';






class AssetManagePage extends StatefulWidget {
  static const String assetManageListPageRouteName =
      'assetManageListPageRouteName';
  AssetManagePage({Key? key}) : super(key: key);
  @override
  State<AssetManagePage> createState() => _AssetManagePageState();
}
class AssetDetailArgument {
  Asset assetData;

  AssetDetailArgument({ required this.assetData});
}
class _AssetManagePageState extends State<AssetManagePage> {
  final _kSpacer = 15.0;
  String departmentId = "";
  void showAlertDialog(BuildContext context) {
    /// show dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.98,
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[200],
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: BlocBuilder<DepartmentBloc, DepartmentState>(
            builder: (context, state) {
              return
              state is LoadedDepartments ?
                Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const Text("Choose Asset Department",
                              style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
                          const Divider(),
                          SizedBox(height: _kSpacer),
                          assetTypeListTile(
                              title: 'Literature', icon: literature, onTap: () {
                               for(int i=0;i< state.departments.length;i++){
                                 if(state.departments[i].type == literature){
                                   departmentId = state.departments[i].id;
                                 }
                               }
                               log("departmentId: $departmentId");
                            Navigator.pushNamed(
                              context,
                              AddAssetPage.addAssetPage,
                              arguments: AssetTypeArgument(assetType: literature,departmentId: departmentId),
                            );
                          }),
                          SizedBox(height: _kSpacer),
                          assetTypeListTile(
                              title: 'Music', icon: music, onTap: () {
                            for(int i=0;i< state.departments.length;i++){
                              if(state.departments[i].type == music){
                                departmentId = state.departments[i].id;
                              }
                            }
                            Navigator.pushNamed(
                              context,
                              AddAssetPage.addAssetPage,
                              arguments: AssetTypeArgument(assetType: music,departmentId: departmentId),
                            );
                          }),
                          SizedBox(height: _kSpacer),
                          assetTypeListTile(
                              title: 'Photography', icon: photography, onTap: () {
                            for(int i=0;i< state.departments.length;i++){
                              if(state.departments[i].type == photography){
                                departmentId = state.departments[i].id;
                              }
                            }
                            Navigator.pushNamed(
                              context,
                              AddAssetPage.addAssetPage,
                              arguments: AssetTypeArgument(assetType: photography,departmentId: departmentId),
                            );
                          }),
                          SizedBox(height: _kSpacer),
                          assetTypeListTile(
                              title: 'Audiovisual & Film',
                              icon: audioVisualAndFilm,
                              onTap: () {
                                for(int i=0;i< state.departments.length;i++){
                                  if(state.departments[i].type == audioVisualAndFilm){
                                    departmentId = state.departments[i].id;
                                  }
                                }
                                Navigator.pushNamed(
                                  context,
                                  AddAssetPage.addAssetPage,
                                  arguments: AssetTypeArgument(assetType: audioVisualAndFilm,departmentId: departmentId),
                                );
                              }),
                          SizedBox(height: _kSpacer),
                          assetTypeListTile(
                              title: 'Theatre & Drama',
                              icon: theatreAndDrama,
                              onTap: () {
                                for(int i=0;i< state.departments.length;i++){
                                  if(state.departments[i].type == theatreAndDrama){
                                    departmentId = state.departments[i].id;
                                  }
                                }
                                Navigator.pushNamed(
                                  context,
                                  AddAssetPage.addAssetPage,
                                  arguments: AssetTypeArgument(assetType: theatreAndDrama,departmentId: departmentId),
                                );
                              }),
                        ],
                      ):
              state is LoadingDepartments ?
              Center(child: customLoader()) :
              const Center(child: Text('No departments found'));
            },
          ),
          ),
        );
      },
    );
  }
/// asset types for dialog custom list tile
  InkWell assetTypeListTile(
      {required String title, required String icon, required Function onTap}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(); // close the dialog
        onTap();
      },
      splashColor: Colors.green[100],
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 32,
              height: 40,
              child: SvgPicture.asset(
                'assets/$icon.svg',
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssetManageBloc, AssetManageState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125.0),
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    centerTitle: true,
                    title: const Text("Assets"),
                    backgroundColor: Colors.black,
                    elevation: 0,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      state is LoadedAssets ?
                       Text('${state.assetResults.assetData!.assets!.length} Assets',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600)) : const SizedBox(),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: green,
                          backgroundColor: Colors.white10, // Background Color
                        ),
                        child: SizedBox(
                          height: 20,
                          width: 110,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add_circle_outline,
                                color: green,
                                size: 20,
                              ),
                              SizedBox(width: 5),
                              Text('Add Asset')
                            ],
                          ),
                        ),
                        onPressed: () {
                           showAlertDialog(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child:
               state is LoadedAssets ?
                ListView.builder(
                    itemCount: state.assetResults.assetData!.assets!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AssetDetailPage.assetDetailRouteName,
                                arguments: AssetDetailArgument(
                                   assetData: state.assetResults.assetData!.assets![i]));
                          },
                          child: AssetCard(
                              assetName: (state.assetResults.assetData!.assets![i].department!.type! == music)?
                              state.assetResults.assetData!.assets![i].assetMetaData!.trackName! : state.assetResults.assetData!.assets![i].assetMetaData!.title!,
                              assetDepartment: state.assetResults.assetData!.assets![i].department!.name!,
                              status: state.assetResults.assetData!.assets![i].status!,
                              assetType: state.assetResults.assetData!.assets![i].department!.type!,
                              id: state.assetResults.assetData!.assets![i].id!,));
                    }) :
                state is LoadingAssets ?
                  SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (ctx,i){
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor:Colors.grey[100]!,
                          child: Container(
                            height: 160,
                            color: Colors.white,
                          ),                 
                        ),
                      );
                    }
                  ),
                ) : const SizedBox(),
                 

        )       
      );
    },
  );
  }
}

class AssetTypeArgument {
  String assetType;
  String departmentId;
  AssetTypeArgument({required this.assetType, required this.departmentId});
}