import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Incidentes extends StatefulWidget {
  @override
  _incidentesState createState() => _incidentesState();
}

class _incidentesState extends State<Incidentes> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String incidentes = "";
  var _incidentes = TextEditingController(
    text: 'Relate qualquer incidente relevante ocorrido durante a execução da ministração',
  );
  bool ativo = true;
  
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
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: TapRegion(
                  onTapOutside: (tap) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onTapInside: (tap) {
                    if(_incidentes.text == 'Relate qualquer incidente relevante ocorrido durante a execução da ministração') {
                      _incidentes.clear();
                    }
                    setState(() {
                      if (ativo == true) {}
                      else if (ativo == false) {ativo = !ativo;}
                    });
                  },
                  child: TextField(
                    maxLines: null,
                    controller: _incidentes,
                    showCursor: true,
                    obscureText: false,
                    decoration: const InputDecoration(
                      //hintText: 'Relate qualquer incidente relevante ocorrido durante a execução da ministração',
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 254, 169, 1),
                          width: 1,
                        ),
                      ),
                      labelText: 'Relate o incidente',
                      labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 254, 169, 1),
                      )
                    ),
                  ),
                ),
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                onPressed: () async {
                  if (incidentes == "") { //checa se é uma inserção nova de dados
                    if (_incidentes.text == "") { //se for, esse campos nao podem estar vazios
                      Toast.show(
                        "Preencha as informações.",
                        duration: Toast.lengthShort,
                        gravity: Toast.center
                      );
                    } else { //se nao for duplicado, salvo o usuario
                      incidentes = _incidentes.text;
                      String nomeDoCulto = "Culto do dia " + DateTime.now().day.toString() + " de " + DateTime.now().month.toString();
                      String horaDoIncidente = DateTime.now().toUtc().toLocal().hour.toString() + "h" + DateTime.now().minute.toString() + "min";
                      //DocumentReference docDoCulto = await db.collection("Incidentes").doc(nomeDoCulto);
                      //docDoCulto.update({horaDoIncidente : incidentes});
                      adicionarIncidente(incidentes,nomeDoCulto,horaDoIncidente);

                      setState(() {
                      if(ativo == false) {}
                      else if (ativo == true) {ativo = !ativo;}
                      });
                    }
                  } else if (incidentes == _incidentes.text) { //se nao é a primeira inserção, tenho que ver se não clicou duas vezes em savar
                    Toast.show(
                    "Incidente já registrado.",
                    duration: Toast.lengthShort,
                    gravity: Toast.center
                    );
                  } else { // caso nao vou seguir e verificar se é duplicado
                    incidentes = _incidentes.text;
                    String nomeDoCulto = "Culto do dia " + DateTime.now().day.toString() + " de " + DateTime.now().month.toString();
                    String horaDoIncidente = DateTime.now().toUtc().toLocal().hour.toString() + "h" + DateTime.now().minute.toString() + "min";
                    //db.collection("Incidentes").doc(nomeDoCulto).update({horaDoIncidente : incidentes});
                    adicionarIncidente(incidentes,nomeDoCulto,horaDoIncidente);

                    setState(() {
                      if(ativo == false) {}
                      else if (ativo == true) {ativo = !ativo;}
                    });
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
      )
    );
  }

  void adicionarIncidente(String incidente, String nomeCulto, String hrIncid) async {
    final docRef = db.collection("Incidentes").doc(nomeCulto);
    final doc = await docRef.get();
    if(doc.exists) {
      docRef.update({hrIncid : incidente});
    } else {
      docRef.set({hrIncid : incidente});
    }
  }
}