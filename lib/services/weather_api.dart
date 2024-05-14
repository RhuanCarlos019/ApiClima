import 'dart:convert';
import 'package:http/http.dart' as http; // Importe o pacote http

import '../models/weather.dart';

class WeatherAPI {
  final String apiKey = '681126f28e7d6fa3a7cfe0da0671e599';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Clima> buscarDadosClima() async {
    final String endpoint = '$baseUrl/weather?q=seu_local&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Clima(
        localizacao: data['name'],
        temperatura: data['main']['temp'],
        condicaoClimatica: data['weather'][0]['main'],
        umidade: data['main']['humidity'],
        velocidadeVento: data['wind']['speed'],
      );
    } else {
      throw Exception('Erro ao carregar dados do clima');
    }
  }
}
