import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gps/registros_culto.dart';

class OpcoesVoluntarios extends StatelessWidget {
  String titulo = "";
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
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
            Navigator.pushNamed(context, '/telaInicial');
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                backgroundColor: const Color.fromARGB(150, 132, 64, 120),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
              onPressed: () async {
                titulo = "Culto de " + DateTime.now().day.toString() + "." + DateTime.now().month.toString();

                var userDoc = await FirebaseFirestore.instance.collection("Cultos").doc(titulo)
                    .get().then((userDoc) {
                  if (userDoc.exists) {
                    Map<String, dynamic>? map = userDoc.data() as Map<String, dynamic>?;
                    if (map?["Finalizado"] == true) {
                      FirebaseFirestore.instance.collection("Cultos").doc(titulo).update(
                          {"Finalizado" : false}).then((value) => {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: const Color.fromARGB(255, 132, 64, 166),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)), //this right here
                                child: Wrap(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Deseja iniciar um Registro de Culto para o dia de hoje?",
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/registrosCulto');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                              backgroundColor: Color.fromARGB(255, 254, 169, 1),
                                            ),
                                            child: const Text(
                                              "Sim",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context, '/opcoesVoluntarios');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                              backgroundColor: Color.fromARGB(255, 254, 169, 1),
                                            ),
                                            child: const Text(
                                              "Não",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })
                      });

                    } else {
                      Navigator.pushNamed(context, '/registrosCulto');
                      //Navigator.pushNamed(context, Registros(titulo: titulo) as String);
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: const Color.fromARGB(255, 132, 64, 166),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)), //this right here
                            child: Wrap(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    "Deseja iniciar um Registro de Culto para o dia de hoje?",
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance.collection("Cultos").doc(titulo)
                                              .set({"Inicializado" : true, "Finalizado" : false});
                                          Navigator.pushNamed(context, '/registrosCulto');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                          backgroundColor: Color.fromARGB(255, 254, 169, 1),
                                        ),
                                        child: const Text(
                                          "Sim",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/opcoesVoluntarios');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                                          backgroundColor: Color.fromARGB(255, 254, 169, 1),
                                        ),
                                        child: const Text(
                                          "Não",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.app_registration,
                    size: 30,
                    color: Color.fromARGB(255, 254, 169, 1),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Text(
                      'Registrar Culto',
                      style: TextStyle(
                        color: Color.fromARGB(255, 254, 169, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                backgroundColor: const Color.fromARGB(150, 132, 64, 120),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                )
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/cadastroCrianca');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.person_add,
                    size: 30,
                    color: Color.fromARGB(255, 254, 169, 1),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Text(
                      'Cadastrar Criança',
                      style: TextStyle(
                        color: Color.fromARGB(255, 254, 169, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                backgroundColor: const Color.fromARGB(150, 132, 64, 120),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                )
              ),
              onPressed: (){},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 30,
                    color: Color.fromARGB(255, 254, 169, 1),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        'Escala de Voluntários',
                        softWrap: true,
                        style: TextStyle(
                          height: 1,
                          color: Color.fromARGB(255, 254, 169, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  /*Opacity(
                    opacity: 0,
                    child: Icon(Icons.calendar_month),
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}