// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// ignore: camel_case_types
class falsaPosicion extends StatefulWidget{
  const falsaPosicion ({super.key});

  @override
  State<falsaPosicion> createState() => falsaPosicionPage();
}

// ignore: camel_case_types
class falsaPosicionPage extends State<falsaPosicion>{
  final funcion = TextEditingController();
  final intervalosS = TextEditingController();
  final intervalosI = TextEditingController();
  double resultado = 0.0;
  double epsilon = 0;
  int iteraciones = 0;

  @override
  void dispose(){
    funcion.dispose();
    intervalosI.dispose();
    intervalosS.dispose();
    super.dispose();
  }

  double evaluateFuncition(String function, double x){
    Parser p = Parser();
    Expression exp = p.parse(function);
    ContextModel cm = ContextModel();
    cm.bindVariable(Variable('x'), Number(x));
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval;
  }

  void calcularFalsaPosicion(){
    String function = funcion.text;
    double s = double.parse(intervalosS.text);
    double i = double.parse(intervalosI.text);
    epsilon = 0.0001;
    double c;

    if (evaluateFuncition(function, s) * evaluateFuncition(function, i) >= 0) {
      return;
    }

    do {
      c = (s * evaluateFuncition(function, i)-i * evaluateFuncition(function, s))/
      (evaluateFuncition(function, i) - evaluateFuncition(function, s));

      if (evaluateFuncition(function, c) == 0.0) break;

      if (evaluateFuncition(function, c) * evaluateFuncition(function, s) < 0) {
        i = c;
      } else {
        s = c;
      }
      iteraciones ++;
    } while ((i-s).abs() >= epsilon);

    setState(() {
      resultado = c;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Metodo Falsa Posicion',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(0, 59, 105, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: funcion,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Función: x^2 -4',
                      fillColor: Color.fromRGBO(89, 149, 199, 1),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: intervalosS,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Intervalo Superior',
                      fillColor: Color.fromRGBO(89, 149, 199, 1),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: intervalosI,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Intervalo Inferior',
                      fillColor: Color.fromRGBO(89, 149, 199, 1),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 59, 105, 1),
                      foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    onPressed: (){
                      calcularFalsaPosicion();
                      // ignore: avoid_print
                      print('resultado: $resultado');
                    }, 
                    child: const Text(
                      'Calcular',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Text('Resultado: $resultado'),
                  const SizedBox(height: 16,),
                  Text('Errores: $epsilon'),
                  const SizedBox(height: 16,),
                  Text('Iteraciones: $iteraciones'),
                ],
              ), 
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }
}