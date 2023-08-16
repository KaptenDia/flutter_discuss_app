import 'package:discuss_app/domain/models/topic.dart';
import 'package:discuss_app/domain/usecases/topic_source.dart';
import 'package:flutter/foundation.dart';

class CFeed extends ChangeNotifier {
  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  setTopics(String idUser) async {
    _topics = await TopicSource.readFeed(idUser);
    notifyListeners();
  }
}
