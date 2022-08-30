import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/core/constants.dart';
import 'package:cncm_flutter_new/data/services/notification_service.dart';
import 'package:cncm_flutter_new/presentation/homepage/blocs/unreadcount_bloc/bloc/unreadcount_bloc.dart';
import 'package:cncm_flutter_new/presentation/notification_bloc/bloc/unread_state.dart';
import 'package:cncm_flutter_new/service_locator.dart';
import 'package:equatable/equatable.dart';


import '../../../data/repositories/notification_repository.dart';
import '../../homepage/blocs/markallread_bloc/bloc/markallread_bloc.dart';
import 'notification_state.dart';

part 'notification_event.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {

  NotificationRepository notificationRepository;

  NotificationBloc(this.notificationRepository,) : super(NotificationInitial()) {
    on<NotificationEvent>((event, emit) async{
      if(event is LoadNotification){
        emit(LoadingNotification());
        var notificationMessage = await notificationRepository.getNotification();
        notificationMessage.fold(
          (error) => ErrorGettingNotification(errorNotificationResponse: error),
           (notificationResponse) async{
             emit(LoadedNotification(notificationResults: notificationResponse.results));
             sl<MarkallreadBloc>().add(MarkAllReadEvent());
             sl<UnreadcountBloc>().add(LoadUnreadNotificationEvent());
           });
      }
      
      
      
    });
  }
}
