import 'dart:convert'; // manipular json
import 'dart:io'; // manipular arquivos
import 'package:flutter/cupertino.dart'; // icons Apple
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // armazenamento local

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = []; // lista de tarefas
  final _toDoController = TextEditingController();
  int _indexLastRemoved; // guarda o índice do último registro removido
  Map<String, dynamic> _lastRemoved; // guarda o último registro removido

  // ### vamos implementar a lógica ###
  // carrega os dados do arquivo ao mudar o estado da classe
  @override
  void initState() {
    super.initState();
    _lerDados().then((value) {
      setState(() {
        _toDoList = json.decode(value);
      });
    });
  }

  // "async" - determina que um método será assíncrono,
  // não retornar imediatamente um valor.
  // "await" - determina que o aplicativo aguarde um retorno (resposta)
  // "Future" - determina que uma função vai retornar algo no futuro
  Future<String> _lerDados() async {
    try {
      final arquivo = await _abreArquivo();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  Future<File> _abreArquivo() async {
    // Se não existir o arquivo, será criado
    final diretorio = await getApplicationDocumentsDirectory();
    return File("${diretorio.path}/dados.json");
  }

  Future<Null> _recarregaLista() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _toDoList.sort((a, b) {
        if (a['realizado'] && !b['realizado']) return 1;
        if (!a['realizado'] && b['realizado']) return -1;
        return 0;
      });
      _salvarDados();
    });
    return null;
  }

  Future<File> _salvarDados() async {
    String dados = json.encode(_toDoList);
    final arquivo = await _abreArquivo();
    return arquivo.writeAsString(dados);
  }

  // método para adicionar as tarefas
  void _adicionaTarefa() {
    setState(() {
      Map<String, dynamic> novaTarefa = Map();
      novaTarefa['titulo'] = _toDoController.text;
      novaTarefa['realizado'] = false; // (-1)
      _toDoController.text = '';
      _toDoList.add(novaTarefa);
      _salvarDados();
    });
  }

  Widget widgetTarefa(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red, // cor do fundo quando apagar a mensagem
        child: Align(
          alignment: Alignment(0.85, 0.0),
          child: Icon(
            Icons.delete_sweep_outlined,
            color: Colors.white,
          ),
        ),
      ),
      // definindo a direção do objeto para apagar
      direction: DismissDirection.endToStart,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["titulo"]),
        value: _toDoList[index]["realizado"],
        secondary: CircleAvatar(
          child: Icon(
            _toDoList[index]["realizado"] ? Icons.check : Icons.error,
            color: Theme.of(context).iconTheme.color,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onChanged: (value) {
          setState(() {
            _toDoList[index]["realizado"] = value;
            _salvarDados();
          });
        },
        checkColor: Theme.of(context).primaryColor,
        activeColor: Theme.of(context).secondaryHeaderColor,
      ), // até aqui controlamos o estado da lista
      // fazendo uma exclusão dentro de um determinado tempo
      onDismissed: (direction) {
        setState(() {
          // guarda o valor do item da lista
          _lastRemoved = Map.from(_toDoList[index]);
          // guarda o índice da entrada
          _indexLastRemoved = index;
          _toDoList.removeAt(index);
          _salvarDados();
        });
        // ação de desfazer
        final snack = SnackBar(
          content: Text("Tarefa \"${_lastRemoved["titulo"]}\" apagada!"),
          action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _toDoList.insert(_indexLastRemoved, _lastRemoved);
                  _salvarDados();
                });
              }),
          duration: Duration(seconds: 5),
        );
        // configurar: mostrar/esconder o desfazer
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _toDoController,
                    maxLength: 50,
                    decoration: InputDecoration(labelText: "Nova tarefa"),
                  )),
                  Container(
                    height: 45.0,
                    width: 45.0,
                    child: FloatingActionButton(
                      child: Icon(Icons.save),
                      onPressed: () {
                        if (_toDoController.text.isEmpty) {
                          final alerta = SnackBar(
                            content: Text('Não pode ser vazia!'),
                            duration: Duration(seconds: 4),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                //Scaffold.of(context).removeCurrentSnackBar();
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                              },
                            ),
                          );

                          //Scaffold.of(context).removeCurrentSnackBar();
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                          //Scaffold.of(context).showSnackBar(alerta);
                          ScaffoldMessenger.of(context).showSnackBar(alerta);
                        } else {
                          _adicionaTarefa();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(padding: (EdgeInsets.only(top: 10.0))),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _recarregaLista,
                child: ListView.builder(
                  itemBuilder: widgetTarefa,
                  itemCount: _toDoList.length,
                  padding: EdgeInsets.only(top: 10.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
