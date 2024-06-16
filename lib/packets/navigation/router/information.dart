part of '../router.dart';

class MyRouterInformationParser
    extends RouteInformationParser<MyNavigationState> {
  @override
  Future<MyNavigationState> parseRouteInformation(
      RouteInformation routeInformation) async {
    final url = routeInformation.uri;
    final isAuth = MyRouterDelegate.instance.param['isAuth'];
    if (isAuth == false) return MyNavigationState.auth();
    if (url.pathSegments.isEmpty) {
      return MyNavigationState.auth();
    }

    switch (url.pathSegments[0]) {
      case 'home':
        return MyNavigationState.home();
      default:
        return MyNavigationState.auth();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(MyNavigationState configuration) {
    if (configuration.auth) {
      return RouteInformation(
        uri: Uri.parse('/auth'),
      );
    }
    if (configuration.home) {
      return RouteInformation(
        uri: Uri.parse('/home'),
      );
    }
    return RouteInformation(uri: Uri.parse('/auth'));
  }
}
