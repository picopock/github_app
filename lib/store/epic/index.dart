import './redux_epics/redux_epics.dart'
    show EpicMiddleware, combineEpics /* , TypedEpic */;

import '../app.dart' show AppState;
import './login_epic.dart' show LoginEpic;
import './user_epic.dart' show UserEpic;
// import '../login.dart' show LoginAction;

// 顺序执行
final rootEpic = combineEpics<AppState>([
  // TypedEpic<AppState, LoginAction>(
  //   new LoginEpic(),
  // ), // 指定要处理的 event type, 无需在内部指定
  new LoginEpic(),
  new UserEpic(), // 在内部判断要处理的 event type
]);

EpicMiddleware<AppState> epicMiddleware =
    new EpicMiddleware<AppState>(rootEpic);
