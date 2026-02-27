import 'package:flutter/material.dart';
import '../../data/database_helper.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfilePage({super.key, required this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editando = false;
  final Color verde = const Color(0xFF5C7F5C);

  // Controllers para todos os campos
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _regiaoController;
  late TextEditingController _cidadeController;
  late TextEditingController _bairroController;
  late TextEditingController _numeroController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.userData['nome']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _regiaoController = TextEditingController(text: widget.userData['regiao']);
    _cidadeController = TextEditingController(text: widget.userData['cidade']);
    _bairroController = TextEditingController(text: widget.userData['bairro']);
    _numeroController = TextEditingController(text: widget.userData['numero']);
  }

  // Função para salvar no Banco de Dados
  Future<void> _salvarDados() async {
    Map<String, dynamic> usuarioAtualizado = {
      'id': widget.userData['id'],
      'nome': _nomeController.text,
      'email': _emailController.text,
      'regiao': _regiaoController.text,
      'cidade': _cidadeController.text,
      'bairro': _bairroController.text,
      'numero': _numeroController.text,
      'senha': widget.userData['senha'],
    };

    await DatabaseHelper().updateUser(usuarioAtualizado);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dados salvos no banco com sucesso!")),
      );
    }
  }

  InputDecoration campo(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: verde),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: verde.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: verde, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Meu Perfil", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(controller: _nomeController, enabled: editando, decoration: campo("Nome")),
            const SizedBox(height: 15),
            TextFormField(controller: _emailController, enabled: editando, decoration: campo("Email")),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(child: TextFormField(controller: _regiaoController, enabled: editando, decoration: campo("Região"))),
                const SizedBox(width: 10),
                Expanded(child: TextFormField(controller: _cidadeController, enabled: editando, decoration: campo("Cidade"))),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(flex: 2, child: TextFormField(controller: _bairroController, enabled: editando, decoration: campo("Bairro"))),
                const SizedBox(width: 10),
                Expanded(child: TextFormField(controller: _numeroController, enabled: editando, decoration: campo("Nº"))),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: editando ? Colors.orange : verde,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  if (editando) {
                    await _salvarDados();
                  }
                  setState(() {
                    editando = !editando;
                  });
                },
                child: Text(
                  editando ? "SALVAR ALTERAÇÕES" : "EDITAR PERFIL",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}