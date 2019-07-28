import 'package:flutter/material.dart';
import 'model/item.dart';

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

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    items.add(Item(title: "Item 1", done: false));
    items.add(Item(title: "Item 2", done: true));
    items.add(Item(title: "Item 3", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Renderiza um AppBar na página
      appBar: AppBar(
        title: Text("ToDo List"),
      ),
      // O método .builder() renderiza o ListView em tempo de execução, sobre demanda, dando mais eficiência e melhorando a performance do elemento
      body: ListView.builder(
        // O ListView acessará os itens de acordo com a quantidade contida nele próprio
        itemCount: widget.items.length,
        // Função que será responsável pela construção dos itens na tela (Como deve ser construido os itens? Como desenho? O que faço?)
        itemBuilder: (BuildContext context, int index) {
          // Retornará o texto na Tela da App
          return Text(widget.items[index].title);
        },
      ),
    );
  }
}
