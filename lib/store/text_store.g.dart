// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TextStore on _TextStore, Store {
  late final _$textAtom = Atom(name: '_TextStore.text', context: context);

  @override
  ObservableList<String> get text {
    _$textAtom.reportRead();
    return super.text;
  }

  @override
  set text(ObservableList<String> value) {
    _$textAtom.reportWrite(value, super.text, () {
      super.text = value;
    });
  }

  late final _$_TextStoreActionController =
      ActionController(name: '_TextStore', context: context);

  @override
  void addText(String newText) {
    final _$actionInfo =
        _$_TextStoreActionController.startAction(name: '_TextStore.addText');
    try {
      return super.addText(newText);
    } finally {
      _$_TextStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeText(int index) {
    final _$actionInfo =
        _$_TextStoreActionController.startAction(name: '_TextStore.removeText');
    try {
      return super.removeText(index);
    } finally {
      _$_TextStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editText(int index, String newText) {
    final _$actionInfo =
        _$_TextStoreActionController.startAction(name: '_TextStore.editText');
    try {
      return super.editText(index, newText);
    } finally {
      _$_TextStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
text: ${text}
    ''';
  }
}
