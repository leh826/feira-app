import 'package:flutter/material.dart';
import '../../widgets/custom_password_field.dart';
import '../../core/utils/validators.dart';
import '../../data/database_helper.dart';
import '../login/login_page.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  const ProfilePage({super.key, required this.userData});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editando = false;
  final Color verde = const Color(0xFF5C7F5C);
  final Color vermelho = const Color.fromARGB(255, 127, 92, 92);

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
    String novoEmail = _emailController.text.trim();

    String? erroEmail = AppValidators.validarEmail(novoEmail);
    if (erroEmail != null) {
      _resetarCampos();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(erroEmail)),
      );
      return;
    }

    bool emailExiste = await DatabaseHelper()
        .emailJaCadastrado(novoEmail, userId: widget.userData['id']);

    if (emailExiste) {
      _resetarCampos();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Este e-mail já está em uso por outro usuário."),
        ),
      );
      return;
    }

    Map<String, dynamic> usuarioAtualizado = {
      'id': widget.userData['id'],
      'nome': _nomeController.text,
      'email': novoEmail,
      'regiao': _regiaoController.text,
      'cidade': _cidadeController.text,
      'bairro': _bairroController.text,
      'numero': _numeroController.text,
      'senha': widget.userData['senha'],
    };

    await DatabaseHelper().updateUser(usuarioAtualizado);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dados salvos com sucesso!")),
      );
    }
  }

  void _resetarCampos() {
    setState(() {
      _nomeController.text = widget.userData['nome'];
      _emailController.text = widget.userData['email'];
      _regiaoController.text = widget.userData['regiao'];
      _cidadeController.text = widget.userData['cidade'];
      _bairroController.text = widget.userData['bairro'];
      _numeroController.text = widget.userData['numero'];
    });
  }

  void _fazerLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sair da conta"),
        content: const Text("Deseja realmente sair?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCELAR"),
          ),
          TextButton(
            onPressed: () {
              // Remove todas as telas e volta para o Login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
            child: const Text("SAIR", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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

            const SizedBox(height: 15),

            AbsorbPointer(
              absorbing: !editando,
              child: Opacity(
                opacity: editando ? 1.0 : 0.7,
                child: CustomPasswordField(
                  controller: TextEditingController(text: widget.userData['senha']),
                  label: "Sua Senha",
                  themeColor: verde,
                  validator: AppValidators.campoObrigatorio,
                ),
              ),
            ),

            //Ajuda
            ListTile(
              leading: Icon(Icons.help_outline, color: verde),
              title: const Text("Precisa de ajuda?"),
              subtitle: const Text("Veja como funciona seu perfil no Égua da Feira."),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Central de Ajuda", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: verde)),
                        
                        const SizedBox(height: 15),
                        
                        const Text(
                          "Como editar meu perfil?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2E5E2C),
                          ),
                        ),
                        const Text("• Clique no botão 'Editar Perfil', altere os campos e clique em 'Salvar'."),
                        
                        const SizedBox(height: 10),

                        const Text(
                          "Meus dados são seguros?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF2E5E2C),
                          ),
                        ),
                        const Text("• Sim, utilizamos criptografia local para proteger suas informações."),
                        
                        const SizedBox(height: 20),
                        
                        Center(
                          child: TextButton(onPressed: () => Navigator.pop(context), child: const Text("Entendi")),
                        )
                      ],
                    ),
                  ),
                );
              },
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
            
            const SizedBox(height: 15),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout, color: Colors.white, size: 20),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC65D5D), 
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _fazerLogout(),
                label: const Text(
                  "SAIR DA CONTA",
                  style: TextStyle(
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}