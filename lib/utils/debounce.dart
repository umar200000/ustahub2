import 'dart:async';
import 'dart:ui';

// Global debounce for backward compatibility
Timer? _debounce;

void onDebounce(VoidCallback func, [Duration duration = const Duration(milliseconds: 400)]) {
  if (_debounce?.isActive ?? false) _debounce?.cancel();
  _debounce = Timer(duration, func);
}

// Optimized debounce class for multiple independent instances
class Debouncer {
  Timer? _timer;

  void call(VoidCallback func, [Duration duration = const Duration(milliseconds: 400)]) {
    _timer?.cancel();
    _timer = Timer(duration, func);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  bool get isActive => _timer?.isActive ?? false;

  void dispose() {
    cancel();
  }
}

// Specialized debouncer for inform operations
class InformDebouncer {
  static final Map<String, Timer> _timers = {};

  static void call(String key, VoidCallback func, [Duration duration = const Duration(milliseconds: 600)]) {
    _timers[key]?.cancel();
    _timers[key] = Timer(duration, () {
      func();
      _timers.remove(key);
    });
  }

  static void cancel(String key) {
    _timers[key]?.cancel();
    _timers.remove(key);
  }

  static void cancelAll() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }
}

// Specialized debouncer for product operations
class ProductDebouncer {
  static final Map<String, Timer> _timers = {};

  static void call(String key, VoidCallback func, [Duration duration = const Duration(milliseconds: 800)]) {
    _timers[key]?.cancel();
    _timers[key] = Timer(duration, () {
      func();
      _timers.remove(key);
    });
  }

  static void cancel(String key) {
    _timers[key]?.cancel();
    _timers.remove(key);
  }

  static void cancelAll() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }

  static bool isActive(String key) {
    return _timers[key]?.isActive ?? false;
  }
}
