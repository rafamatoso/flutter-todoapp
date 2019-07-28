import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    // items.add(Item(title: "Banana", done: false));
    // items.add(Item(title: "Abacate", done: true));
    // items.add(Item(title: "Laranja", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 9) Variável que executa um método que controla um texto
  var newTaskController = TextEditingController();

  // 10) Método que adicionará um item na lista
  // 14) Toda vez que um item for adicionado, o método save() será usado
  void add() {
    // 10) Se não tiver texto, não executa o add
    if (newTaskController.text.isEmpty) return;

    setState(() {
      widget.items.add(
        Item(
          title: newTaskController.text,
          done: false,
        ),
      );
      // 10) Após adicionar um item, o texto escrito no form se apagará
      newTaskController.clear();
      save();
    });
  }

  // 10) Método que removerá um item da lista
  // 14) Toda vez que um item for removido, o método save() será usado
  void remove(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  // 13) Tudo que depende de um I/O não é em tempo real, ele depende do conceito de Promises (promessas)
  Future load() async {
    // O await funciona como um controlador de fila, onde ele pede para que algo espere até que outra coisa
    // seja executada, no caso o término do SharedPreferences.getInstance();
    var preferences = await SharedPreferences.getInstance();
    var data = preferences.getString('data');

    if (data != null) {
      // 13) Iterable é uma lista genérica que reeceberá um json
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      setState(() {
        widget.items = result;
      });
    }
  }

  // 14) Métodd que persistirá as informações no Shared Preferences
  save() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setString('data', jsonEncode(widget.items));
  }

  // 13) Após a criação do método load, devemos criar um construtor default e chamar o método load para ler os itens da lista
  _HomePageState() {
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Renderiza um AppBar na página
      appBar: AppBar(
        // 9) TextFormField = Caixa de entrada de texto
        title: TextFormField(
          // 9) O TextFormField terá um controlador de texto (value, clear e etc...)
          controller: newTaskController,
          // 9) Define qual o tipo de entrada o teclado do celular aceitará e mostrará (phone, email, text...)
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white, fontSize: 18),
          // 9) Mostra um testo decorativo no Form
          decoration: InputDecoration(
            labelText: "Nova Tarefa",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      // 6) O método .builder() renderiza o ListView em tempo de execução, sobre demanda, dando mais eficiência e melhorando a performance do elemento
      body: ListView.builder(
        // 6) O ListView acessará os itens de acordo com a quantidade contida nele próprio
        itemCount: widget.items.length,
        // 6) Função que será responsável pela construção dos itens na tela (Como deve ser construido os itens? Como desenho? O que faço?)
        itemBuilder: (BuildContext context, int index) {
          // 7) Criado para desestruturar a chamada direto no return, dessa forma poderemos chamar a variável item por toda a app
          final item = widget.items[index];
          // 11) Dismissible: Cria efeito de arrastar item para o lado
          return Dismissible(
            // 6) Retornará o texto na Tela da App
            child: CheckboxListTile(
              // 7) Mostra o título
              title: Text(item.title),
              // 7) Tem que apresentar uma chave única
              key: Key(item.title),
              // 7) Um booleano, true ou false
              value: item.done,
              // 7) Ao clicar, mudará valor
              onChanged: (value) {
                // 7) Semelhante ao console.log() do js
                // print(value);
                // 8) O setState realiza a operação de ouvir a mudança de estado e aplicá-la (programação reativa) só aonde aconteceu a mudança.
                // 14) Toda vez que um item for trocado, o método save() será usado
                setState(() {
                  item.done = value;
                  save();
                });
              },
            ),
            // 11) Dismissible também precisa de uma Key
            key: Key(item.title),
            // 11) Background quando o efeito do Dismissible estiver ativo
            background: Container(
              color: Colors.indigo.withOpacity(0.2),
            ),
            // Método que executará uma ação quando o Dismissible for executado
            onDismissed: (direction) {
              remove(index);
            },
          );
        },
      ),
      // 10) Adiciona botão flutuante na tela
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
