import 'package:flutter/material.dart';
import 'package:exemplo_geoalocator/widgets/weather_card.dart'; // Importe corrigido

import '../models/weather.dart';
import '../services/weather_api.dart'; // Verifique o caminho correto

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  late Future<Clima> _dadosClima;

  @override
  void initState() {
    super.initState();
    _dadosClima = WeatherAPI().buscarDadosClima();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previsão do Tempo'),
      ),
      body: Center(
        child: FutureBuilder<Clima>(
          future: _dadosClima,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return WeatherCard(clima: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar dados');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
