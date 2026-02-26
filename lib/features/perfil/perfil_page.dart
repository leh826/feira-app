import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool editando = false;
  bool mostrarSenha = false;
  bool mostrarConfirmarSenha = false;

  bool hoverEditar = false;
  bool hoverConfirmar = false;

  
    final Color verde = const Color(0xFF5C7F5C);

    InputDecoration campo(String label, {Widget? suffix}) {
      return InputDecoration(
        labelText: label,
        suffixIcon: suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: verde),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: verde, width: 2),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
      toolbarHeight: 90,
      centerTitle: true,
      title: const Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        "Perfil",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 20),

              TextFormField(
                enabled: editando,
                decoration: campo("Nome e Sobrenome"),
              ),

              const SizedBox(height: 20),

              TextFormField(enabled: editando, decoration: campo("Email")),

              const SizedBox(height: 20),

              TextFormField(
                enabled: editando,
                obscureText: !mostrarSenha,
                decoration: campo(
                  "Criar nova senha",
                  suffix: IconButton(
                    icon: Icon(
                      mostrarSenha ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        mostrarSenha = !mostrarSenha;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                enabled: editando,
                obscureText: !mostrarConfirmarSenha,
                decoration: campo(
                  "Confirmar nova senha",
                  suffix: IconButton(
                    icon: Icon(
                      mostrarConfirmarSenha
                      ? Icons.visibility_off
                      : Icons.visibility,
                    ),
                    onPressed: (){
                      setState(() {
                        mostrarConfirmarSenha =
                        !mostrarConfirmarSenha;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              editando
                  ? MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          hoverConfirmar = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          hoverConfirmar = false;
                        });
                      },
                      child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: hoverConfirmar ? Colors.white : verde,
                        backgroundColor:
                            hoverConfirmar ? verde : Colors.transparent,
                        side: BorderSide(color: verde, width: 2), // borda verde
                        elevation: 0, // remove sombra padrão
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                          onPressed: () {
                          setState(() {
                            editando = false;
                          });
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Edição confirmada"),
                            ),
                          );
                        },
                        child: const Text("Confirmar edição"),
                      ),
                    )
                  : MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          hoverEditar = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          hoverEditar = false;
                        });
                      },
                      child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: hoverEditar ? Colors.white : verde,
                        backgroundColor: hoverEditar ? verde : Colors.transparent,
                        side: BorderSide(color: verde, width: 2), // ← borda verde aqui
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                        onPressed: () {
                          setState(() {
                            editando = true;
                          });
                        },
                        child: const Text("Editar"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
