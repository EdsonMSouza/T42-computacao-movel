import 'dart:math';

class Operacoes {
  /// Este método soma dois números informados
  ///
  /// parâmetros: dynamic num1 e dynamic num2
  ///
  /// retorno: dynamic
  ///
  /// Ex.: somar(10, 20)
  dynamic somar(dynamic v1, dynamic v2) {
    return v1 + v2;
  }

  dynamic multiplicar(dynamic v1, dynamic v2) {
    return v1 * v2;
  }

  /// Base é o valor que será utilizado bla bla
  dynamic potencia(var base, var expoente) {
    return pow(base, expoente);
  }

  /// Retorna se um número é par ou ímpar
  ///
  /// return: bool
  bool isPar(int valor) {
    return (valor % 2 == 0);
  }
}
