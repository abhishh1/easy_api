abstract class EasyModelWrapper {

 /* Extend your repository class with `EasyModelWrapper` and see the easy magic🚀

The `EasyModelWrapper` provides 3 functions which can be used to parse (encode/decode) data from data models.

Note : At this version release, The data model must have prime paramter of `status` and `data` as the output. 
 Else you will have to cast the property names.

*/
  decoder({required dynamic response}) {
    final Map<String, dynamic>? parsedData = response;
    if (parsedData != null) {
      return parsedData;
    } else {
      return null;
    }
  }

  modelDecoder(
      {required dynamic jsonFormat,
      required dynamic typeClass,
      required dynamic response,
      required String successKeyword}) {
    dynamic _typeClass = jsonFormat(response);
    bool status = _typeClass.status;
    if (status) {
      return _typeClass;
    } else {
      return null;
    }
  }

  nestedModelDecoder(
      {required dynamic jsonFormat,
      required dynamic parentTypeClass,
      required dynamic childTypeClass,
      required dynamic response}) {
    dynamic modelledTypeClass = jsonFormat(response);
    bool status = modelledTypeClass.status;
    if (status) {
      final dynamic data = modelledTypeClass.data;
      return data;
    } else {
      return null;
    }
  }
}
