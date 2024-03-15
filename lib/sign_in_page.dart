import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:toast/toast.dart';
import 'utils/FirebaseService.dart';

class GoogleSignIn extends StatefulWidget {
  GoogleSignIn({Key? key}) : super(key: key);

  @override
  _GoogleSignInState createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  FirebaseFirestore database = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    CollectionReference voluntarios = database.collection('Voluntário');
    Size size = MediaQuery.of(context).size;
    return  !isLoading? SizedBox(
      width: size.width * 0.7,
      child: SignInButton(
          Buttons.google,
          text: "Faça login com Google",
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            FirebaseService service = new FirebaseService();
            final data1 = await voluntarios.get();
            try {
              final email = await service.signInwithGoogle();
              print(email);
              bool cadastrado = false;
              for (var element in data1.docs) {
                if (element.id.toString() == email) {
                  cadastrado = true;
                  print(element.id.toString());
                  if (element.get("validado") == true) {
                    Navigator.pushNamed(context, '/opcoesVoluntarios');
                    break;
                  } else {
                    Toast.show(
                      "Usuário não validado, entre em contato com o líder do ministério",
                      duration: Toast.lengthLong,
                      gravity: Toast.bottom,
                    );
                    Navigator.pushNamed(context, '/telaInicial');
                    await service.signOutFromGoogle();
                    break;
                  }
                }
              };

              if (cadastrado == false) {
                await service.signOutFromGoogle();
                Toast.show(
                  "Usuário não cadastrado, cadastre-se no botão abaixo",
                  duration: Toast.lengthLong,
                  gravity: Toast.bottom,
                );
                Navigator.pushNamed(context, '/telaInicial');
              }

            } catch(e){
              if(e is FirebaseAuthException){
                //do smt
              }
            }
            setState(() {
              isLoading = false;
            });
          },
        )
    ): const CircularProgressIndicator();
  }
}

