import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cncm_flutter_new/presentation/assets_manager/search_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/UserSearchResponse.dart';
 import '../../../service_locator.dart';
import '../../common/widgets/customLoader.dart';
import '../search_bloc/event.dart';
import '../search_bloc/state.dart';

  class UserSearchDelegate extends SearchDelegate<SearchedUsers?> {

   var searchBloc = sl<SearchedUserBloc>();
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
             close(context, null);
          } else {
            query = '';
          }
        })
  ];

  @override
  Widget? buildLeading(BuildContext context) => Container(
    child: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, null);
        }),
  );

  @override
  Widget buildResults(BuildContext context) => Container();
  // {
  //   sl<SearchedUserBloc>().add(LoadSearchedUsers(query:query));
  //   return BlocBuilder(
  //     bloc: searchBloc,
  //     builder: (BuildContext context, SearchedUserState state) {
  //       if (state is LoadingSearchedUser) {
  //         return  Center(
  //           child: customLoader(),
  //         );
  //       }
  //       if (state is ErrorGettingSearchUser) {
  //         return  const Text('Error');
  //       }
  //       if (state is LoadedSearchedUsers){
  //         return ListView.builder(
  //           itemBuilder: (context, index) {
  //             return ListTile(
  //               leading:const Icon(Icons.location_city),
  //               title: Text(state.searchResults.searchedUsers[index].firstName + ' ' + state.searchResults.searchedUsers[index].middleName + ' ' + state.searchResults.searchedUsers[index].lastName),
  //               onTap: () => close(context, state.searchResults.searchedUsers[index]),
  //             );
  //           },
  //           itemCount: state.searchResults.searchedUsers.length,
  //         );
  //       }
  //      return Container();
  //     },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context)
  {
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   String queryHold = query;
    //   if (queryHold != query) {
    //     query = queryHold;
    //     timer.cancel();
    //   }
    //   sl<SearchedUserBloc>().add(LoadSearchedUsers(query:query));
    // });
   sl<SearchedUserBloc>().add(LoadSearchedUsers(query:query));
    return BlocBuilder(
      bloc: searchBloc,
      builder: (BuildContext context, SearchedUserState state) {
        if (state is LoadingSearchedUser) {
          return  Center(
            child: customLoader(),
          );
        }
        if (state is ErrorGettingSearchUser) {
          return  const Text('Error');
        }
        if (state is LoadedSearchedUsers){
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                leading:  CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0XFFF1F1F7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Center(
                      child:CachedNetworkImage(
                        imageUrl: state.searchResults.searchedUsers[index].picture,
                        fit: BoxFit.fill,
                        // placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          color: Colors.green,
                          size: 20,
                        ),
                      ),

                    ),
                  ),
                ),
                title: Text(state.searchResults.searchedUsers[index].firstName + ' ' + state.searchResults.searchedUsers[index].middleName + ' ' + state.searchResults.searchedUsers[index].lastName),
                onTap: () => close(context, state.searchResults.searchedUsers[index]),
              );
            },
            itemCount: state.searchResults.searchedUsers.length,
          );
        }
        return Container();
      },
    );

    // return ListView.builder(
    //     itemCount: suggestions.length,
    //     itemBuilder: (context, index) {
    //       final suggestion = suggestions[index];
    //       return ListTile(
    //         title: Text(suggestion),
    //         onTap: () {
    //           query = suggestion;
    //         },
    //       );
    //     });
  }
}