import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  void _openPrivacyPolicy() async {
    const url = 'https://www.google.com.br';
    final Uri toLaunch =
    Uri(scheme: 'https', host: 'www.google.com.br');

    if (await canLaunchUrl(toLaunch)) {
      await launchUrl(toLaunch);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openPrivacyPolicy,
      child: const Text(
        'Política de Privacidade',
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }
}
