import 'package:flutter/material.dart';

// função main que retorna void
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App', // título da aplicação
      debugShowCheckedModeBanner:
          false, // Retira um elemento gráfico que fica na tela do celular
      theme: ThemeData(
        primarySwatch: Colors.indigo, // primarySwatch: paleta de cores
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Renderiza um AppBar na página
        leading: Icon(Icons.question_answer),
        title: Text("ToDo List"),
        actions: <Widget>[
          Icon(Icons.plus_one), // Renderiza um ícone de coma na AppBar
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Olá mundo!"),
        ),
      ),
    );
  }
}
