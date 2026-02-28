import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '/data/database_helper.dart';
import '../../../main.dart';
import '../../core/utils/validators.dart';
import '../cadastro/cadastro_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Chave para controlar o formulário e as validações
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final Color verdeEscuro = const Color(0xFF356B33);

  void _tentarLogin() async {
    // Valida todos os campos do formulário de uma vez
    if (_formKey.currentState!.validate()) {
      var user = await DatabaseHelper().login(_emailController.text, _senhaController.text);
      if (user != null) {
        if (mounted) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(userData: user)));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Email ou senha inválidos")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 80),
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

              TextFormField(
                controller: _emailController,
                decoration: _inputStyle("Email"),
                keyboardType: TextInputType.emailAddress,
                validator: AppValidators.validarEmail, // VALIDAÇÃO REUTILIZÁVEL
                autovalidateMode: AutovalidateMode.onUserInteraction, // FAZ O ERRO SUMIR AO DIGITAR
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: _inputStyle("Senha"),
                validator: AppValidators.campoObrigatorio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
              Text.rich(
                TextSpan(
                  text: "Não tem conta? ",
                  style: TextStyle(color: verdeEscuro.withOpacity(0.8)),
                  children: [
                    TextSpan(
                      text: "Cadastre-se",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: verdeEscuro,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CadastroPage()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.red, width: 1)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.red, width: 2)),
    );
  }
}