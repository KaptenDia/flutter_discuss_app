import 'package:discuss_app/domain/models/topic.dart';
import 'package:discuss_app/domain/usecases/topic_source.dart';
import 'package:discuss_app/domain/usecases/user_source.dart';
import 'package:flutter/foundation.dart';

import '../domain/models/user.dart';

class CSearch extends ChangeNotifier {
  List<String> get filters => ['Topic', 'User'];

  String _filter = 'Topic';
  String get filter => _filter;
  set filter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  search(String query) {
    if (filter == 'Topic') {
      setTopics(query);
    } else {
      setUsers(query);
    }
  }

  List<Topic> _topics = [];
  List<Topic> get topics => _topics;
  setTopics(String query) async {
    _topics = await TopicSource.search(query);
    notifyListeners();
  }

  List<User> _users = [];
  List<User> get user => _users;
  setUsers(String query) async {
    _users = await UserSource.search(query);
    notifyListeners();
  }
}
