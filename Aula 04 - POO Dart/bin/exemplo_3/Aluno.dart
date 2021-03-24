class Aluno {
  // encapsulamento em Dart e construtor
  // o underline coloque o atributo como private
  String _nome;
  int _idade;

  // constructor
  Aluno(String nome, {int idade}) {
    _nome = nome;
    _idade = idade;
  }

  // getters and setters
  String get nome => _nome;
  set nome(value) => _nome = value;

  int get idade => _idade;
  set idade(value) => _idade = value;
}
