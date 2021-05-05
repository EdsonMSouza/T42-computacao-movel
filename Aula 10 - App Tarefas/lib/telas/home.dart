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

  Widget widgetTarefa(BuildContext context, int index) {}

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
