import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroUsuario extends StatefulWidget {
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _zap = TextEditingController();
  String _opcao = "Voluntário";
  String nome = "";
  String email = "";
  String senha = "";
  String zap = "";
  bool ativo = true;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore database = FirebaseFirestore.instance;
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'CADASTRO DE USUÁRIOS',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(150, 132, 64, 120),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 34,
          ),
          color: const Color.fromARGB(255, 254, 169, 1),
          onPressed: () {
            Navigator.pushNamed(context, '/telaInicial');
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(150, 132, 64, 166),
      body: Container(
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "Nome: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                height: 50,
                                child: TapRegion(
                                  child: TextField(
                                    controller: _nome,
                                    showCursor: true,
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Insira seu nome',
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
                                )
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "Email: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                height: 50,
                                child: TapRegion(
                                  onTapOutside: (tap) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  onTapInside: (tap) {
                                    setState(() {
                                      if (ativo == true) {}
                                      else if (ativo == false) {ativo = !ativo;}
                                    });
                                  },
                                  child: TextField(
                                    controller: _email,
                                    showCursor: true,
                                    obscureText: false,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'insira seu email',
                                    ),
                                  ),
                                )
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "Senha: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                height: 50,
                                child: TapRegion(
                                  onTapOutside: (tap) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  onTapInside: (tap) {
                                    setState(() {
                                      if (ativo == true) {}
                                      else if (ativo == false) {ativo = !ativo;}
                                    });
                                  },
                                  child: TextField(
                                    controller: _senha,
                                    showCursor: true,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Escolha uma senha',
                                    ),
                                  ),
                                )
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "WhatsApp: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                  height: 80,
                                  child: TapRegion(
                                    onTapOutside: (tap) {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                    },
                                    onTapInside: (tap) {
                                      setState(() {
                                        if (ativo == true) {}
                                        else if (ativo == false) {ativo = !ativo;}
                                      });
                                    },
                                    child: MaskedTextField(
                                      controller: _zap,
                                      mask: "(##) #####-####",
                                      obscureText: false,
                                      maxLength: 15,
                                      cursorHeight: 25,
                                      textAlignVertical: TextAlignVertical.center,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'insira seu whatsapp',
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            "Tipo de Usuário: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: SizedBox(
                                height: 50,
                                child: TapRegion(
                                  onTapOutside: (tap) {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                  },
                                  onTapInside: (tap) {
                                    setState(() {
                                      if (ativo == true) {}
                                      else if (ativo == false) {ativo = !ativo;}
                                    });
                                  },
                                  child: DropdownButton<String>(
                                    items: [
                                      DropdownMenuItem<String>(
                                        child: new Text("Voluntário"),
                                        value: "Voluntário",
                                      ),
                                      DropdownMenuItem<String>(
                                        child: new Text("Responsável"),
                                        value: "Responsável",
                                      ),
                                      DropdownMenuItem<String>(
                                        child: new Text("Ambos"),
                                        value: "Ambos",
                                      ),
                                    ],
                                    value: _opcao,
                                    onChanged: opcaoEscolhida,
                                  ),
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        if(_senha.text.length >= 6) {
                          if (nome == "" || email == "" || senha == "" || zap == "") { //checa se é uma inserção nova de dados
                            if (_nome.text == "" || _email.text == "" || _senha.text == "" || _zap.text == "") { //se for, esse campos nao podem estar vazios
                              Toast.show(
                                  "Preencha todos os dados.",
                                  duration: Toast.lengthShort,
                                  gravity: Toast.center
                              );
                            } else { //se é inserção nova, e os dados nao sao vazios, checo por duplicados
                              if (await checarDuplicados(_nome.text,_email.text)) {
                                Toast.show(
                                  "Nome ou email já cadastrado",
                                  duration: Toast.lengthShort,
                                );
                              } else { //se nao for duplicado, salvo o usuario
                                nome = _nome.text;
                                email = _email.text;
                                senha = _senha.text;
                                zap = _zap.text;
                                await _auth.createUserWithEmailAndPassword(email: email, password: senha);
                                await _auth.signOut();

                                setState(() {
                                  if(ativo == false) {}
                                  else if (ativo == true) {ativo = !ativo;}
                                });

                                if (_opcao == "Voluntário") { //checar qual tipo de usuario
                                  CollectionReference users = FirebaseFirestore.instance.collection('Voluntário');

                                  Map<String,dynamic> usuario = {};
                                  usuario["nome"] = nome;
                                  usuario["senha"] = senha;
                                  usuario["zap"] = zap;
                                  usuario["checkado"] = false;
                                  usuario["validado"] = false;

                                  users.doc(email).set(usuario);
                                } else if (_opcao == "Responsável") {
                                  CollectionReference users = FirebaseFirestore.instance.collection('Responsável');

                                  Map<String,dynamic> usuario = {};
                                  usuario["nome"] = nome;
                                  usuario["senha"] = senha;
                                  usuario["zap"] = zap;
                                  usuario["checkado"] = false;
                                  usuario["validado"] = false;

                                  users.doc(email).set(usuario);
                                } else if (_opcao == "Ambos") {
                                  CollectionReference users = FirebaseFirestore.instance.collection('Voluntário');
                                  CollectionReference resp = FirebaseFirestore.instance.collection('Responsável');

                                  Map<String,dynamic> usuario = {};
                                  usuario["nome"] = nome;
                                  usuario["senha"] = senha;
                                  usuario["zap"] = zap;
                                  usuario["checkado"] = false;
                                  usuario["validado"] = false;

                                  resp.doc(email).set(usuario);
                                  users.doc(email).set(usuario);
                                }
                              }
                            }
                          }
                          else if (nome == _nome.text &&
                              email == _email.text &&
                              senha == _senha.text &&
                              zap == _zap.text)
                          { //se nao é a primeira inserção, tenho que ver se não clicou duas vezes em savar
                            Toast.show(
                                "Nome ou email já cadastrado.",
                                duration: Toast.lengthShort,
                                gravity: Toast.center
                            );
                          } else { // caso nao vou seguir e verificar se é duplicado
                            if (await checarDuplicados(_nome.text,_email.text)) { //é duplicado?
                              Toast.show(
                                "Nome ou email já cadastrado",
                                duration: Toast.lengthShort,
                              );
                            } else { //se nao for, eu salvo
                              nome = _nome.text;
                              email = _email.text;
                              senha = _senha.text;
                              zap = _zap.text;
                              await _auth.createUserWithEmailAndPassword(email: email, password: senha);
                              await _auth.signOut();
                              
                              setState(() {
                                if(ativo == false) {}
                                else if (ativo == true) {ativo = !ativo;}
                              });

                              if (_opcao == "Voluntário") {
                                CollectionReference users = FirebaseFirestore.instance.collection('Voluntário');

                                Map<String,dynamic> usuario = {};
                                usuario["nome"] = nome;
                                usuario["senha"] = senha;
                                usuario["zap"] = zap;
                                usuario["checkado"] = false;
                                usuario["validado"] = false;

                                users.doc(email).set(usuario);
                              } else if (_opcao == "Responsável") {
                                CollectionReference users = FirebaseFirestore.instance.collection('Responsável');

                                Map<String,dynamic> usuario = {};
                                usuario["nome"] = nome;
                                usuario["senha"] = senha;
                                usuario["zap"] = zap;
                                usuario["checkado"] = false;
                                usuario["validado"] = false;

                                users.doc(email).set(usuario);
                              } else if (_opcao == "Ambos") {
                                CollectionReference users = FirebaseFirestore.instance.collection('Voluntário');
                                CollectionReference resp = FirebaseFirestore.instance.collection('Responsável');

                                Map<String,dynamic> usuario = {};
                                usuario["nome"] = nome;
                                usuario["senha"] = senha;
                                usuario["zap"] = zap;
                                usuario["checkado"] = false;
                                usuario["validado"] = false;

                                resp.doc(email).set(usuario);
                                users.doc(email).set(usuario);
                              }
                            }
                          }
                        } else {
                          Toast.show(
                              "A senha deve ter no mínimo 6 caracteres",
                              duration: Toast.lengthLong,
                              gravity: Toast.center
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ativo ? Colors.black : Colors.grey
                      ),
                      child: Text(
                        ativo ? "Salvar" : "Salvo",
                        style: TextStyle(
                          color: ativo ? const Color.fromARGB(255, 254, 169, 1) :
                            const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  void opcaoEscolhida(String? opcaoEscolhida) {
    if (opcaoEscolhida is String) {
      setState(() {
        _opcao = opcaoEscolhida;
      });
    }
  }

  Future<bool> checarDuplicados(String nome, String email) async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    CollectionReference users = database.collection('Voluntário');
    CollectionReference resp = database.collection('Responsável');
    bool repetido = false;

    final data1 = await users.get();
    final data2 = await resp.get();

    for (var element in data1.docs) {
      if (element.id.toString() == email || element.get("nome").toString() == nome) {
        repetido = true;
      }
    }

    data2.docs.forEach((element) {
      if (element.id.toString() == email || element.get("nome").toString() == nome) {
        repetido = true;
      }
    });

    return repetido;

  }

}




/*
class TextFieldCustomizada extends StatefulWidget {
  @override
  _TextFieldCustomizadaState createState() => _TextFieldCustomizadaState();
}

class _TextFieldCustomizadaState extends State<TextFieldCustomizada> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/
