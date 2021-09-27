import 'package:baqal/src/routes/routes_constants.dart';
import 'package:flutter/cupertino.dart';

class RouterUtils {
  List<String> _roots = [Routes.splashScreen];

  pushNamedRoot(BuildContext context, String routeName, {dynamic arguments}) {
    _roots.add(routeName);
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  pushNamedAndRemoveUntil(BuildContext context, String routeName,
      {dynamic arguments}) {
    if (_roots.length > 1) _roots.removeRange(1, _roots.length - 1);
    return Navigator.pushNamedAndRemoveUntil(context, routeName, (_) => false,
        arguments: arguments);
  }

  popUntil(BuildContext context) {
    if (_roots.length > 1) _roots.removeRange(1, _roots.length - 1);
    return Navigator.of(context).popUntil((route) => route.isFirst);
  }

  pushReplacement(BuildContext context, String routeName,
      {dynamic arguments}){
    if(_roots.isNotEmpty)
      _roots[_roots.length - 1] = routeName;
    else
      _roots.add(routeName);
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  pop(BuildContext context , [dynamic result]) {
    _roots.removeLast();
    return Navigator.of(context).pop(result);
  }

  popAndPushNamed(BuildContext context, String routeName, {dynamic arguments}) {
    _roots.removeLast();
    _roots.add(routeName);
  return  Navigator.popAndPushNamed(context, routeName, arguments: arguments);
  }

  get previousRoot {
    if (_roots.length > 1)
      return _roots[_roots.length - 2];
    else
      return null;
  }

  get roots => _roots;
}
