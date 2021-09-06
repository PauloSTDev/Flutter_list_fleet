import 'package:flutter/material.dart';
import 'package:list_fleet/model/listPositions.dart';
import 'package:list_fleet/model/position.dart';
import 'package:list_fleet/service/endpoints.dart';
import 'package:list_fleet/widgets/listItem.dart';

class ListVehicles extends StatefulWidget {
  const ListVehicles({Key? key}) : super(key: key);

  @override
  _ListVehiclesState createState() => _ListVehiclesState();

}

class _ListVehiclesState extends State<ListVehicles> {

  ListPositions? listPositions;

  @override
  void initState() {
    super.initState();

    getPositions().then((returnedValue) {
      setState(() {
        listPositions = returnedValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Veículos"),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.pushNamed(
                  context,
                  "/mapa",
                  arguments: listPositions);
            },
          ),
        ],
      ),
      //null safety
      body: listPositions == null ?
      LinearProgressIndicator() : ListView.separated(
          itemBuilder: (context, index) => buildListItem(listPositions!.positions![index]),
          separatorBuilder: (context, index) => Divider(height: 1),
          itemCount: listPositions?.positions?.length ?? 0
        //se o listPostions ou o positions estiver nulo, passa 0 como resposta.. afinal,
        //se eu tentar usar algo nulo eu recebo o famoso nullPointerException
      ),
    );
  }

  Widget buildListItem(Position position){
    return ListItemVehicle(position);
  }

}
