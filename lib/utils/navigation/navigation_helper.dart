import 'package:flutter/cupertino.dart';

abstract class NavigationHelper {
  Future<dynamic>? pushNamed(
    String routeName, {
    dynamic arguments,
  });

  Future<dynamic>? pushReplacementNamed(
    String routeName, {
    dynamic arguments,
  });

  Future<dynamic>? pushNamedAndRemoveUntil(
    String routeName, {
    dynamic arguments,
  });

  void pop<T extends Object?>([T? result]);
}

class NavigationHelperImpl implements NavigationHelper {
  static final navigationKey = GlobalKey<NavigatorState>();

  @override
  void pop<T extends Object?>([T? result]) {
    navigationKey.currentState!.pop(result);
  }

  @override
  Future? pushNamed(String routeName, {arguments}){
    return navigationKey.currentState!
        .popAndPushNamed(routeName, arguments: arguments);
  }

  @override
  Future? pushNamedAndRemoveUntil(String routeName, {arguments}) {
    return navigationKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  @override
  Future? pushReplacementNamed(String routeName, {arguments}){
    return navigationKey.currentState?.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }
}
