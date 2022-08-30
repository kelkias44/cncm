import 'package:cncm_flutter_new/presentation/assets_manager/pages/AssetManagePage.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/tab_profile.dart';
import 'package:cncm_flutter_new/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:cncm_flutter_new/core/colors.dart';
import 'package:cncm_flutter_new/data/models/chart_data.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/bloc/bloc.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/bloc/state.dart';
import 'package:cncm_flutter_new/presentation/earning/bloc/earnings_bloc.dart';
import 'package:cncm_flutter_new/presentation/earning/chartBloc/bloc/chart_bloc.dart';
// import 'package:path/path.dart';

import '../../../data/models/LoginUser.dart';
import '../../common/widgets/custom_text_button.dart';
import '../../homepage/pages/homepage.dart';

class EarningsPage extends StatefulWidget {
  EarningsPage({Key? key}) : super(key: key);
  static const String earningsPageRouteName = 'earnings_page';

  @override
  State<EarningsPage> createState() => _EarningsPageState();
}

class _EarningsPageState extends State<EarningsPage> {
  static var selected = 1;

  @override
  void initState() {
    BlocProvider.of<ChartBloc>(context)
        .add(ChartOnLoaded(earningChartIndex: selected));

    super.initState();
  }

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
      child: RefreshIndicator(
      onRefresh: () async {},
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: Navigator.canPop(context)
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                )
              : const SizedBox(),
          title: const Text("Earnings"),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.black,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 25),
                            FutureBuilder<User>(
                                future: getUserInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      return Text(
                                        '${snapshot.data?.firstName} ${snapshot.data?.middleName}',
                                        style: const TextStyle(
                                            color: green,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  } else {
                                    return const SizedBox();
                                  }
                                }),
                            const SizedBox(height: 35),
                            const Text(
                              "Collected Royally",
                              style: TextStyle(
                                color: green,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 5),
                            BlocBuilder<EarningsBloc, EarningsState>(
                              builder: ((context, state) {
                                if (state is EarningsLoading) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 10,
                                        width: 50,
                                        color: Colors.white,
                                      ));
                                } else if (state is EarningsLoaded) {
                                  return Text(
                                    '${state.earningResults.totalAmount} ETB',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  );
                                } else if (state is ErrorGettingEarningsData) {
                                  return Text(state.errorResponse.message);
                                } else {
                                  return const SizedBox();
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context,
                              AssetManagePage.assetManageListPageRouteName);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.2,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: cardColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/music.svg',
                                width: 30,
                                height: 30,
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "My Assets",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // const SizedBox(
                              //   height: 5,
                              // ),
                              BlocBuilder<AssetManageBloc, AssetManageState>(
                                  builder: (context, state) {
                                if (state is LoadingAssets) {
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 10,
                                        width: 50,
                                        color: Colors.white,
                                      ));
                                } else if (state is LoadedAssets) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "${state.assetResults.count} Assets",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.arrow_forward,
                                          color: green),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              })
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Asset Usage",
                  style: TextStyle(fontSize: 18, color: green),
                )),
              ),
              const Center(
                  child: Divider(
                indent: 20,
                endIndent: 20,
              )),

              /// horizontal buttons
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customTextButton(
                          onPressed: () {
                            setState(() {
                              selected = 1;
                            });
                            sl<ChartBloc>().add(
                                ChartOnLoaded(earningChartIndex: selected));
                          },
                          text: "DAY",
                          backgroundColor:
                              selected == 1 ? green : Colors.transparent,
                          textColor: selected == 1 ? Colors.white : greyText),
                      customTextButton(
                          onPressed: () {
                            setState(() {
                              selected = 2;
                            });
                            sl<ChartBloc>().add(
                                ChartOnLoaded(earningChartIndex: selected));
                          },
                          text: "WEEK",
                          backgroundColor:
                              selected == 2 ? green : Colors.transparent,
                          textColor: selected == 2 ? Colors.white : greyText),
                      customTextButton(
                          onPressed: () {
                            setState(() {
                              selected = 3;
                            });
                            sl<ChartBloc>().add(
                                ChartOnLoaded(earningChartIndex: selected));
                          },
                          text: "MONTH",
                          backgroundColor:
                              selected == 3 ? green : Colors.transparent,
                          textColor: selected == 3 ? Colors.white : greyText),
                      customTextButton(
                          onPressed: () {
                            setState(() {
                              selected = 4;
                            });
                            sl<ChartBloc>().add(
                                ChartOnLoaded(earningChartIndex: selected));
                          },
                          text: "YEAR",
                          backgroundColor:
                              selected == 4 ? green : Colors.transparent,
                          textColor: selected == 4 ? Colors.white : greyText),
                    ],
                  ),
                ),
              ),
              BlocBuilder<ChartBloc, ChartState>(
                builder: (context, state) {
                  if (state is ChartLoading) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8),
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          color: Colors.white,
                        ));
                  } else if (state is ChartLoaded) {
                    return earningChart(state.chartResults, context);
                  } else if (state is ErrorGettingChartData) {
                    return Text(state.errorResponse.message);
                  } else {
                    return const Text('unable to load the graph');
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}

Widget earningChart(List<ChartResult> results, BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8),
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            //  labelStyle: const TextStyle(fontSize: 10),
            maximumLabels: 50,
            autoScrollingDelta: 4,
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(width: 0),
          ),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
          ),
          series: <ChartSeries<ChartResult, String>>[
            // Renders column chart
            ColumnSeries<ChartResult, String>(
              color: const Color(0xFF403D3D),
              width: 0.2,
              dataSource: results,
              xValueMapper: (ChartResult data, _) => data.date,
              yValueMapper: (ChartResult data, _) => data.amount,
            )
          ]),
    ),
  );
}
