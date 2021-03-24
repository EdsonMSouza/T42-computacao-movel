import 'Operacoes.dart';

void main(List<String> args) {
  var op = Operacoes();
  var v1 = 2;
  var v2 = 3;

  print(op.somar(v1, v2)); // 5
  print(op.multiplicar(v1, v2)); // 6
  print(op.potencia(v1, v2)); //8
  print(op.isPar(v1)); // true
  print(op.isPar(v2)); // false
}
