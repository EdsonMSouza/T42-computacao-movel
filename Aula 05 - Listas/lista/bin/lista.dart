// Listas em Dart - é uma estrutura de dados que guarda os dados
// de forma sequencial na memória. É parecido com vetores.
import 'dart:io';

void main(List<String> arguments) {
  // criando uma lista de produtos
  // <> esse par é conhecido como diamond
  var produtos = <String>['Cenoura', 'Banana', 'Brócolis', 'Batata', 'Maçã'];

  // mostrando os elementos
  print(produtos);

  // acessando elementos pelo índice
  print(produtos[0]); // Cenoura
  print(produtos[3]); // Batata

  // adicionar elementos na lista (no final)
  produtos.add('Alface');
  print(produtos);

  // removendo elementos
  produtos.remove('Banana');
  print(produtos);

  // removendo pelo índice
  produtos.removeAt(0);
  print(produtos);

  // verificando o tamanho da lista
  var tam = produtos.length;
  print('A lista tem $tam produtos.');

  // pesquisar uma ocorrência
  if (produtos.contains('Doritos')) {
    print('Tem Doritos');
  } else {
    print('Não tem Doritos, então coloca na lista.');
    produtos.add('Doritos');
    print(produtos);
  }

  // Treinando.....
  // Adicionar mais cinco produtos na lista e, usando um laço for(),
  // apresentar os produtos um embaixo do outro.
  // Tempo: 13 minutos (20:15)
  produtos..add('Beterraba')..add('Goiaba')..add('Laranja')..add('Tangerina');

  // percorrer a lista com um for() - Primeira forma
  for (var i = 0; i < produtos.length; i++) {
    print('Item ${i + 1} => ${produtos[i]}'); // acessando pelo índice
  }

  // Percorrendo com foreach
  for (var produto in produtos) {
    print(produto);
  }

  // Usando mapeamento
  // print(produtos.map((e) => (e))); // Tupla ou série
  // Saída: (Brócolis, Batata, Maçã, Alface, Doritos, Beterraba, Goiaba, Laranja, Tangerina)

  print('');
  // Ordenação de listas
  var crescente = produtos..sort();
  for (var p in crescente) {
    print(p);
  }
  print('');
  // Decrescente
  var decrescente = crescente.reversed;
  for (var p in decrescente) {
    print(p);
  }

  var experiencia = <String>['Carro', 'Moto', 'Bicicleta'];
  print(experiencia);
  print(experiencia.reversed);

  var nomes = <String>[
    'Edson Melo',
    'edson da silva',
    'Ana Maria',
    'ana Claudia'
  ];
  var asc = nomes..sort();
  var desc = asc.reversed;
  print(asc);
  print(desc);

  // Transformar em lista a seguinte frase:
  var n1 = 'O Edson é bonitão, #SQN, a mãe dele acha, tadinha!'.split(' ');
  var lista = <String>[];
  for (var l in n1) {
    lista.add(l);
  }
  print(lista);

  // Leitura do teclado
  // var entrada = stdin.readLineSync();
  // print(entrada);

  // Trabalhando com objetos
  var alunos = <Aluno>[];
  alunos.add(Aluno(ra: 123, nome: 'Edson'));
  alunos.add(Aluno(ra: 456, nome: 'Tio Patinhas'));

  // Mostrando objetos dentro da lista
  for (var aluno in alunos) {
    print(aluno.nome);
  }
  print('');

  // Removendo objeto
  alunos.removeWhere((Aluno a) => a.nome == 'Edson');

  // Atualizar objetos (pelo índice)
  alunos[0].nome = 'Caravana do Gugu';
  for (var aluno in alunos) {
    print(aluno.nome);
  }

  // outra forma de atualizar pelo índice (quando não sei o índice)
  alunos[alunos.indexWhere((Aluno a) => a.nome == 'Caravana do Gugu')].nome =
      'Domingo Legal';
  for (var aluno in alunos) {
    print(aluno.nome);
  }
}

class Aluno {
  int ra;
  String nome;

  Aluno({this.ra, this.nome});
}
