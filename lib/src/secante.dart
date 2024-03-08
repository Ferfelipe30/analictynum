import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// ignore: camel_case_types
class secante extends StatefulWidget{
  const secante({super.key});

  @override
  State<secante> createState() => secantePage();
}

// ignore: camel_case_types
class secantePage extends State <secante>{
  final TextEditingController funcion = TextEditingController();
  final TextEditingController x1 = TextEditingController();
  final TextEditingController x2 = TextEditingController();
  //final iteracciones = TextEditingController();
  double result = 0.0;
  double epsilon = 0;
  int iteracciones = 0;

  @override
  void dispose(){
    funcion.dispose();
    x1.dispose();
    x2.dispose();
    super.dispose();
  }

  double evaluateFunction (String function, double x){
    Parser p = Parser();
    Expression exp = p.parse(function);
    ContextModel cm = ContextModel();
    cm.bindVariable(Variable('x'), Number(x));
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    return eval;
  }

  void calcularSecante(){
    String function = funcion.text;
    double a = double.parse(x1.text);
    double b = double.parse(x2.text);
    //double tolerance = double.parse(iteracciones.text);
    epsilon = 0.0001;

    double f1 = evaluateFunction(function, a);
    double f2 = evaluateFunction(function, b);

    double x = b - (f2*(b - a)) / (f2-f1);

    while ((x - b).abs() >= epsilon){
      a = b;
      b = x;
      f1 = evaluateFunction(function, a);
      f2 = evaluateFunction(function, b);
      x = b - (f2 * (b - a)) / (f2-f1);
      iteracciones ++;
    }

    setState(() {
      result = x;
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
                    'Metodo de La Secante',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromRGBO(0, 59, 105, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: funcion,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Introdusca la Funcion',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromRGBO(89, 149, 199, 1),   
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: x1,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Introdusca el valor inferior.',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromRGBO(89, 149, 199, 1),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: x2,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Introdusca el valor superior.',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromRGBO(89, 149, 199, 1),
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  /*TextFormField(
                    controller: iteracciones,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Indrodusca el numero de iteracciones.',
                      border: OutlineInputBorder(),
                      fillColor: Color.fromRGBO(89, 149, 199, 1),
                      filled: true,
                    ),
                  ),*/
                  //const SizedBox(height: 16,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 59, 105, 1),
                      foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    onPressed: (){
                      calcularSecante();
                      // ignore: avoid_print
                      print('Resultado: $result');
                    }, 
                    child: const Text(
                      'Calcular',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Text('Resultado: $result'),
                  const SizedBox(height: 16,),
                  Text('Error: $epsilon'),
                  const SizedBox(height: 16,),
                  Text('Iteraciones: $iteracciones'),
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