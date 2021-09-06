import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:list_fleet/model/position.dart';

class ListItemVehicle extends StatefulWidget {
  final Position position;

  ListItemVehicle(this.position);

  @override
  _ListItemVehicleState createState() => _ListItemVehicleState();
}

class _ListItemVehicleState extends State<ListItemVehicle> {

  TextStyle style15dp = TextStyle(fontSize: 15);
  TextStyle style27dp = TextStyle(fontSize: 27);
  Placemark? placemark;

  //onde o ciclo de vida do State começa
  @override
  void initState() {
    super.initState();
    getAddress();
  }

  getAddress() async {
    List<Placemark> listPlacemarks = await placemarkFromCoordinates(
        widget.position.lat,
        widget.position.lng);

    setState(() {
      placemark = listPlacemarks[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: buildChildSlidable(),
      actions: <Widget>[],//esquerda direita
      secondaryActions: <Widget>[//direita esquerda
        IconSlideAction(
            caption: 'Comandos',
            color: Colors.lightBlue,
            foregroundColor: Colors.white,
            icon: Icons.archive,
            onTap: showCommandOptions
        ),
      ],
    );
  }

  void showCommandOptions(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Center(
              child: ListView(
                children: [
                  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.add_a_photo_outlined),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Tirar foto do condutor"),
                        )
                      ]
                  ),
                  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.add_alarm_rounded),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Disparar alarme"),
                        )
                      ]
                  ),
                ],
              )
          ),
        );
      },
    );
  }

  Widget buildChildSlidable() => InkWell(
    child: Padding(
      padding: EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(//'espicha' seu filho para preencher toda a area restante da parte a esquerda da seta
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    widget.position.veiculo_placa.trim(),
                    style: style27dp
                ),
                Text(
                    widget.position.condutor_nome,
                    style: style15dp
                ),
                Text(
                    placemark == null ? "Buscando endereço..." : getFormattedAddress(),
                    style: style15dp
                ),
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_right)
        ],
      ),
    ),
    onTap: (){
      Navigator.pushNamed(context, "/mapa", arguments: widget.position);
    },
  );

  String getFormattedAddress(){
    return "${placemark?.subAdministrativeArea}, ${placemark?.administrativeArea}";
  }

}

