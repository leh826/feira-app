import 'package:flutter/material.dart';
import '/data/database_helper.dart';
import '../../../main.dart';
import '../../core/utils/validators.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final Color verdeEscuro = const Color(0xFF356B33);

  // Controllers para todos os campos do banco
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController = TextEditingController();
  final TextEditingController _regiaoController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> novoUsuario = {
        'nome': _nomeController.text,
        'email': _emailController.text,
        'senha': _senhaController.text,
        'regiao': _regiaoController.text,
        'cidade': _cidadeController.text,
        'bairro': _bairroController.text,
        'numero': _numeroController.text,
      };

      int id = await DatabaseHelper().registerUser(novoUsuario);

      if (id > 0) {
        // Após cadastrar, já logamos o usuário automaticamente
        novoUsuario['id'] = id; 
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Conta criada com sucesso!")));
          Navigator.pushAndRemoveUntil(
            context, 
            MaterialPageRoute(builder: (context) => MainPage(userData: novoUsuario)),
            (route) => false
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF0),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: IconThemeData(color: verdeEscuro)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Crie sua Conta", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: verdeEscuro)),
              const SizedBox(height: 30),
              
              TextFormField(
                controller: _nomeController,
                decoration: _inputStyle("Nome Completo *"),
                validator: AppValidators.campoObrigatorio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _emailController,
                decoration: _inputStyle("Email *"),
                keyboardType: TextInputType.emailAddress,
                validator: AppValidators.validarEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      decoration: _inputStyle("Senha *"),
                      validator: AppValidators.campoObrigatorio,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _confirmaSenhaController,
                      obscureText: true,
                      decoration: _inputStyle("Confirmar Senha *"),
                      validator: (value) => AppValidators.confirmarSenha(value, _senhaController.text),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: _cidadeController,
                decoration: _inputStyle("Cidade *"),
                validator: AppValidators.campoObrigatorio,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15),

              // Campos Opcionais
              Row(
                children: [
                  Expanded(child: TextFormField(controller: _regiaoController, decoration: _inputStyle("Região"))),
                  const SizedBox(width: 10),
                  Expanded(child: TextFormField(controller: _bairroController, decoration: _inputStyle("Bairro"))),
                ],
              ),
              const SizedBox(height: 15),

              TextFormField(controller: _numeroController, decoration: _inputStyle("Número / Complemento")),

              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: verdeEscuro, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  onPressed: _cadastrar,
                  child: const Text("CADASTRAR", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: verdeEscuro.withOpacity(0.5), fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: verdeEscuro.withOpacity(0.3))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: verdeEscuro, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.red, width: 1)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.red, width: 2)),
    );
  }
}