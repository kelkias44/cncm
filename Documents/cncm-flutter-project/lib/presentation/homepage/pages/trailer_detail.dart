import 'package:cncm_flutter_new/presentation/homepage/pages/tab_home.dart';
import 'package:cncm_flutter_new/presentation/homepage/widgets/related_trailers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../blocs/trailer/bloc.dart';
import '../blocs/trailer/state.dart';
import 'homepage.dart';

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
                  onTap: () {},
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
                                mute: true,
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
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trailerState.newsFeed[index].title,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  trailerState
                                      .newsFeed[index].body!.description,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            const SizedBox(width: 80),
                            Text(
                              trailerState.newsFeed[index].body != null
                                  ? '3:11'
                                  : trailerState.newsFeed[index].body!.duration,
                              style: const TextStyle(color: Colors.grey),
                            ),
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

class TrailerDetailView extends StatelessWidget {
  const TrailerDetailView({Key? key, required this.trailerDetailViewArg})
      : super(key: key);
  static const String trailerDetailPage = 'trailerDetailPage';
  final TrailerDetailArgument trailerDetailViewArg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Clips",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(
                          trailerDetailViewArg.videoUrl) ??
                      "",
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                  ),
                ),
              ),
              builder: (context, player) {
                return BlocConsumer<TrailerBloc, TrailerState>(
                  listener: (context, trailerState) {
                    if (trailerState is ErrorGettingTrailer) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            trailerState.errorResponse.message,
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadedTrailer) {
                      return Column(
                        children: [
                          // some widgets
                          player,
      
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.newsFeed[trailerDetailViewArg.index]
                                          .title,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      state.newsFeed[trailerDetailViewArg.index]
                                          .body!.description,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 80),
                                Text(
                                  state.newsFeed[trailerDetailViewArg.index].body
                                              ?.duration ==
                                          ""
                                      ? '00:00'
                                      : state.newsFeed[trailerDetailViewArg.index]
                                          .body!.duration,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
      
                          const TrailerRelated(),
                        ],
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            ),
      ),
    );
  }
}











// Padding(
                          //   padding: const EdgeInsets.only(left: 10, right: 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       const Text(
                          //         'Related',
                          //         style: TextStyle(
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 16),
                          //       ),
                          //       IconButton(
                          //           onPressed: () {},
                          //           icon: const Icon(Icons.chevron_right)),
                          //     ],
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 250,
                          //   child:  TrailerWidget()),
                          //some other widgets
