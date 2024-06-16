part of '../router.dart';

class MyRouterInformationParser
    extends RouteInformationParser<MyNavigationState> {
  @override
  Future<MyNavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final url = routeInformation.uri;
    final privacy = MyRouterDelegate.instance.param['privacy'];
    if (privacy == false) return MyNavigationState.privacy();
    if (url.pathSegments.isEmpty) {
      return MyNavigationState.privacy();
    }

    switch (url.pathSegments[0]) {
      case 'locations':
        return MyNavigationState.locations();
      default:
        return MyNavigationState.privacy();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(MyNavigationState configuration) {
    if (configuration.privacy) {
      return RouteInformation(
        uri: Uri.parse('/privacy'),
      );
    }
    if (configuration.locations) {
      return RouteInformation(
        uri: Uri.parse('/locations'),
      );
    }
    if (configuration.home) {
      return RouteInformation(
        uri: Uri.parse('/main'),
      );
    }

    return RouteInformation(uri: Uri.parse('/main'));
  }
}
