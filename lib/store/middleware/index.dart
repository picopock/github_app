import 'package:redux/redux.dart' show Store;
import 'package:redux_logging/redux_logging.dart' show LoggingMiddleware;

import '../app.dart' show AppState;
import './user_info_middleware.dart' show UserInfoMiddleware;
import './login_middleware.dart' show LoginMiddleware;
import '../epic/index.dart' show epicMiddleware;

// 逆序执行
List<dynamic Function(Store<AppState>, dynamic, dynamic Function(dynamic))>
    middlewares = [
  new UserInfoMiddleware(),
  new LoginMiddleware(),
  epicMiddleware,
  new LoggingMiddleware.printer(),
];
