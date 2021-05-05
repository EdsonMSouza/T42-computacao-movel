import 'package:flutter/material.dart';
import 'package:tarefas_ter_noite/temas/temas.dart';
import 'package:tarefas_ter_noite/telas/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Lista de tarefas',
    //home: Home(),
    themeMode: ThemeMode.system, // tema atual do smartphone
    theme: lightTheme(),
    darkTheme: darkTheme(),
  ));
}
