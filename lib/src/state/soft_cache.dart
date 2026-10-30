/// A small in-memory cache keyed by string.
///
/// Keys are always explicit strings: type names are not stable keys (they
/// collide across generics and are minified on web release builds).
class SoftCache {
  final Map<String, _Entry> _entries = {};

  /// Returns the cached value for [key] if present, of type [R], and not
  /// expired; otherwise `null`.
  R? read<R>(String key) {
    final entry = _entries[key];
    if (entry == null) return null;
    if (entry.isExpired) {
      _entries.remove(key);
      return null;
    }
    final value = entry.value;
    return value is R ? value : null;
  }

  /// Whether a live value is cached for [key].
  bool contains(String key) {
    final entry = _entries[key];
    if (entry == null) return false;
    if (entry.isExpired) {
      _entries.remove(key);
      return false;
    }
    return true;
  }

  /// Stores [value] under [key], optionally expiring after [ttl].
  void write(String key, Object? value, {Duration? ttl}) {
    _entries[key] = _Entry(
      value,
      ttl == null ? null : DateTime.now().add(ttl),
    );
  }

  /// Removes [key].
  void remove(String key) => _entries.remove(key);

  /// Removes everything.
  void clear() => _entries.clear();
}

class _Entry {
  _Entry(this.value, this.expiresAt);

  final Object? value;
  final DateTime? expiresAt;

  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);
}
