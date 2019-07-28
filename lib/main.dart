import 'package:flutter/material.dart';
import 'model/item.dart';

// Função main que retorna void
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

// 6) Classe HomePage foi mudada de Stateless para Stateful pois teremos mudanças de estados variadas.
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
      // 6) O método .builder() renderiza o ListView em tempo de execução, sobre demanda, dando mais eficiência e melhorando a performance do elemento
      body: ListView.builder(
        // 6) O ListView acessará os itens de acordo com a quantidade contida nele próprio
        itemCount: widget.items.length,
        // 6) Função que será responsável pela construção dos itens na tela (Como deve ser construido os itens? Como desenho? O que faço?)
        itemBuilder: (BuildContext context, int index) {
          // 7) Criado para desestruturar a chamada direto no return, dessa forma poderemos chamar a variável item por toda a app
          final item = widget.items[index];
          // 6) Retornará o texto na Tela da App
          return CheckboxListTile(
            // 7) Mostra o título
            title: Text(item.title),
            // 7) Tem que apresentar uma chave única
            key: Key(item.title),
            // 7) Um booleano, true ou false
            value: item.done,
            // 7) Ao clicar, mudará valor
            onChanged: (value) {
              // 7) Semelhante ao console.log() do js
              print(value);
            },
          );
        },
      ),
    );
  }
}
