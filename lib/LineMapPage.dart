import 'dart:async';
import 'dart:typed_data';

import 'package:barikoi_maps_place_picker/barikoi_maps_place_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class LineMap extends StatefulWidget{
  const LineMap({super.key, required this.location});

  final PickResult location;

  @override
  State<LineMap> createState() => _LineMapState();
}

class _LineMapState extends State<LineMap> {

  // CameraPosition initialPosition = CameraPosition(
  //     target: LatLng(widget.location.latitude, widget.location.longitude),
  //     zoom: 12); //CameraPosition object for initial location in map
  MaplibreMapController? mController;
  GlobalKey<State> globalKey = GlobalKey<State>();

  static const styleId = 'osm-liberty'; //barikoi map style id
  static const apiKey = "bkoi_0f0321a7754836ff8a5976497b8904115739f655bb8c723249dc38f431db364c"; //barikoi API key, get it from https://developer.barikoi.com
  static const mapUrl = 'https://map.barikoi.com/styles/$styleId/style.json?key=$apiKey';

  List<LatLng> latLngList = const [
    LatLng(23.795013477597305, 90.40268106366118),
    LatLng(23.794359718360134, 90.40247692274275),
    LatLng(23.794499809902142, 90.4008693130101),
    LatLng(23.78086352516409, 90.3988279038258),
    LatLng(23.780559961361757, 90.40551351897108),
    LatLng(23.780054876213537, 90.40531446877212),
    LatLng(23.778882535095633, 90.4059099101736),
    LatLng(23.778651367991465, 90.40522425039184),
    LatLng(23.77779274372104, 90.40578360442433),
    LatLng(23.77655433334602, 90.40581969178128),
    LatLng(23.77653782112802, 90.40697448720319),
  ];

  int currentPosition = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer.periodic(Duration(seconds: 5), (Timer timer) {
    //   // This function will be called every 5 seconds
    //   // You can perform any UI updates or data fetching here
    //   setState(() {
    //     // Update the counter or any other state variable
    //     currentPosition++;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {

    LatLng latLng = LatLng(widget.location.latitude!.toDouble(), widget.location.longitude!.toDouble());
    CameraPosition initialPosition = CameraPosition(target: latLng, zoom: 14);

    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      // This function will be called every 5 seconds
      // You can perform any UI updates or data fetching here
      // globalKey = GlobalKey();
      setState(() {
        // Update the counter or any other state variable
        currentPosition++;
      });
    });

    return Scaffold(
      body: MaplibreMap(
        key: globalKey,
        initialCameraPosition: initialPosition,
        // set map initial location where map will show first
        onMapCreated: (
            MaplibreMapController mapController) { //called when map object is created
          mController =
              mapController; // use the MaplibreMapController for map operations
        },
        styleString: mapUrl, // barikoi map style url
        onStyleLoadedCallback: (){

          SymbolOptions symbolOptions = SymbolOptions(
            geometry: latLngList[currentPosition], // location of the symbol, required
            iconImage: 'custom-marker',   // icon image of the symbol
            //optional parameter to configure the symbol
            iconSize: .4, // size of the icon in ratio of the actual size, optional
            iconAnchor: 'bottom', // anchor direction of the icon on the location specified,  optional
            textField: 'test',  // Text to show on the symbol, optional
            textSize: 12.5,
            textOffset: const Offset(0, 1.2),   // shifting the text position relative to the symbol with x,y axis value, optional
            textAnchor: 'bottom',   // anchor direction of the text on the location specified, optional
            textColor: '#000000',
            textHaloBlur: 1,
            textHaloColor: '#ffffff',
            textHaloWidth: 0.8,
          );
          addImageFromAsset("custom-marker", "assets/marker.png").then((value) { mController?.addSymbol(symbolOptions);});
          mController?.addLine(
              const LineOptions(
                  geometry: [   //geometry of the line , in List<LatLng>> format
                    LatLng(23.795013477597305, 90.40268106366118),
                    LatLng(23.794359718360134, 90.40247692274275),
                    LatLng(23.794499809902142, 90.4008693130101),
                    LatLng(23.78086352516409, 90.3988279038258),
                    LatLng(23.780559961361757, 90.40551351897108),
                    LatLng(23.780054876213537, 90.40531446877212),
                    LatLng(23.778882535095633, 90.4059099101736),
                    LatLng(23.778651367991465, 90.40522425039184),
                    LatLng(23.77779274372104, 90.40578360442433),
                    LatLng(23.77655433334602, 90.40581969178128),
                    LatLng(23.77653782112802, 90.40697448720319),
                  ],
                  lineColor: "#8800cc",   //color of the line, in hex string
                  lineWidth: 8.0,     //width of the line
                  lineOpacity: 0.5,   // transparency of the line
                  draggable: false     //set whether line is dragabble
              )
          );
          //add line tap listner
          mController?.onLineTapped.add(_OnLineTapped);
        },
      ),
    );
  }

  void _OnLineTapped(Line line) {
    //implement line tap event here
  }
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mController!.addImage(name, list);
  }
}