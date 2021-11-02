import 'dart:async';

import 'package:marvel/models/marvel_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apiKey = '9fa5ef841df68cbd0e1005138808e5db';
  String _url = 'api.themoviedb.org';
  String _language = 'es-MX';

  int _popularesPage = 0;

  List<Pelicula> _popupares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  //metodo para cerrar el st5ream

  void disponseStream() {
    _popularesStreamController.close();
  }

  //inserta informacion al stream
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  //escucha informacion del stream
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  //metodo que hace la peticion a get-now-pplaying
  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);

    //decodificamos la respuesta

    final decodedData = json.decode(resp.body);

    //print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  //metodo que hace la peticion a peliculas populares

  Future<List<Pelicula>> getPopulares() async {
    _popularesPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await http.get(url);

    //decodificamos la respuesta

    final decodedData = json.decode(resp.body);

    //print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    final respuesta = peliculas.items;

    _popupares.addAll(respuesta);
    popularesSink(_popupares);
    return respuesta;
  }
}
