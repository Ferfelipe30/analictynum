import 'package:analictynum/src/home.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class intro extends StatefulWidget{
  const intro({super.key});

  @override
  State<intro> createState() => introPage();
}

// ignore: camel_case_types
class introPage extends State<intro>{
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
                    'Introducción',
                    style: TextStyle(
                      color:Color.fromRGBO(0, 59, 105, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Raíces de ecuaciones se ocupa de métodos que aprovechan el hecho de que una función cambia de signo en la vecindad de una raíz. A estas tecnicas se les llama metodos cerrados, o de intervalos, por que se necesita de dos valores iniciales para la raiz. como su nombre lo indica, dichos valores iniciales deben "encerrar", o estar en ambos lados de la raíz.',
                    style: TextStyle(
                      color: Color.fromRGBO(1, 1, 1, 1),
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 59, 105, 1),
                      foregroundColor: const Color.fromRGBO(1, 1, 1, 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const home(),)
                      );
                    }, 
                    child: const Text(
                      'Inicio',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
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