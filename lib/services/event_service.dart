import './address.dart' show Address;
import './http/http.dart' show http;
import '../model/event.dart' show Event;
import './data_result.dart' show DataResult;

class EventService {
  static getEventReceived(String? username, int pageIndex, int pageSize) async {
    if (username == null) {
      return null;
    }
    String url = Address.getEventReceived(username) +
        Address.getPageParams('?', pageIndex, pageSize);
    var res = await http.request(url);
    if (res.result) {
      List<Event> list = [];
      var data = res.data;
      if (data == null || data.length == 0) {
        return null;
      }
      for (int i = 0; i < data.length; i++) {
        list.add(Event.fromJson(data[i]));
      }
      return new DataResult(list, true);
    } else {
      return new DataResult(null, false);
    }
  }

  static getEvent(username, {page = 0}) async {
    String url = Address.getEvent(username) + Address.getPageParams('?', page);
    var res = await http.request(url);
    if (res.result) {
      List<Event> list = [];
      var data = res.data;
      if (data == null && data.length == 0) {
        return new DataResult(list, true);
      }
      for (int i = 0; i < data.length; i++) {
        list.add(Event.fromJson(data[i]));
      }
      return new DataResult(list, true);
    } else {
      return null;
    }
  }
}
