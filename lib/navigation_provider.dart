import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentTab = 0;
  bool _showRegistration = false;
  bool _showLogin = false;
  bool _showContactUsUnderSupport = false;

  // Registered user data mock
  String? _userName;
  String? _userEmail;
  String? _userQualification;
  bool _isRegistered = false;

  int get currentTab => _currentTab;
  bool get showRegistration => _showRegistration;
  bool get showLogin => _showLogin;
  bool get showContactUsUnderSupport => _showContactUsUnderSupport;

  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userQualification => _userQualification;
  bool get isRegistered => _isRegistered;

  void setTab(int index) {
    _currentTab = index;
    _showRegistration = false;
    _showLogin = false;
    if (index != 3) {
      _showContactUsUnderSupport = false;
    }
    notifyListeners();
  }

  void openRegistration() {
    _showRegistration = true;
    _showLogin = false;
    notifyListeners();
  }

  void closeRegistration() {
    _showRegistration = false;
    notifyListeners();
  }

  void openLogin() {
    _showLogin = true;
    _showRegistration = false;
    notifyListeners();
  }

  void closeLogin() {
    _showLogin = false;
    notifyListeners();
  }

  void navigateToContactUs() {
    _currentTab = 3; // Support tab
    _showContactUsUnderSupport = true;
    _showRegistration = false;
    _showLogin = false;
    notifyListeners();
  }

  void navigateToFAQ() {
    _currentTab = 3; // Support tab
    _showContactUsUnderSupport = false;
    _showRegistration = false;
    _showLogin = false;
    notifyListeners();
  }

  void registerUser({
    required String name,
    required String email,
    required String qualification,
  }) {
    _userName = name;
    _userEmail = email;
    _userQualification = qualification;
    _isRegistered = true;
    _showRegistration = false;
    notifyListeners();
  }

  void logout() {
    _userName = null;
    _userEmail = null;
    _userQualification = null;
    _isRegistered = false;
    notifyListeners();
  }
}
