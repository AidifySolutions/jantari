import 'package:jantari/utils/static_data.dart';
import 'package:jantari/utils/constants.dart';
import 'package:jantari/models/product.dart';
import 'package:intl/intl.dart';

class Helper{
  static String getSdkResponseMessage( String response){

    if(response == getEnumValue(sdkResponse.SUCCESS_WSQ_EXPORT.toString()) || response == '114'){
      return "Successfully exported WSQ";

    }else if(response == getEnumValue(sdkResponse.CANCELLATION.toString())  || response == '115'){
      return "You have cancelled the biometric verification";

    }else if(response == getEnumValue(sdkResponse.SCANNING_FAILURE.toString()) ||
        response == getEnumValue(sdkResponse.SCANNING_ERROR.toString())  ||
        response == '116'){
      return "Failed to scan fingerprints. Please try again";

    }else if(response == getEnumValue(sdkResponse.LICENSE_FAILED.toString())  || response == '119'){
      return "Faceoff is not licensed, Please contact Khushhali";

    }else if(response == getEnumValue(sdkResponse.INITIALIZATION_EXCEPTION.toString())  || response == '128'){
      return "Scanner SDK could not initialize, Please contact Khushhali";

    }else if(response == getEnumValue(sdkResponse.NO_CAMERA.toString())){
      return "This device has no camera";

    }else if(response == getEnumValue(sdkResponse.NO_AUTO_FOCUS.toString())){
      return "This device has no auto-focus";

    }else if(response == getEnumValue(sdkResponse.NO_FLASH_LIGHT.toString())){
      return "This device has no flash light";

    }else if(response == getEnumValue(sdkResponse.CAMERA_PERMISSION_REQUIRED.toString())){
      return "Camera permission required";

    }else{
      return "";
    }
  }

  static String getEnumValue(String enumValue) {
    return enumValue.split('.').last;
  }

  static swap(List<dynamic> list, int i) {
    var temp = list[i];
    list[i] = list[i+1];
    list[i+1] = temp;
  }

  static bubbleSort(List<Fields> list, String parameter) {
    if (list.isEmpty) return;

    int n = list.length;
    int i, step;
    for (step = 0; step < n; step++) {
      for ( i = 0; i < n - step - 1; i++) {
        if (list[i].priority! > list[i + 1].priority!) {
          swap(list, i);
        }
      }
    }

    return list;
  }

  static nullEmptyCheck(input) {
    return input == null || input == "";
  }

  static String dateTimeFormat(String? date) {
    try {
      var parseDate = DateTime.parse(date ?? '');
      // var formattedTime = parseDate();
      var formattedDateTime =
      DateFormat('dd MMM yyyy,').add_jm().format(parseDate);
      return formattedDateTime;
    } on Exception catch (e) {
      print(e);
      return '';
    }
  }

  static convertArrayToChunksArray(items, int chunkSize) {
    var chunks = [];
    for (var i = 0; i < items.length; i += chunkSize) {
      chunks.add(items.sublist(i, i+chunkSize > items.length ? items.length : i + chunkSize));
    }
    return chunks;
  }

  static getDictionaryForHeader({required List<dynamic> groups}) {
    var dictionary = <String, List<String>>{};
    for (var group in groups) {
      (group.modulePermissions ?? []).forEach((item) {
        if (dictionary[item.moduleCode]?.isNotEmpty ?? false) {
          var dictionaryExistingPermissions = [...dictionary[item.moduleCode]!];
          var currentGroupPermissions = [...item.permissions];
          dictionary[item.moduleCode] = [
            ...<String>{...dictionaryExistingPermissions, ...currentGroupPermissions}
          ];
        } else {
          dictionary[item.moduleCode] = [...item.permissions];
        }
      });
    }
    return dictionary;
  }

  static minutesToReadableTime(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    String hoursString = hours > 0 ? '$hours hours ' : '';
    String minutesString = remainingMinutes > 0 ? '$remainingMinutes minutes' : '';
    return hoursString + minutesString;
  }
}
