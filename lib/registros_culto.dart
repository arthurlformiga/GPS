import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Registros extends StatelessWidget {
  //const Registros({Key? key, required this.titulo}) : super(key: key);
  //final String titulo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(150, 132, 64, 166),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(150, 132, 64, 120),
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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  backgroundColor: Color.fromARGB(150, 132, 64, 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/checkin');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_box,
                    size: 30,
                    color: Color.fromARGB(255, 254, 169, 1),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Text(
                      'Realizar Check-in',
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
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  backgroundColor: Color.fromARGB(150, 132, 64, 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add_alert,
                    size: 30,
                    color: Color.fromARGB(255, 254, 169, 1),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Text(
                      'Solicitar apoio do \nresponsável',
                      maxLines: 2,
                      softWrap: true,
                      style: TextStyle(
                        height: 1,
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
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  backgroundColor: Color.fromARGB(150, 132, 64, 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, '/relatarIncidente');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.report,
                    size: 30,
                    color: Color.fromARGB(255, 254, 169, 1),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Text(
                      'Relatar Incidente',
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
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  backgroundColor: Color.fromARGB(150, 132, 64, 120),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: () async {
                Navigator.pushNamed(context, '/criarPDF');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.close,
                    size: 30,
                    color: Color.fromARGB(255, 254, 169, 1),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: const Text(
                      'Finalizar Culto',
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
        ],
      ),
    );
  }

  criarPDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
          margin: const pw.EdgeInsets.all(10),
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return pw.Column(
              children: [
                pw.Text(
                  "Lista de Crianças Presentes",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 30,
                  )
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 20),
                  child: pw.Column(
                    children: criancasPresentes(),
                  ),
                )
              ]
            );
          }
      )
    );
  }

  criancasPresentes() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = await db.collection("criancas").get();
    var listaP = <pw.Text>[];
    int contPresentes = 0;


    for (var element in data.docs) {
      if (element.get("checkado") == true) {
        contPresentes++;
        listaP.add(
          pw.Text(
              element.id.toString() + ", filho de: " + element.get("mae").toString()
          ),
        );
      }
    }
    return listaP;
  }

  criancasAusentes() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = await db.collection("criancas").get();
    var listaA = <pw.Text>[];
    int contAusentes = 0;

    for (var element in data.docs) {
      if (element.get("checkado") == false) {
        contAusentes++;
        listaA.add(
          pw.Text(
            contAusentes.toString() + ". " + element.id.toString() + ", filho de: " + element.get("mae").toString(),
          ),
        );

      }
    }

    return listaA;
  }
}