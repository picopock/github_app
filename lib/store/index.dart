import 'package:redux/redux.dart' show Store;

import './app.dart' show AppState, appReducer, initialState;
import './middleware/index.dart' show middlewares;

Store<AppState> createStore() {
  return new Store<AppState>(
    appReducer,
    initialState: initialState,
    middleware: middlewares,
  );
}
