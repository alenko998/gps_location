import 'package:dio/dio.dart';

import '../model/coordinatesModel.dart';

Dio dio = Dio();

sendLocation(int id, double? latitude, double? longitude) async {
  try {
    var res = await dio.post('http://192.168.1.2:4000/api/locations/',
        data: {"id": id, "latitude": latitude, "longitude": longitude});
    print(res);
  } on DioError catch (e) {
    throw Exception(e);
  }
}

Future<Coordinate> getCoordinate() async {
  try {
    var res = await dio.get('http://10.0.2.2:4000/api/locations/');
    Coordinate coordinate = Coordinate(
        id: res.data["id"],
        latitude: res.data["latitude"],
        longitude: res.data["longitude"]);
    return coordinate;
  } catch (e) {
    throw Exception(e);
  }
}
