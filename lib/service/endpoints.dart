import 'dart:io';
import 'package:dio/dio.dart';
import 'package:list_fleet/model/listPositions.dart';

Future<ListPositions?> getPositions() async{
  Dio dio = Dio();

  ListPositions? positions;
  try {
    //9 métodos do protocolo http
    //JavaScript - ReactNative
    //await.. estamos chamando uma função assíncrona, com retorno Future, sendo assim, usamos o await-async
    Response response = await dio.get('https://run.mocky.io/v3/b784ae68-e3f8-4306-aa1d-2a33e3acfa35');

    if (response.statusCode == HttpStatus.ok) {
      var jsonResponse = response.data;
      if (jsonResponse["success"]) {
        positions = ListPositions.fromJson(jsonResponse);
      }
    }
  } finally {
    dio.close();
  }

  return positions;
}
