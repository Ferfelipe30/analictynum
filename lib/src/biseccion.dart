import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

// ignore: camel_case_types
class biseccion extends StatefulWidget{
  const biseccion({super.key});

  @override
  State <biseccion> createState() => biseccionPase();
}

// ignore: camel_case_types
class biseccionPase extends State<biseccion>{
  final funcion = TextEditingController();
  final intervaloI = TextEditingController();
  final intervaloS = TextEditingController();
  double resultado = 0.0;
  double epsilon = 0;
  int iteraciones = 0;

  @override
  void dispose(){
    funcion.dispose();
    intervaloI.dispose();
    intervaloS.dispose();
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

  void calcularBiseccion(){
    String function = funcion.text;
    double s = double.parse(intervaloS.text);
    double i = double.parse(intervaloI.text);
    epsilon = 0.0001;
    double c;

    if (evaluateFuncition(function, s)*evaluateFuncition(function, 1) >= 0) {
      return;
    }

    do {
      c = (s + i)/2;
      if (evaluateFuncition(function, c) == 0 || (i - s)/2 < epsilon) {
        break;
      }

      if (evaluateFuncition(function, c) * evaluateFuncition(function, s) < 0) {
        i = c;
      } else{
        s = c;
      }
      iteraciones ++;
    } while ((i-s)/2 >= epsilon);

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
                    'Metodo Biseccion',
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
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Intervalo Superior',
                      fillColor: Color.fromRGBO(89, 149, 199, 1),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  TextFormField(
                    controller: intervaloS,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: 'Intervalo Inferior',
                      fillColor: Color.fromRGBO(89, 149, 199, 1),
                    ),
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 59, 105, 1),
                      foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    onPressed: (){
                      calcularBiseccion();
                      // ignore: avoid_print
                      print('Resultados: $resultado');
                    }, 
                    child: const Text(
                      'Calcular',
                      style: TextStyle(fontSize: 20),
                    )
                  ),
                  const SizedBox(height: 16,),
                  Text('Resultado: $resultado'),
                  const SizedBox(height: 16,),
                  Text('Error: $epsilon'),
                  const SizedBox(height: 16,),
                  Text('Iteraciones: $iteraciones'),
                ],
              ),
            ),
          ),
        )
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
    );
  }
}