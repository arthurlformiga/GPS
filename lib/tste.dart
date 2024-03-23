import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Checkin2 extends StatefulWidget {
  @override
  _checkin2State createState() => _checkin2State();
}

class _checkin2State extends State<Checkin2> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController _buscador = TextEditingController();
  List resultados = [];
  List resultFiltrados = [];

  listaFiltrada() {
    var mostrarResultados = [];
    if(_buscador.text != "") {
      for(var crianca in resultados) {
        var name = crianca["nome"].toString().toLowerCase();
        if(name.contains(_buscador.text.toLowerCase())) {
          mostrarResultados.add(crianca);
        }
      }
    } else {
      mostrarResultados = List.from(resultados);
    }

    setState(() {
      resultFiltrados = mostrarResultados;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance.collection('criancas').get();
    print(data.docs.toString());

    setState(() {
      resultados = data.docs;
    });

    listaFiltrada();
  }

  @override
  void initState() {
    super.initState();
    _buscador.addListener(buscadorAlterado);
  }

  @override
  void dispose() {
    _buscador.removeListener(buscadorAlterado);
    _buscador.dispose();
    super.dispose();
  }

  buscadorAlterado() {
    listaFiltrada();
    print(_buscador.text);
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(150, 132, 64, 166),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(150, 132, 64, 120),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 34,
            ),
            color: const Color.fromARGB(255, 254, 169, 1),
            onPressed: () {
              Navigator.pushNamed(context, '/registrosCulto');
            },
          ),
          title: CupertinoSearchTextField(
            controller: _buscador,
            backgroundColor: const Color.fromARGB(120, 254, 169, 1),
            placeholder: "Busque por nome da criança",
          ),
        ),
        body: ListView.builder(
            itemCount: resultFiltrados.length, //resultados.length,
            itemBuilder: (context,index) {
              bool checkado = resultFiltrados[index]["checkado"];
              return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    color: const Color.fromARGB(255, 254, 169, 1),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    resultFiltrados[index]["gênero"] ? Icons.face : Icons.face_3,
                                    size: 70,
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10,right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nome:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Pai/mãe:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Whatsapp:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Idade:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    resultFiltrados[index]["nome"].toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    resultFiltrados[index]["mãe"].toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    resultFiltrados[index]["Telefone"].toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    resultFiltrados[index]["idade"].toString(),
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Text(
                                "Atipiciadade:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              resultFiltrados[index]["atipicidade"].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Alergias:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              resultFiltrados[index]["alergia"].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Realizar Check-in",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                            Switch(
                                activeColor: Colors.green[100],
                                activeTrackColor: Colors.green[500],
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.black,
                                value: checkado,
                                onChanged: (value) {
                                  setState(() {
                                    db.collection("criancas").doc(resultFiltrados[index]["nome"].toString())
                                        .update({"checkado":value});
                                    checkado = value;
                                    getClientStream();
                                  });
                                }
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
              );
            }
        )
    );
  }
}