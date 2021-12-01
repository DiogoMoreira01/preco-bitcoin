// @dart=2.9
import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerBitcoin = TextEditingController();
  String _resultado = "0";

  void _recuperaBitcoin() async {
    String _bitcoin = _controllerBitcoin.text;
    String url = "https://blockchain.info/ticker";

    http.Response response;

    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);

    print("resultado: " + retorno["BRL"]["buy"].toString());

    setState(() {
      _resultado = retorno["BRL"]["buy"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("imagens/bitcoin.png"),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "R\$: ${_resultado}",
                  style: const TextStyle(fontSize: 35),
                ),
              ),
              ElevatedButton(
                onPressed: _recuperaBitcoin,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Text(
                    "Atualizar",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
