import 'package:flutter/material.dart';
import 'package:exemplo_geoalocator/services/weather_api.dart';

import '../models/weather.dart';

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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar dados');
            } else {
              final clima = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Localização: ${clima.localizacao}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Temperatura: ${clima.temperatura}°C',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Condição Climática: ${clima.condicaoClimatica}',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Umidade: ${clima.umidade}%',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'Velocidade do Vento: ${clima.velocidadeVento} m/s',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
