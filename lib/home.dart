import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps/sign_in_page.dart';
import 'package:gps/utils/FirebaseService.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    FirebaseService service = new FirebaseService();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore database = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Color.fromARGB(150, 132, 64, 166),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Container(
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Image.asset('imagens/gps_logo_dif_cor.png'),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: ElevatedButton(
              onPressed: () async {
                CollectionReference voluntarios = database.collection("Voluntário");
                print(_auth.currentUser);
                if (_auth.currentUser == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Color.fromARGB(255, 132, 64, 166),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)), //this right here
                          child: Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Login de Voluntários",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: GoogleSignIn(),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      backgroundColor: Color.fromARGB(255, 254, 169, 1),
                                    ),
                                    onPressed: (){},
                                    child: Container(
                                      child: const Text(
                                        'Login com email',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  final data1 = await voluntarios.get();
                  try {
                    final email = _auth.currentUser?.email;
                    bool cadastrado = false;
                    for (var element in data1.docs) {
                      if (element.id.toString() == email) {
                        cadastrado = true;
                        print(element.id.toString());
                        if (element.get("validado") == true) {
                          print(element.get("validado"));
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
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                backgroundColor: Color.fromARGB(255, 254, 169, 1),
              ),
              child: const Text(
                'Sou Voluntário',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: ElevatedButton(
              onPressed: (){
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                backgroundColor: Color.fromARGB(255, 254, 169, 1),
              ),
              child: const Text(
                'Sou Pai/Mãe',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
            child: const Text(
              'Ensina a criança no caminho em que deve andar, e ainda quando for velho,'
                  ' não se desviará dele. Pv. 22:6',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastroUsuario');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 254, 169, 1),
                    ),
                    child: const Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: IconButton(
                    onPressed: () async {
                      if (_auth.currentUser == null) {
                        Toast.show(
                            "Não há um usuário logado",
                          duration: Toast.lengthShort,
                          gravity: 10,
                        );
                      } else {
                        await service.signOutFromGoogle();
                        Toast.show(
                          "Usuário deslogado",
                          duration: Toast.lengthShort,
                          gravity: 0,
                        );
                      }
                    },
                    icon: const Icon(Icons.logout_outlined),
                    color: const Color.fromARGB(255, 254, 169, 1),
                    iconSize: 35,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



