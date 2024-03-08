import 'package:analictynum/src/intro.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class inicio extends StatefulWidget{
  const inicio({super.key});

  @override
  State<inicio> createState() => inicioPage();
} 

// ignore: camel_case_types
class inicioPage extends State<inicio>{
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
                  //imagen de entrada
                  Image.asset(
                    'imagen/logo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 30,),
                  //Boton de Inicio
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 59, 105, 1),
                      foregroundColor: const Color.fromRGBO(1, 1, 1, 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const intro(),)
                      );
                    }, 
                    child: const Text(
                      'Login',
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