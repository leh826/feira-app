import 'package:eguadafeira/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '/data/database_helper.dart';
import '../../../main.dart';
import '../../core/utils/validators.dart';
import '../../widgets/custom_password_field.dart';

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
      
      bool jaExiste = await DatabaseHelper().emailJaCadastrado(_emailController.text);

      if (jaExiste) {
        if (mounted) {
          _showErrorDialog(
            "E-mail já cadastrado",
            "Este e-mail já está em uso. Por favor, faça login ou use outro e-mail."
          );
        }
        return;
      }

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
        if (mounted) {
          _showSuccessDialog();
        }
      }
    }
  }

  void _showErrorDialog(String titulo, String mensagem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(titulo, style: TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.bold)),
        content: Text(mensagem),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("TENTAR OUTRO"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: verdeEscuro),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("FAZER LOGIN", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
                const SizedBox(height: 16),
                Text(
                  "Conta Criada!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: verdeEscuro),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Sua conta foi registrada com sucesso. Você será redirecionado para efetuar o login.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: verdeEscuro,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "IR PARA LOGIN",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomPasswordField(
                      controller: _senhaController,
                      label: "Senha *",
                      themeColor: verdeEscuro,
                      validator: AppValidators.campoObrigatorio,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: CustomPasswordField(
                      controller: _confirmaSenhaController,
                      label: "Confirmar *",
                      themeColor: verdeEscuro,
                      validator: (value) => AppValidators.confirmarSenha(value, _senhaController.text),
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
      errorMaxLines: 2,
      errorStyle: const TextStyle(fontSize: 11, height: 0.9),
      labelStyle: TextStyle(color: verdeEscuro.withOpacity(0.5), fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: verdeEscuro.withOpacity(0.3))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide(color: verdeEscuro, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.red, width: 1)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.red, width: 2)),
    );
  }
}