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

  void _resetCampos(){
    pesoController.text= "";
    alturaController.text= "";
    setState(() {
      _infoText = "Informe seus dados";
    });
  }

  void _calcularIMC(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      print(imc);
      if(imc < 18.6){
        _infoText = "Abaixo do peso ${imc.toStringAsPrecision(3)}";
      } else if(imc >= 18.6 && imc < 24.9 ){
        _infoText = "Peso Ideal ${imc.toStringAsPrecision(3)}";
      } else if(imc >= 24.9 && imc < 29.9 ){
        _infoText = "Levemente Acima do Peso ${imc.toStringAsPrecision(3)}";
      } else if(imc >= 29.9 && imc < 34.9 ){
        _infoText = "Obsesidade Grau 1 ${imc.toStringAsPrecision(3)}";
      } else if(imc >= 34.9 && imc < 39.9 ){
        _infoText = "Obsesidade Grau 2 ${imc.toStringAsPrecision(3)}";
      } else if(imc > 40 ){
        _infoText = "Obsesidade Grau 3 ${imc.toStringAsPrecision(3)}";
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
          IconButton(icon: Icon(Icons.refresh),
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
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
              controller: pesoController,
              validator: (value) {
                if(value.isEmpty){
                  return "INFORME SEU PESO";
                }
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.deepPurpleAccent)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
              controller: alturaController,
              validator: (value){
                if(value.isEmpty){
                  return "INFORME SUA ALTURA";
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: _buttonCheck("Check"),
            ),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25),
            )
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
        onPressed: (){
          if(_formKey.currentState.validate()){
           _calcularIMC();
          }
        },
        child: Text(text,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        color: Colors.deepPurpleAccent,
      ),
    );
  }

}
