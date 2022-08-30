import 'package:cached_network_image/cached_network_image.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newfeed_state.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../common/widgets/customLoader.dart';

class TabsBlog extends StatelessWidget {
  const TabsBlog({Key? key}) : super(key: key);  

  

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
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black,
          title: const Padding(
            padding: EdgeInsets.only(left: 50),
            child: Text(
              'Blogs',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlocConsumer<NewsFeedBloc, NewsFeedState>(
                    listener: (context, state) {
                  if (state is ErrorGettingFeeds) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorResponse.message,
                        ),
                      ),
                    );
                  }
                }, builder: (context, state) {
                  if (state is LoadedNewsFeed) {
                    return ListView.builder(
                        itemCount: state.newsFeed.length,
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Container(
                            height: 350,
                            margin: const EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
    
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 250,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl:state.newsFeed[index].thumbnail ,
                                      placeholder: (context, url) => customLoader(),
                                      errorWidget: (context, url, error) => const Icon(
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
    
                                  child:
                                  Text(state.newsFeed[index].title,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          letterSpacing: 1.05)),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  width: double.infinity,
                                  child: Text(
                                      timeago.format(state.newsFeed[index].time),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          letterSpacing: 1.05)),
                                ),
                              ],
                            ),
                          );
                        });
                  } else if (state is LoadingNewFeed) {
                    const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(child: CircularProgressIndicator()),
                        ));
                  }
                  return  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
