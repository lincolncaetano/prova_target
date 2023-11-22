import 'package:flutter/material.dart';
import 'package:prova_target/store/text_store.dart';
import 'package:prova_target/views/widget/privacy_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class InformacoesPage extends StatefulWidget {
  const InformacoesPage({super.key});

  @override
  State<InformacoesPage> createState() => _InformacoesPageState();
}

class _InformacoesPageState extends State<InformacoesPage> {

  final TextEditingController textController = TextEditingController();
  int? editingIndex;
  final TextStore textStore = TextStore();
  final ScrollController _scrollController = ScrollController();
  late SharedPreferences prefs;
  final FocusNode _textFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    loadText();

    _scrollController.addListener(() {
      _textFocus.requestFocus();
    });
  }

  Future<void> loadText() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? savedTextList = prefs.getStringList('textList');
    if (savedTextList != null) {
      textStore.addList(savedTextList);
    }
  }

  void _saveText(String newText) async {
    if (newText.isNotEmpty) {
      if (editingIndex != null) {
        textStore.editText(editingIndex!, newText);
        setState(() {
          editingIndex = null;
        });
      } else {
        textStore.addText(newText);

        _scrollController.animateTo(
          _scrollController.position.extentTotal + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );

      }
      prefs.setStringList('textList', textStore.text);
      textController.clear();
    }

    _textFocus.requestFocus();
  }

  void _showConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente excluir este item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _textFocus.requestFocus();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                textStore.removeText(index);
                prefs.setStringList('textList', textStore.text);
                Navigator.of(context).pop();
                _textFocus.requestFocus();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  void _startEditing(int index) {
    setState(() {
      editingIndex = index;
      textController.text = textStore.text[index];
      _textFocus.requestFocus();
    });
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Card(
                        child: Observer(
                          builder: (context) {
                            return ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: textStore.text.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                        width: 0.4,
                                      ),
                                    ),
                                  ),
                                  child: ListTile(
                                    title: GestureDetector(
                                      onTap: (){
                                        _textFocus.requestFocus();
                                      },
                                      child: Text(
                                        textStore.text[index],
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            _startEditing(index);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.close, color: Colors.red),
                                          onPressed: () {
                                            _showConfirmationDialog(context, index);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: textController,
                      decoration: const InputDecoration(hintText: 'Digite seu texto'),
                      textAlign: TextAlign.center,
                      autofocus: true,
                      focusNode: _textFocus,
                      onSubmitted: (text) {
                        _saveText(text);
                      },
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
