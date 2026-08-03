import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/firebase_profile_repository.dart';
import '../../domain/models/profile.dart';

final class ProfileProvider extends ChangeNotifier {
  ProfileProvider();

  final FirebaseProfileRepository _repository =
  FirebaseProfileRepository();

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

  Future<void> saveProfile(Profile profile) async {
    setLoading(true);

    try {
      if (_profile == null) {
        await _repository.createProfile(profile);
      } else {
        await _repository.updateProfile(profile);
      }

      _profile = profile;

      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

  Future<void> updatePhoto(Profile profile) async {
    setLoading(true);

    try {
      await _repository.updateProfile(profile);

      _profile = profile;

      notifyListeners();
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadProfile(String uid) async {
    setLoading(true);

    try {
      final profile = await _repository.getProfile(uid);

      _profile = profile;
    } finally {
      setLoading(false);
    }

  }
}

final profileProvider =
ChangeNotifierProvider<ProfileProvider>(
      (ref) => ProfileProvider(),
);
