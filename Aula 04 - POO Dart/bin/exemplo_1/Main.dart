import 'Aluno.dart';

void main(List<String> args) {
  // instância
  var aluno = Aluno();
  aluno.nome = 'Edson';
  aluno.idade = 50;
  print('O aluno ${aluno.nome} tem ${aluno.idade} anos.');
  aluno.fazAniversario();
  print('O aluno ${aluno.nome} agora tem ${aluno.idade} anos.');
}
