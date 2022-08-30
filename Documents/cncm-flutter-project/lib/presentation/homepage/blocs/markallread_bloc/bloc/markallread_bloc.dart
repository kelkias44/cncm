import 'package:bloc/bloc.dart';
import 'package:cncm_flutter_new/data/models/news_feed.dart';
import 'package:cncm_flutter_new/data/repositories/notification_repository.dart';
import 'package:meta/meta.dart';

part 'markallread_event.dart';
part 'markallread_state.dart';

class MarkallreadBloc extends Bloc<MarkallreadEvent, MarkallreadState> {
  NotificationRepository notificationRepository;
  MarkallreadBloc(this.notificationRepository) : super(MarkallreadInitial()) {
    on<MarkallreadEvent>((event, emit) async {
      var markReadReesponse = await notificationRepository.getMarkRead();
      markReadReesponse.fold(
        (error) => ErrorGettingMarkallreadState(), 
        (markreadResponse) => LoadedMarkallreadState()
      );
    });
  }
}
