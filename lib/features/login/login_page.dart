import 'package:flutter/material.dart';
import '/data/database_helper.dart';
import '../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final Color verdeEscuro = const Color(0xFF356B33);

  void _tentarLogin() async {
    var user = await DatabaseHelper().login(_emailController.text, _senhaController.text);
    if (user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(userData: user)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email ou senha inválidos")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const SizedBox(height: 80),
            // Logo Simulada
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: verdeEscuro, width: 2),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.eco, color: verdeEscuro),
                  const SizedBox(width: 8),
                  Text("Égua da Feira", style: TextStyle(color: verdeEscuro, fontWeight: FontWeight.bold, fontSize: 22)),
                ],
              ),
            ),
            const SizedBox(height: 100),
            Text("Seja Bem-Vindo(a)!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: verdeEscuro)),
            const SizedBox(height: 20),
            Text("Encontre e venda produtos\nfrescos direto do campo", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: verdeEscuro.withOpacity(0.8))),
            const SizedBox(height: 50),
            TextField(
              controller: _emailController,
              decoration: _inputStyle("Email"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: _inputStyle("Senha"),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: verdeEscuro, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                onPressed: _tentarLogin,
                child: const Text("ENTRAR", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            Text.rich(TextSpan(text: "Não tem conta? ", children: [TextSpan(text: "Cadastre-se", style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline))])),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: verdeEscuro.withOpacity(0.5)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: verdeEscuro.withOpacity(0.5))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: verdeEscuro, width: 2)),
    );
  }
}