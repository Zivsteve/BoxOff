import 'package:fluro/fluro.dart';
import './route_handlers.dart';

class Routes {
  static void configureRoutes(Router router) {
    router.define('/', handler: homeHandler, transitionType: TransitionType.fadeIn);
    router.define('/movie/:title', handler: movieHandler, transitionType: TransitionType.cupertino);
    router.define('/releases', handler: releasesHandler, transitionType: TransitionType.cupertino);
    router.define('/article/:url', handler: articleHandler, transitionType: TransitionType.cupertino);
    router.define('/person/:id', handler: personHandler, transitionType: TransitionType.inFromBottom);
    router.define('/stat/:type', handler: statHandler, transitionType: TransitionType.cupertino);
  }
}
