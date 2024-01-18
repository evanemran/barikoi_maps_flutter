import 'package:barikoi_maps_place_picker/barikoi_maps_place_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  CameraPosition initialPosition= const CameraPosition(target: LatLng(23.835677, 90.380325), zoom: 12);   //CameraPosition object for initial location in map
  MaplibreMapController? mController;

  static const styleId = 'osm-liberty' ;    //barikoi map style id
  static const apiKey = "bkoi_0f0321a7754836ff8a5976497b8904115739f655bb8c723249dc38f431db364c";   //barikoi API key, get it from https://developer.barikoi.com
  static const mapUrl= 'https://map.barikoi.com/styles/$styleId/style.json?key=$apiKey';

  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey:
          apiKey,
      //Barikoi API key
      initialPosition: const LatLng(23.835677, 90.380325),
      //initial location position to start the map with
      onMapCreated: (MaplibreMapController mapController) {
        //called when map object is created
        mController =
            mapController; // use the MaplibreMapController for map operations
      },
      useCurrentLocation: true,
      // option to use the current location for picking a place, true by default
      selectInitialPosition: true,
      //option to load the initial position to start the map with
      usePinPointingSearch: true,
      //option to use reversegeo api to get place from location point, default value is true
      getAdditionalPlaceData: const [
        PlaceDetails.area_components,
        PlaceDetails.addr_components,
        PlaceDetails.district
      ],
      //option to retrive addtional place data, will count extra api calls
      onPlacePicked: (result) {
        //returns the place object selected in the place picker
        print(result);
      },
    );
  }
}
