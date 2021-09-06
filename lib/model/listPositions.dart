import 'package:list_fleet/model/position.dart';

class ListPositions {

  List<Position>? positions;

  ListPositions({
    this.positions
  });

  ListPositions.fromJson(Map<String, dynamic> json) //operador ternário
      : positions = json['data'] == null ? null : buildListPositions(json['data']);

  static List<Position> buildListPositions(List<dynamic> list) =>
      //map = de -> para
  //map = de um tipo dinamico para uma instância de position
  list.map(
          (item) =>
          Position.fromJson(item)
  ).toList();

}
