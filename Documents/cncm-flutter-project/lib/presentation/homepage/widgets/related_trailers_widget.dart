import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/bloc.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/trailer/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class TrailerRelated extends StatelessWidget {
  const TrailerRelated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Related',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.chevron_right)),
                            ],
                          ),
                        ),
        BlocConsumer<TrailerBloc, TrailerState>(
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
        builder: (context, state) {
          if(state is LoadedTrailer){
          return SizedBox(
              height: 350,
              child: SingleChildScrollView(
                  child: GridView.builder(       
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.newsFeed.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2
                            ),
                          itemBuilder: (ctx , i){
                            return InkWell(
                                onTap: () {},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.45,
                                        height: 130,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: YoutubePlayer(
                                          controller: YoutubePlayerController(
                                            initialVideoId: YoutubePlayer.convertUrlToId(
                                                    state
                                                        .newsFeed[i].body!.link) ??
                                                "",
                                            //state.newsFeed[i].body!.link,
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
                                      width: MediaQuery.of(context).size.width*0.45,
                                      height: 40,
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
                                                state.newsFeed[i].title,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              const SizedBox(height: 5),
                    
                                              Text(
                                                state
                                                    .newsFeed[i].body!.ownerName,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    overflow: TextOverflow.ellipsis),
                                              ),
                                            ],
                                          ),
                                          // const SizedBox(width: 80),
                                          Text(
                                            state.newsFeed[i].body != null
                                                ? '3:11'
                                                : state.newsFeed[i].body!.duration,
                                            style: const TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );                      
                          }
                  
                ),
              ),
          );
  }else if(state is LoadingTrailer){
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2
                ),
              itemBuilder: (context,i){
                    return Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: 130,
                      margin: const EdgeInsets.all(10),                    
                );
              })
        );
  }else{
      return const SizedBox();
  }})
        ],
      ),
    );
  }
}