import 'package:barikoi_maps_place_picker/barikoi_maps_place_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class SymbolMap extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SymbolMapState();

}

class _SymbolMapState extends State<SymbolMap>{
  CameraPosition initialPosition= const CameraPosition(target: LatLng(23.835677, 90.380325), zoom: 12);
  MaplibreMapController? mController;

  static const styleId = 'osm-liberty' ;    //barikoi map style id
  static const apiKey="bkoi_0f0321a7754836ff8a5976497b8904115739f655bb8c723249dc38f431db364c";   //barikoi API key, get it from https://developer.barikoi.com
  static const mapUrl= 'https://map.barikoi.com/styles/$styleId/style.json?key=$apiKey';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaplibreMap(
      initialCameraPosition: initialPosition,
      styleString: mapUrl,
      onMapCreated: (MaplibreMapController mapController){  //called when map object is created
        mController= mapController; // use the MaplibreMapController for map operations

        mController?.onSymbolTapped.add(_OnSymboltapped);   // add symbol tap event listener to mapcontroller

      },
      onStyleLoadedCallback: (){
        // Create SymbolOption for creating a symbol in map
        SymbolOptions symbolOptions= const SymbolOptions(
          geometry: LatLng(23.835677, 90.380325), // location of the symbol, required
          iconImage: 'custom-marker',   // icon image of the symbol
          //optional parameter to configure the symbol
          iconSize: .3, // size of the icon in ratio of the actual size, optional
          iconAnchor: 'bottom', // anchor direction of the icon on the location specified,  optional
          textField: 'test',  // Text to show on the symbol, optional
          textSize: 12.5,
          textOffset: Offset(0, 1.2),   // shifting the text position relative to the symbol with x,y axis value, optional
          textAnchor: 'bottom',   // anchor direction of the text on the location specified, optional
          textColor: '#000000',
          textHaloBlur: 1,
          textHaloColor: '#ffffff',
          textHaloWidth: 0.8,
        );
        addImageFromAsset("custom-marker", "assets/marker.png").then((value) { mController?.addSymbol(symbolOptions);});
      },
    );
  }


  _OnSymboltapped(Symbol symbol){
    //update symbol text when tapped
    mController?.updateSymbol(symbol, SymbolOptions(textField: "clicked"));
  }

  // Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mController!.addImage(name, list);
  }

  // Adds a network image to the currently displayed style

}