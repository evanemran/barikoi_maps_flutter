import 'package:barikoi_maps_flutter/LineMapPage.dart';
import 'package:barikoi_maps_flutter/MapPage.dart';
import 'package:barikoi_maps_place_picker/barikoi_maps_place_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MapMarker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController locationController = TextEditingController();
  String selectedLocation = "location here...";
  PickResult? pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BariKoi Maps"), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(16), child: Text(selectedLocation),),
            const SizedBox(height: 16,),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MapPage(onLocationPicked: (PickResult location) { onLocationPicked(location); },)));
            }, child: const Text("Pick Location")),
            const SizedBox(height: 16,),
            ElevatedButton(onPressed: () {
              openLineMap();
            }, child: const Text("Get Direction"))
          ],
        ),
      ),
    );
  }

  onLocationPicked(PickResult location) {
    setState(() {
      pickedLocation = location;
      selectedLocation = "Address: ${location.formattedAddress} \nLat: ${location.latitude} \nLong: ${location.longitude} \nCity: ${location.city}";
    });
  }

  void openLineMap() {
    if(pickedLocation != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LineMap(location: pickedLocation!,)/*SymbolMap()*/));
    }
    else {
      /// select a location
    }
  }
}
