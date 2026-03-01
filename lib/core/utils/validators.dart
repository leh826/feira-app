class AppValidators {
  // Valida se o campo está vazio
  static String? campoObrigatorio(String? value) {
    if (value == null || value.isEmpty) {
      return "Este campo é obrigatório";
    }
    return null;
  }

  // Valida o formato do e-mail usando Regex
  static String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "O e-mail é obrigatório";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return "Insira um e-mail válido";
    }
    return null;
  }

  //valida a confirmação da senha
  static String? confirmarSenha(String? value, String senhaOriginal) {
    if (value == null || value.isEmpty) {
      return "Confirme sua senha";
    }
    if (value != senhaOriginal) {
      return "As senhas não conferem";
    }
    return null;
  }
}