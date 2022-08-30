import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/repositories/notification_repository.dart';
import 'package:meta/meta.dart';

import '../../../../../data/models/UnreadNotificationResponse.dart';

part 'unreadcount_event.dart';
part 'unreadcount_state.dart';

class UnreadcountBloc extends Bloc<UnreadcountEvent, UnreadcountState> {
  NotificationRepository notificationRepository;
  UnreadcountBloc(this.notificationRepository) : super(UnreadcountInitial()) {
    on<UnreadcountEvent>((event, emit) async{
  
    if(event is LoadUnreadNotificationEvent){
       emit(LoadingUnreadNotification());
        var unreadNotificationmessage = await notificationRepository.getUnread();
        unreadNotificationmessage.fold(
          (error) => ErrorGettingUnreadNotification(),
           (notificationResponse) async{
             emit(LoadedUnreadNotification(notificationResults: notificationResponse.results));
           }); 
      }

    });
  }
}
