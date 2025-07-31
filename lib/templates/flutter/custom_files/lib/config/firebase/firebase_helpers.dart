import 'dart:convert';
import '../../utilities/global.dart';

String extractDataSubstring(String jsonString) {
  int dataIndex = jsonString.indexOf('{data:') + '{data:'.length;
  int actionIndex = jsonString.indexOf(', action:');
  return jsonString.substring(dataIndex, actionIndex);
}

String extractActionSubstring(String jsonString) {
  int actionStartIndex = jsonString.indexOf('action:') + 'action:'.length;
  return jsonString.substring(actionStartIndex).replaceAll('}', '').trim();
}

Map<String, dynamic> convertPayload(String payload) {
  try {
    String dataSubstring = extractDataSubstring(payload);
    String actionSubstring = extractActionSubstring(payload);

    Map<String, dynamic> data = json.decode(dataSubstring);

    return {'data': data, 'action': actionSubstring};
  } catch (e) {
    printOnDebug(['Error: $e']);
    rethrow;
  }
}
