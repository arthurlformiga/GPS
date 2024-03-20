import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps/sign_in_page.dart';
import 'package:gps/utils/FirebaseService.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    FirebaseService service = FirebaseService();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore database = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: const Color.fromARGB(150, 132, 64, 166),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Image.asset('imagens/gps_logo_dif_cor.png'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            child: ElevatedButton(
              onPressed: () async {
                CollectionReference voluntarios = database.collection("Voluntário");
                if (_auth.currentUser == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: const Color.fromARGB(255, 132, 64, 166),
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
                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: GoogleSignIn(),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                      backgroundColor: const Color.fromARGB(255, 254, 169, 1),
                                    ),
                                    onPressed: (){
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          final _email = TextEditingController();
                                          String email = "";
                                          final _senha = TextEditingController();
                                          String senha = "";
                                          bool ativo = true;
                                          bool semCadastro = true;
                                          ToastContext().init(context);
                                          return Dialog(
                                            backgroundColor: const Color.fromARGB(255, 132, 64, 166),
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0)), //this right here
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 12, left: 12),
                                              child: Wrap(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets.only(top:10, left: 10, right: 10),
                                                        child: Text(
                                                          "Email:",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10, top: 3, right: 10),
                                                        child: TapRegion(
                                                          child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: _email,
                                                              showCursor: true,
                                                              obscureText: false,
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                labelText: 'Insira seu email',
                                                              ),
                                                            ),
                                                          ),
                                                          onTapOutside: (tap) {
                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                          },
                                                          onTapInside: (tap) {
                                                            setState(() {
                                                              if (ativo == true) {}
                                                              else if (ativo == false) {ativo = !ativo;}
                                                            });
                                                          },
                                                        ),
                                                      ),

                                                      const Padding(
                                                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                                        child: Text(
                                                          "Senha:",
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 10, top: 3, right: 10),
                                                        child: TapRegion(
                                                          child: SizedBox(
                                                            height: 50,
                                                            child: TextField(
                                                              controller: _senha,
                                                              showCursor: true,
                                                              obscureText: false,
                                                              decoration: const InputDecoration(
                                                                border: OutlineInputBorder(),
                                                                labelText: 'Insira sua senha',
                                                              ),
                                                            ),
                                                          ),
                                                          onTapOutside: (tap) {
                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                          },
                                                          onTapInside: (tap) {
                                                            setState(() {
                                                              if (ativo == true) {}
                                                              else if (ativo == false) {ativo = !ativo;}
                                                            });
                                                          },
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 20),
                                                        child: Container(
                                                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                                                          child: Center(
                                                            child: ElevatedButton(
                                                              onPressed: () async {
                                                                if (email == "" || senha == "") { //checa se é uma inserção nova de dados
                                                                  if (_email.text == "" || _senha.text == "") { //se for, esse campos nao podem estar vazios
                                                                    Toast.show(
                                                                        "Preencha todos os dados.",
                                                                        duration: Toast.lengthShort,
                                                                        gravity: Toast.center
                                                                    );
                                                                  } else { //se é inserção nova, e os dados nao sao vazios, checo por duplicados
                                                                    email = _email.text;
                                                                    senha = _senha.text;
                                                                    final data = await FirebaseFirestore.instance.collection('Voluntário').get();

                                                                    for(var element in data.docs) {
                                                                      if(email == element.id) {
                                                                        semCadastro = false;
                                                                        if(senha == element.get("senha").toString()) {
                                                                          if(element.get("validado") == true) {
                                                                            _auth.signInWithEmailAndPassword(email: email, password: senha);
                                                                            Navigator.pushNamed(context, '/opcoesVoluntarios');
                                                                            break;
                                                                          } else {
                                                                            Toast.show(
                                                                                "Usuário não validado, entre em contato com seu líder.",
                                                                                duration: Toast.lengthLong,
                                                                                gravity: Toast.center
                                                                            );
                                                                            break;
                                                                          }
                                                                        } else {
                                                                          Toast.show(
                                                                              "Senha incorreta.",
                                                                              duration: Toast.lengthShort,
                                                                              gravity: Toast.center
                                                                          );
                                                                          break;
                                                                        }
                                                                      } else {
                                                                        semCadastro = true;
                                                                      }
                                                                    }

                                                                    if(semCadastro == true) {
                                                                      Toast.show(
                                                                          "Usuário não cadastrado.",
                                                                          duration: Toast.lengthShort,
                                                                          gravity: Toast.center
                                                                      );
                                                                    }

                                                                  }
                                                                }
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor: ativo ? Colors.black : Colors.grey
                                                              ),
                                                              child: Text(
                                                                ativo ? "Entrar" : "Aguarde",
                                                                style: TextStyle(
                                                                    color: ativo ? const Color.fromARGB(255, 254, 169, 1) :
                                                                    const Color.fromARGB(255, 255, 255, 255),
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 20
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          );
                                        });
                                    },
                                    child: const Text(
                                      'Login com email',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
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
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                backgroundColor: const Color.fromARGB(255, 254, 169, 1),
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
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: ElevatedButton(
              onPressed: (){
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                backgroundColor: const Color.fromARGB(255, 254, 169, 1),
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
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 10),
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
          const Spacer(),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastroUsuario');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 254, 169, 1),
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
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
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

  checarDuplicados(String text, String text2) {}
}



