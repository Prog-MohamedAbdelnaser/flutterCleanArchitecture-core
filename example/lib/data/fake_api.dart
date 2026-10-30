import 'dart:math';

import 'package:softcore/softcore.dart';

/// A user in the demos.
class User {
  const User(this.id, this.name);

  final int id;
  final String name;

  @override
  bool operator ==(Object other) => other is User && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

/// An error shaped like one from a real API client, to show how an
/// `ErrorMapper` turns it into a message.
class ApiError implements Exception {
  const ApiError(this.statusCode);

  final int statusCode;
}

/// A fake backend with a delay and a switch to make requests fail.
class FakeApi {
  FakeApi._();

  /// One shared instance for the whole example app.
  static final FakeApi instance = FakeApi._();

  /// When true, every request fails.
  bool failRequests = false;

  /// How many requests reached the "server", to show what caching saves.
  int requestCount = 0;

  final List<User> _users = [
    const User(1, 'Amira'),
    const User(2, 'Omar'),
    const User(3, 'Lina'),
  ];
  final Random _random = Random();

  Future<List<User>> getUsers() async {
    await _call();
    return List.unmodifiable(_users);
  }

  Future<User> addUser(String name) async {
    await _call();
    if (name.trim().isEmpty) {
      throw LocalizedException({
        'en': 'Please enter a name.',
        'ar': 'من فضلك أدخل اسماً.',
      });
    }
    final user = User(_users.length + 1 + _random.nextInt(1000), name.trim());
    _users.add(user);
    return user;
  }

  Future<void> deleteUser(User user) async {
    await _call();
    _users.remove(user);
  }

  Future<String> getProfileName() async {
    await _call(const Duration(milliseconds: 600));
    return 'Amira Hassan';
  }

  Future<List<String>> getNotifications() async {
    await _call(const Duration(milliseconds: 1500));
    return ['Your order shipped', 'New message from Omar', 'Weekly summary'];
  }

  Future<void> login(String email, String password) async {
    await _call();
    if (password != 'secret') {
      throw const SoftException('Wrong email or password.', code: 'auth');
    }
  }

  Future<int> getStock() async {
    await _call();
    if (failRequests) throw const ApiError(503);
    return _random.nextInt(3);
  }

  Future<void> _call([Duration delay = const Duration(seconds: 1)]) async {
    requestCount++;
    await Future<void>.delayed(delay);
    if (failRequests) throw const SoftException('Server is unreachable.');
  }
}

/// A clean-architecture use case wrapping the API.
class GetUsers implements UseCase<List<User>, NoParams> {
  GetUsers(this.api);

  final FakeApi api;

  @override
  Future<List<User>> call(NoParams params) => api.getUsers();
}
