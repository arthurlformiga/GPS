import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gps/cadastrar_criancas.dart';
import 'package:gps/cadastro_usuario.dart';
import 'package:gps/pdfPreview.dart';
import 'package:gps/registros_culto.dart';
import 'checkin.dart';
import 'home.dart';
import 'opcoes_voluntarios.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
    ? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDzX8di7O7Kwftx8mNBfPSF-rB0AUBkcAc',
          appId: '1:91323613285:android:a24002b137148f1eda868c',
          messagingSenderId: '91323613285',
          projectId: 'gps-flutter-android-ios'
      ))
    : await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDzX8di7O7Kwftx8mNBfPSF-rB0AUBkcAc',
          appId: '1:91323613285:android:a24002b137148f1eda868c',
          messagingSenderId: '91323613285',
          projectId: 'gps-flutter-android-ios'
      )
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'telaInicial',
      routes: Navigate.rotas,
      home: Home(), // Home()
    );
  }
}

class Navigate {
  static Map<String, Widget Function(BuildContext)> rotas =   {
    '/telaInicial' : (context) => Home(),
    '/opcoesVoluntarios' : (context) => OpcoesVoluntarios(),
    '/cadastroUsuario' : (context) => CadastroUsuario(),
    '/checkin' : (context) => Checkin(),
    '/cadastroCrianca' : (context) => CadastroCrianca(),
    '/registrosCulto' : (context) => Registros(),
    '/criarPDF' : (context) => Pdfpreview(),
  };
}


