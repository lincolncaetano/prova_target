import 'package:flutter/material.dart';
import 'package:prova_target/views/informacoes_page.dart';
import 'package:prova_target/views/widget/privacy_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();



  static void errorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(message),
          duration: Duration(seconds: 2),
        )
    );
  }

  void _login() {

    String login = loginController.text.trim();
    String senha = senhaController.text.trim();

    if(login.isEmpty || senha.isEmpty){
      errorMessage(context, 'Login e senha são de preenchimento obrigatório');
    } else if(senha.length < 2){
      errorMessage(context, 'O campo SENHA deve conter mais de 2 caracteres');
    } else if(senha.contains(RegExp(r'[^\w]'))){
      errorMessage(context, 'O campo SENHA não pode ter caracteres especiais');
    }

    if (login.isNotEmpty &&
        senha.isNotEmpty &&
        senha.length >= 2 &&
        !senha.contains(RegExp(r'[^\w]')) &&
        login.length <= 20 &&
        senha.length <= 20 &&
        !login.endsWith(' ') &&
        !senha.endsWith(' ')) {
      // Lógica para ir para a próxima tela

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InformacoesPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1e4e62),
              Color(0xFF2d958e),
            ], // Cores do gradiente
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Login", style: TextStyle(color: Colors.white),),
                        TextField(
                          controller: loginController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              counterText: ""
                          ),
                          maxLength: 20,
                        ),
                        const SizedBox(height: 16.0),
                        const Text("Senha", style: TextStyle(color: Colors.white)),
                        TextField(
                          controller: senhaController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              counterText: ""
                          ),
                          maxLength: 20,
                          obscureText: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom( backgroundColor: const Color(0xFF44bd6e), minimumSize: Size(200, 45)),
                      onPressed: _login,
                      child: const Text('Entrar', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Privacy(),
            ),
          ],
        ),
      ),
    );
  }
}

