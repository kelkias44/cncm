import 'dart:ui';



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../../notification_bloc/bloc/notification_bloc.dart';
import '../../notification_bloc/bloc/notification_state.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  static const String notificationPageRouteName = 'notificationPageRouteName';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  @override

  Widget build(BuildContext context) {
    String dateString ;
    String dateMonth;
    bool _istheSame = false;
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70.0),
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
                    title: const Text("Notifications"),
                    backgroundColor: Colors.black,
                    elevation: 0,
                  ),
                  const SizedBox(height: 10),
                  
                ],
              ),
            )
            ),
          body:  Stack(
              children: [
                
                if (state is LoadedNotification) ...[
                  ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: state.notificationResults.count,
                    itemBuilder: (context, index) {
                      var _isSeen = state.notificationResults.rows
                          .notifications[index].seen;
                      var _isGroupname = state.notificationResults.rows
                          .notifications[index].body.group.name;
                      print("here is the notification");
                      print(state.notificationResults.rows.notifications[index].title);


                      dateString = DateFormat('yyyy').format(state.notificationResults.rows.notifications[index].time);
                      dateMonth = DateFormat('MM').format(state.notificationResults.rows.notifications[index].time);
                      if(dateMonth == '01'){
                        dateMonth = "January";
                      }
                      if(dateMonth == '02'){
                        dateMonth = "February";
                      }
                      if(dateMonth == '03'){
                        dateMonth = "March";
                      }
                      if(dateMonth == '04'){
                        dateMonth = "April";
                      }
                      if(dateMonth == '05'){
                        dateMonth = "May";
                      }
                      if(dateMonth == '06'){
                        dateMonth = "June";
                      }
                      if(dateMonth == '07'){
                        dateMonth = "July";
                      }if(dateMonth == '08'){
                        dateMonth = "August";
                      }if(dateMonth == '09'){
                        dateMonth = "September";
                      }if(dateMonth == '10'){
                        dateMonth = "October";
                      }if(dateMonth == '11'){
                        dateMonth = "November";
                      }if(dateMonth == '12'){
                        dateMonth = "December";
                      }

                      return  Column(

                              children: [
                                // (index !=0)?
                                // const Divider(
                                //   color: Colors.grey,
                                //   indent: 15,
                                //
                                // ):const Text(''),

                                const SizedBox(
                                  height: 12,
                                ),
                                   StickyHeader(
                                      overlapHeaders:false,
                                     header: Container(
                                       width:double.infinity,
                                       padding:const EdgeInsets.all(16),
                                       color:const Color(0xCBCBCBC9),
                                       child: Text(dateString+' - '+dateMonth),
                                     ),
                                     content: ListTile(
                                      title: Text(
                                        state.notificationResults.rows.notifications[index].title,
                                        style: (_isSeen == false)?const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                        ):const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      subtitle: Text.rich(
                                        TextSpan(
                                            text: state.notificationResults.rows.notifications[index].body.message,
                                            style: (_isSeen == false)?const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            ):const TextStyle(
                                              fontSize: 14,
                                            ),
                                            children: [
                                              if(_isGroupname.isNotEmpty)...[
                                                const TextSpan(
                                                    text: '\n'
                                                ),
                                                const TextSpan(
                                                    text: 'From'
                                                ),
                                                const TextSpan(
                                                    text: '\n'
                                                ),
                                                const TextSpan(
                                                    text: ''
                                                ),
                                              ]
                                            ]
                                        ),

                                      ),
                                      trailing: Text.rich(
                                          TextSpan(
                                            children: [
                                              (_isSeen ==false)?const WidgetSpan(
                                                  child:  Icon(
                                                    Icons.circle,
                                                    size: 16,
                                                    color: Colors.green,
                                                  )
                                              ):
                                              const TextSpan(text: ' '),
                                              const TextSpan(
                                                  text: ' '
                                              ),
                                              TextSpan(
                                                text: timeago.format(
                                                    state.notificationResults.rows.notifications[index].time,
                                                    locale: 'en_short'
                                                ),
                                                style: (_isSeen == false)? const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold
                                                ):const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              )
                                            ],

                                          )
                                      ),
                                  ),
                                   ),

                              ],





                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                          height: 10,
                        ),
                  ),

                ] else if (state is ErrorGettingNotification) ...[
                  Container(
                    child: const Center(child: Text("Error Loading")),
                  )
                ] else if (state is LoadingNotification) ...[
                  Container(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height*0.35,
                        left: MediaQuery.of(context).size.width*0.5
                      ),
                      child: const CircularProgressIndicator())
                ] else ...[
                  const Center(
                    child: Text("No Notification"),
                  )
                ]
              ],
            ),

        );
      },
    );
  }

  Icon greenIcon() {
    return const Icon(
      Icons.circle,
      color: Colors.green,
      size: 16,
    );
  }

}


