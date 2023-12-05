import 'package:flutter/material.dart';

import '../models/user/learn_topic.dart';
import '../models/user/test_preparation.dart';
import '../models/user/token.dart';
import '../models/user/user.dart';

class AuthProvider extends ChangeNotifier {
  late User currentUser;
  Token? token;
  List<LearnTopic> learnTopics = [];
  List<TestPreparation> testPreparations = [];

  void setLearnTopic(List<LearnTopic> learnTopics) {
    this.learnTopics = learnTopics;
    notifyListeners();
  }

  void setTestPreparation(List<TestPreparation> testPreparations) {
    this.testPreparations = testPreparations;
    notifyListeners();
  }

  void setUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  void logIn(User user, Token token) {
    currentUser = user;
    this.token = token;
    notifyListeners();
  }

  void logOut() {
    token = null;
    notifyListeners();
  }
}