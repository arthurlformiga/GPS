import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'opcoes_voluntarios.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DialogLoginVoluntario extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(150, 132, 64, 166),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(150, 132, 64, 120),
        leading: const Icon(
          Icons.arrow_back,
          size: 40,
          color: Color.fromARGB(255, 254, 169, 1),
        ),
      ),
      body: Column(
        children: [
          SignInButton(
              Buttons.google,
              text: "Faça login com Google",
              onPressed: () {}
          ),
        ],
      ),
    );
  }
}

Dialog loginDialog = Dialog(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  child: Container(
    height: 300.0,
    width: 300.0,

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SignInButton(
            Buttons.google,
            text: "Faça login com Google",
            onPressed: () {}
        ),
        ElevatedButton(
            onPressed: (){},
            child: Container(
              child: Text(
                'Login com email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ),
      ],
    ),
  ),
);