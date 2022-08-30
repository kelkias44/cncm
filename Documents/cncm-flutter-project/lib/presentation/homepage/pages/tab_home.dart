import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/pages/AssetManagePage.dart';
import 'package:cncm_flutter_new/presentation/earning/pages/earnings.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newfeed_state.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/state.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/notification_page.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/tab_profile.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/trailer_detail.dart';
import 'package:cncm_flutter_new/presentation/notification_bloc/bloc/notification_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../data/models/LoginUser.dart';
import '../../../service_locator.dart';
import '../../assets_manager/bloc/bloc.dart';
import '../../assets_manager/bloc/state.dart';
import '../../common/widgets/customLoader.dart';

import '../../earning/bloc/earnings_bloc.dart';

import '../../profile/payment_history/bloc/payment_history_bloc.dart';
import '../../profile/payment_history/pages/membership.dart';
import 'package:badges/badges.dart';

import '../blocs/unreadcount_bloc/bloc/unreadcount_bloc.dart';

class TabHomePage extends StatelessWidget {
  const TabHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image.asset(
                'assets/header_element.png',
                fit: BoxFit.fill,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/logo.svg',
                      width: 20,
                      height: 20,
                    ),
                    BlocBuilder<UnreadcountBloc, UnreadcountState>(
                      builder: (context, state) {
                        var count = 0;
                        if (state is LoadedUnreadNotification) {
                          count = state.notificationResults.unread;
                          log("this is count $count");
                        }
                        return IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context,
                                  NotificationPage.notificationPageRouteName);
                              sl<NotificationBloc>().add(LoadNotification());
                            },
                            icon: (count == 0)
                                ? const Padding(
                                    padding:
                                        EdgeInsets.only(left: 20.0, bottom: 50),
                                    child: Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  )
                                : Badge(
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 50.0,
                                        left: 15.0,
                                      ),
                                      child: Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    badgeContent: Text(''),
                                    badgeColor: Colors.green,
                                    position: BadgePosition.topEnd(),
                                  ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(height: 10),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            // child: SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: choiceCard(
                              title: 'Membership',
                              text: FutureBuilder<User>(
                                  future: getUserInfo(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data != null) {
                                        if (!snapshot.data!.payments.membership
                                                .expired ||
                                            snapshot.data!.payments.membership
                                                    .amount ==
                                                0) {
                                          return const Text(
                                            'Active',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.green,
                                            ),
                                          );
                                        } else if (!snapshot.data!.payments
                                                .membership.expired ||
                                            snapshot.data!.payments.membership
                                                    .amount >
                                                0) {
                                          return const Text(
                                            'Not payed',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.green,
                                            ),
                                          );
                                        } else if (snapshot.data!.payments
                                            .membership.expired) {
                                          return const Text(
                                            'Expired',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.green,
                                            ),
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      } else {
                                        return const SizedBox();
                                      }
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                              icon: const Icon(
                                Icons.person,
                                color: Colors.green,
                                size: 25,
                              ),
                              onClick: () {
                                sl<PaymentHistoryBloc>()
                                    .add(onLoadedPaymentHistory());
                                Navigator.pushNamed(
                                  context,
                                  Membership.membershipPageRouteName,
                                );
                              })),
                      Expanded(
                        flex: 1,
                        child: choiceCard(
                            title: 'My Asset',
                            text:
                                BlocConsumer<AssetManageBloc, AssetManageState>(
                                    listener: (context, assetManageState) {},
                                    builder: (context, assetManageState) {
                                      if (assetManageState is LoadedAssets) {
                                        return Text(
                                          '${assetManageState.assetResults.count} Assets',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.green,
                                          ),
                                        );
                                      } else if (assetManageState
                                          is LoadingAssets) {
                                        return Center(
                                            child: SpinKitRipple(
                                          size: 30,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return const DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                              ),
                                            );
                                          },
                                        ));
                                      } else {
                                        return const SizedBox();
                                      }
                                    }),
                            icon: const Icon(
                              Icons.person,
                              color: Colors.green,
                              size: 25,
                            ),
                            onClick: () {
                              Navigator.pushNamed(
                                context,
                                AssetManagePage.assetManageListPageRouteName,
                              );
                            }),
                      ),
                      Expanded(
                          flex: 1,
                          child: choiceCard(
                            title: 'Earning',
                            text: BlocConsumer<EarningsBloc, EarningsState>(
                                listener: (context, State) {},
                                builder: (context, State) {
                                  if (State is EarningsLoaded) {
                                    return Text(
                                      '${State.earningResults.totalAmount} ETB',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.green,
                                      ),
                                    );
                                  } else if (State is EarningsLoading) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return const SizedBox();
                                  }
                                }),
                            icon: const Icon(
                              Icons.person,
                              color: Colors.green,
                              size: 25,
                            ),
                            onClick: () {
                              Navigator.pushNamed(
                                context,
                                EarningsPage.earningsPageRouteName,
                              );
                            },
                          ))
                    ])),
          ),
        ),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(height: 20),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'New Releases',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.chevron_right)),
            ],
          ),
        ),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(
          height: 200,
          child: TrailerWidget(),
        ),
      ),
      const SliverToBoxAdapter(
        child: SizedBox(height: 5),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'News Feed',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.chevron_right)),
            ],
          ),
        ),
      ),
      const SliverToBoxAdapter(
        child: Divider(),
      ),
      BlocBuilder<NewsFeedBloc, NewsFeedState>(builder: (context, state) {
        return (state is LoadedNewsFeed)
            ? SliverToBoxAdapter(
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: state.newsFeed.length,
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Container(
                            // height: 350,
                            margin: const EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(12)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: state.newsFeed[index].thumbnail,
                                      placeholder: (context, url) =>
                                          customLoader(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.image_not_supported,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  // Image.asset(
                                  //   'assets/header_element.png',
                                  //   fit: BoxFit.cover,
                                  // )
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  child: Text(state.newsFeed[index].title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.05)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  child: ReadMoreText(
                                      state.newsFeed[index].body!.description,
                                      trimLines: 1,
                                      // maxLines: 2,
                                      // overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 1)),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  width: double.infinity,
                                  child: Text(
                                      timeago
                                          .format(state.newsFeed[index].time),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                          letterSpacing: 1.05)),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              )
            : const SliverToBoxAdapter(child: SizedBox());
      }),
    ]);
  }
}

class TrailerDetailArgument {
  String videoUrl;
  int index;

  TrailerDetailArgument({required this.videoUrl, required this.index});
}

class TrailerWidget extends StatelessWidget {
  const TrailerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrailerBloc, TrailerState>(
      listener: (context, state) {
        if (state is ErrorGettingTrailer) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorResponse.message,
              ),
            ),
          );
        }
      },
      builder: (context, trailerState) {
        if (trailerState is LoadedTrailer) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: trailerState.newsFeed.length,
              primary: false,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, TrailerDetailView.trailerDetailPage,
                        arguments: TrailerDetailArgument(
                            videoUrl: trailerState.newsFeed[index].body!.link,
                            index: index));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          width: 255,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: YoutubePlayer.convertUrlToId(
                                      trailerState
                                          .newsFeed[index].body!.link) ??
                                  "",
                              //trailerState.newsFeed[index].body!.link,
                              flags: const YoutubePlayerFlags(
                                autoPlay: false,
                                mute: false,
                              ),
                            ),
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.amber,
                            progressColors: const ProgressBarColors(
                              playedColor: Colors.amber,
                              handleColor: Colors.amberAccent,
                            ),
                            onReady: () {
                              // _controller.addListener(() {
                              //
                              // },);
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trailerState.newsFeed[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  trailerState
                                      .newsFeed[index].body!.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            Text(
                              trailerState.newsFeed[index].body != null
                                  ? '3:11'
                                  : trailerState.newsFeed[index].body!.duration,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

Widget choiceCard(
    {required String title,
    required Widget text,
    required Icon icon,
    Function? onClick}) {
  return GestureDetector(
    onTap: () {
      onClick != null ? onClick() : debugPrint('Function is not provided');
    },
    child: Container(
      width: 115,
      // height: 10,
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                text,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
