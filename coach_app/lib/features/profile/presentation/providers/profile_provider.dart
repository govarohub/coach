/*
|--------------------------------------------------------------------------
| Coach
|--------------------------------------------------------------------------
| Archivo: profile_provider.dart
|--------------------------------------------------------------------------
| Administra el estado del perfil del usuario.
|--------------------------------------------------------------------------
*/

import 'package:flutter/foundation.dart';

import '../../domain/models/profile.dart';

final class ProfileProvider extends ChangeNotifier {
  ProfileProvider();

  Profile? _profile;

  bool _isLoading = false;

  Profile? get profile => _profile;

  bool get isLoading => _isLoading;

  void setProfile(Profile profile) {
    _profile = profile;
    notifyListeners();
  }

  void clearProfile() {
    _profile = null;
    notifyListeners();
  }

  void setLoading(bool value) {
    if (_isLoading == value) {
      return;
    }

    _isLoading = value;
    notifyListeners();
  }
}
