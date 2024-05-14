

import 'dart:convert';

import '../models/weather.dart';

class WeatherAPI {
  get http => null;

  Future<Clima> buscarDadosClima() async {
    final response = await http.get('seu_endpoint_da_api_do_clima');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Clima(
        localizacao: data['localizacao'],
        temperatura: data['temperatura'],
        condicaoClimatica: data['condicaoClimatica'],
        umidade: data['umidade'],
        velocidadeVento: data['velocidadeVento'],
      );
    } else {
      throw Exception('Erro ao carregar dados do clima');
    }
  }
}
