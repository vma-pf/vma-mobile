import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:vma/core/events/event_base.dart';

class EventManager {
  static final _eventBus = EventBus();
  static final List<StreamSubscription<EventBase>> subscriptions = [];

  static void fire(EventBase event) {
    _eventBus.fire(event);
  }

  static void register<TEvent extends EventBase>(Function(TEvent) handler) {
    StreamSubscription<TEvent> subscription =
        _eventBus.on<TEvent>().listen(handler);

    subscriptions.add(subscription);
  }

  static void unregister(Type eventType) {
    subscriptions.removeWhere((subscription) {
      final eventStreamType = subscription.runtimeType.toString();
      if (eventStreamType == eventType.toString()) {
        subscription.cancel();
        return true;
      }
      return false;
    });
  }

  static void destroy() {
    _eventBus.destroy();
  }
}
