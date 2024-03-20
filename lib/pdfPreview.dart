

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Pdfpreview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: PdfPreview(
          build: (context) => criarPDF(),
      ),
    );
  }

  FutureOr<Uint8List> criarPDF() async {
    final pdf = pw.Document();

    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = await db.collection("criancas").get();
    final data2 = await db.collection("Incidentes").doc("Culto do dia " + DateTime.now().day.toString() + " de " + DateTime.now().month.toString()).get();
    var listaP = <String>[];
    var listaA = <String>[];
    var listaInc = <String>[];
    int contIncidentes = 0;
    int contPresentes = 0;
    int contAusentes = 0;

    print(data2.data()!.values);


    for (var element in data.docs) {
      if (element.get("checkado") == true) {
        contPresentes++;
        listaP.add(contPresentes.toString() + ". " + element.id.toString() + ", filho de: " + element.get("mãe").toString());
      } else {
        contAusentes++;
        listaA.add(contAusentes.toString() + ". " + element.id.toString() + ", filho de: " + element.get("mãe").toString());
      }
    }

    for (var element in data2.data()!.values) {
      contIncidentes++;
      listaInc.add(contIncidentes.toString() + ") " + element.toString());
    }

    final logo = (await rootBundle.load('imagens/gps_logo_solo2.png')).buffer.asUint8List();
    final logoGPS = pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      buildBackground: (context) {
        return pw.FullPage(
          ignoreMargins: true,
          child: pw.Center(
            child: pw.Opacity(
              opacity: 0.3,
              child: pw.Image(
                pw.MemoryImage(
                  logo,
                ),
                alignment: pw.Alignment.topCenter,
              ),
            )
          ),
        );
      }
    );


    pdf.addPage(
        pw.Page(
            pageTheme: logoGPS,
            //margin: const pw.EdgeInsets.all(10),
            //pageFormat: PdfPageFormat.a4,
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

                    pw.Container(
                      margin: pw.EdgeInsets.only(left: -150),
                      padding: pw.EdgeInsets.only(top: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: criancasPresentes(listaP),
                      ),
                    )
                  ]
              );
            }
        )
    );

    pdf.addPage(
        pw.Page(
          pageTheme: logoGPS,
            //margin: const pw.EdgeInsets.all(10),
            //pageFormat: PdfPageFormat.a4,
            build: (context) {
              return pw.Column(
                  children: [
                    pw.Text(
                        "Lista de Crianças Ausentes",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 30,
                        )
                    ),

                    pw.Container(
                      margin: pw.EdgeInsets.only(left: -150),
                      padding: pw.EdgeInsets.only(top: 20),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: criancasAusentes(listaA),
                      ),
                    )
                  ]
              );
            }
        )
    );

    pdf.addPage(
      pw.Page(
        pageTheme: logoGPS,
        build: (context) {
          return pw.Column(
              children: [
                pw.Text(
                    "Lista de Incidentes Registrados",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 30,
                    )
                ),

                pw.Container(
                  margin: pw.EdgeInsets.only(left: -150),
                  padding: pw.EdgeInsets.only(top: 20),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: incidentesRegistrados(listaInc),
                  ),
                )
              ]
          );
        }
      ),
    );

    checkOut();
    return pdf.save();
  }


  List<pw.Text> incidentesRegistrados(List<String> lista) {
    //FirebaseFirestore db = FirebaseFirestore.instance;
    //final data = await db.collection("criancas").get();
    var listaInc = <pw.Text>[];
    //int contPresentes = 0;


    for (var element in lista) {
      listaInc.add(
        pw.Text(
          element.toString(),
        ),
      );
    }
    return listaInc;
  }

  List<pw.Text> criancasPresentes(List<String> lista) {
    //FirebaseFirestore db = FirebaseFirestore.instance;
    //final data = await db.collection("criancas").get();
    var listaP = <pw.Text>[];
    //int contPresentes = 0;


    for (var element in lista) {
      listaP.add(
        pw.Text(
          element.toString(),
        ),
      );
    }
    return listaP;
  }

  List<pw.Text> criancasAusentes(List<String> lista) {
    var listaA = <pw.Text>[];

    for (var element in lista) {
      listaA.add(
        pw.Text(
          element.toString(),
        ),
      );
    }

    return listaA;
  }

  void checkOut() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference criancas = db.collection('criancas');;

    final data1 = await criancas.get();

    for (var element in data1.docs) {
      if (element.get("checkado") == true) {
        criancas.doc(element.id).update({"checkado" : false});
      }
    }
  }
}