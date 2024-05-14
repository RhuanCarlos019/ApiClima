import 'package:flutter/material.dart';

import '../models/weather.dart';


class CartaoClima extends StatelessWidget {
  final Clima clima;

  CartaoClima({required this.clima});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              clima.localizacao,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 10),
            Text(
              '${clima.temperatura.toString()}°C',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10),
            Text(
              clima.condicaoClimatica,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10),
            Text(
              'Umidade: ${clima.umidade}%',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 10),
            Text(
              'Velocidade do Vento: ${clima.velocidadeVento} m/s',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
