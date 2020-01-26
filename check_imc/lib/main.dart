import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calcularIMC() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if (imc < 18.5) {
        _infoText = "Abaixo do peso ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.5 && imc < 25) {
        _infoText = "Peso Adequado ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 25 && imc < 30) {
        _infoText = "Acima do Peso ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30 && imc < 35) {
        _infoText = "Obsesidade Grau I ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35 && imc < 40) {
        _infoText = "Obsesidade Grau II ${imc.toStringAsPrecision(4)}";
      } else if (imc > 40) {
        _infoText = "Obsesidade Grave ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Check IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetCampos,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline,
                  size: 120.0, color: Colors.deepPurpleAccent),
              Text(_infoText, textAlign: TextAlign.center,
                style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
                controller: pesoController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "INFORME SEU PESO";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
                controller: alturaController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "INFORME SUA ALTURA";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: _buttonCheck("Check"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buttonCheck(String text) {
    return Container(
      height: 50,
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _calcularIMC();
          }
        },
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}
