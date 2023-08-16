import 'package:discuss_app/domain/models/topic.dart';
import 'package:discuss_app/domain/usecases/topic_source.dart';
import 'package:flutter/foundation.dart';

class CExplore extends ChangeNotifier {
  List<Topic> _topics = [];
  List get topics => _topics;
  setTopics() async {
    _topics = await TopicSource.readExplorer();
    notifyListeners();
  }
}
