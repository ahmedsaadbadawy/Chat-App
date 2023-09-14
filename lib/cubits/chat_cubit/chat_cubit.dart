import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../constants.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  List<Message> messagesList = [];

  // to get into Collection ana Modify it.
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  void sendMessage({required String message, required String email}) {
    messages.add({
      kMessage: message,
      kCreatrdAt: DateTime.now(),
      'id': email,
    });
  }

  void getMessage() {
    messages.orderBy(kCreatrdAt, descending: true).snapshots().listen((event) {
      // event = snapshot (the data).
      
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
