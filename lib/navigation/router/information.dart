import 'dart:developer';

import 'package:flutter/material.dart';
import '../navigation_state.dart';

class MyRouterInformationParser
    extends RouteInformationParser<MyNavigationState> {
  @override
  Future<MyNavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final url = routeInformation.uri;
    log('base url: $url');
    if (url.pathSegments.length == 1) {
      log('1');
      return MyNavigationState.home();
    }
    if (url.pathSegments.isEmpty) {
      log('empty');
      return MyNavigationState.home();
    }
    if (url.pathSegments.length == 2) {
      final page = url.pathSegments[1];
      log('2, page: $page');
      return page == 'chat'
          ? MyNavigationState.chat()
          : MyNavigationState.auth();
    }
    log('unknown');
    return MyNavigationState.home();
  }

  @override
  RouteInformation? restoreRouteInformation(MyNavigationState configuration) {
    log('parser');
    if (configuration.chat) {
      return RouteInformation(
        uri: Uri.parse('/home/chat'),
      );
    }
    if (configuration.auth) {
      return RouteInformation(
        uri: Uri.parse('/home/auth'),
      );
    }
    return RouteInformation(uri: Uri.parse('/home'));
  }
}
