import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:toast/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastroCrianca extends StatefulWidget {
  _CadastroCriancaState createState() => _CadastroCriancaState();
}

class _CadastroCriancaState extends State<CadastroCrianca> {
  final _nome = TextEditingController();
  final _pai = TextEditingController();
  final _idade = TextEditingController();
  final _zap = TextEditingController();
  final _atipicidade = TextEditingController();
  final _alergias = TextEditingController();
  bool _genero = true;
  String nome = "";
  String pai = "";
  String idade = "";
  String zap = "";
  String atipicidade = "";
  String alergias = "";
  bool genero = true;
  bool ativo = true;
  bool interrog = true;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore database = FirebaseFirestore.instance;
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'CADASTRO DE CRIANÇAS',
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
            Navigator.pushNamed(context, '/opcoesVoluntarios');
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(150, 132, 64, 166),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 254, 169, 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: IconButton(
                        onPressed: () {
                          if (interrog) {
                            setState(() {
                              interrog = false;
                            });
                          }
                          else {
                            setState(() {
                              _genero = !_genero;
                            });
                          }
                        },
                        icon: Icon(
                          interrog ? Icons.question_mark : _genero ? Icons.face : Icons.face_3,
                          size: 70,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Nome:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 3, right: 10),
                      child: TapRegion(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _nome,
                            showCursor: true,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Insira o nome da criança',
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
                      padding: EdgeInsets.only(left: 10, top: 15, right: 10),
                      child: Text(
                        "Pai/Mãe:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 3, right: 10),
                      child: TapRegion(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _pai,
                            showCursor: true,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Insira o nome do Responsável',
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
                      padding: EdgeInsets.only(left: 10, top: 15, right: 10),
                      child: Text(
                        "Idade:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 3, right: 10),
                      child: TapRegion(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _idade,
                            showCursor: true,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Insira a idade da criança',
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
                      padding: EdgeInsets.only(left: 10, top: 15, right: 10),
                      child: Text(
                        "Whatsapp:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 3, right: 10),
                      child: TapRegion(
                        child: SizedBox(
                          height: 80,
                          child: MaskedTextField(
                            controller: _zap,
                            mask: "(##) #####-####",
                            obscureText: false,
                            maxLength: 15,
                            cursorHeight: 35,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Telefone do Responsável',
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
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
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Atipicidade:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 3, right: 10),
                      child: TapRegion(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _atipicidade,
                            showCursor: true,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Autismo, TDAH, não há',
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
                      padding: EdgeInsets.only(left: 10, top: 15, right: 10),
                      child: Text(
                        "Alergias:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 3, right: 10),
                      child: TapRegion(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: _alergias,
                            showCursor: true,
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Chocolate, leite, não há',
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
                      padding: EdgeInsets.all(20),
                      child: Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (nome == "" || pai == "" || idade == "" || zap == "") { //checa se é uma inserção nova de dados
                                if (_nome.text == "" || _pai.text == "" || _idade.text == "" || _zap.text == "") { //se for, esse campos nao podem estar vazios
                                  Toast.show(
                                      "Preencha todos os dados.",
                                      duration: Toast.lengthShort,
                                      gravity: Toast.center
                                  );
                                } else { //se é inserção nova, e os dados nao sao vazios, checo por duplicados
                                  if (await checarDuplicados(_nome.text,_pai.text)) {
                                    Toast.show(
                                      "Criança já cadastrada.",
                                      duration: Toast.lengthShort,
                                    );
                                  } else { //se nao for duplicado, salvo o usuario
                                    nome = _nome.text;
                                    pai = _pai.text;
                                    idade = _idade.text;
                                    zap = _zap.text;
                                    atipicidade = _atipicidade.text;
                                    alergias = _alergias.text;
                                    genero = _genero;
                                    setState(() {
                                      if(ativo == false) {}
                                      else if (ativo == true) {ativo = !ativo;}
                                    });

                                    CollectionReference criancas = FirebaseFirestore.instance.collection('criancas');

                                    Map<String,dynamic> crianca = {};
                                    crianca["alergia"] = alergias;
                                    crianca["atipicidade"] = atipicidade;
                                    crianca["mãe"] = pai;
                                    crianca["idade"] = idade;
                                    crianca["Telefone"] = zap;
                                    crianca["checkado"] = false;
                                    crianca["gênero"] = genero;

                                    criancas.doc(nome).set(crianca);

                                  }
                                }
                              }
                              else if (nome == _nome.text &&
                                  pai == _pai.text &&
                                  idade == _idade.text &&
                                  zap == _zap.text &&
                                  alergias == _alergias.text &&
                                  atipicidade == _atipicidade.text)
                              { //se nao é a primeira inserção, tenho que ver se não clicou duas vezes em savar
                                Toast.show(
                                    "Criança já cadastrada.",
                                    duration: Toast.lengthShort,
                                    gravity: Toast.center
                                );
                              } else { // caso nao vou seguir e verificar se é duplicado
                                if (await checarDuplicados(_nome.text,_pai.text)) { //é duplicado?
                                  Toast.show(
                                    "Criança já cadastrada.",
                                    duration: Toast.lengthShort,
                                  );
                                } else { //se nao for, eu salvo
                                  nome = _nome.text;
                                  pai = _pai.text;
                                  idade = _idade.text;
                                  zap = _zap.text;
                                  atipicidade = _atipicidade.text;
                                  alergias = _alergias.text;
                                  genero = _genero;
                                  setState(() {
                                    if(ativo == false) {}
                                    else if (ativo == true) {ativo = !ativo;}
                                  });

                                  CollectionReference criancas = FirebaseFirestore.instance.collection('criancas');

                                  Map<String,dynamic> crianca = {};
                                  crianca["alergia"] = alergias;
                                  crianca["atipicidade"] = atipicidade;
                                  crianca["mãe"] = pai;
                                  crianca["idade"] = idade;
                                  crianca["Telefone"] = zap;
                                  crianca["checkado"] = false;
                                  crianca["gênero"] = genero;

                                  criancas.doc(nome).set(crianca);

                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ativo ? Colors.black : Colors.grey
                            ),
                            child: Text(
                              ativo ? "Salvar" : "Salvo",
                              style: TextStyle(
                                  color: ativo ? Color.fromARGB(255, 254, 169, 1) :
                                  Color.fromARGB(255, 255, 255, 255),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checarDuplicados(String nome, String pai) async {
    FirebaseFirestore database = FirebaseFirestore.instance;
    CollectionReference criancas = database.collection('criancas');
    bool repetido = false;

    final data1 = await criancas.get();

    for (var element in data1.docs) {
      if (element.id.toString() == nome && element.get("mãe").toString() == pai) {
        repetido = true;
        break;
      }
    }

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
