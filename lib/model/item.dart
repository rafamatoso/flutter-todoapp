class Item {
  String title;
  bool done;

  /* Construtor default. Quando se passa os parâmetros entre chaves, o Dart reconhece automaticamente os atributos da classe,
     evitando a verbosidade que outras linguagens demonstram.*/
  Item({this.title, this.done});

  /* Para gerar os dois métodos abaixo, usar o conversor Json to Dart - https://javiercbk.github.io/json_to_dart/ */
  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;
    return data;
  }
}
