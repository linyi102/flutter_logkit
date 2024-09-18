import 'package:flutter/material.dart';
import 'package:flutter_logkit/logkit.dart';

class RouterLogObserver extends NavigatorObserver {
  final LogkitLogger logger;
  final logTag = 'RouteObserver';

  RouterLogObserver(this.logger);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    logger.logTyped(RouteLogRecord.fromRoute('push', route, previousRoute));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    logger.logTyped(RouteLogRecord.fromRoute('pop', route, previousRoute));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    logger.logTyped(RouteLogRecord.fromRoute('remove', route, previousRoute));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    logger.logTyped(RouteLogRecord.fromRoute('replace', newRoute, oldRoute));
  }
}
