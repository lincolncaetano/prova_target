import 'package:mobx/mobx.dart';

part 'text_store.g.dart';

class TextStore = _TextStore with _$TextStore;

abstract class _TextStore with Store{
  @observable
  ObservableList<String> text = ObservableList<String>();

  @action
  void addList(List<String> lista) {
    text.addAll(lista);
  }

  @action
  void addText(String newText) {
    text.add(newText);
  }

  @action
  void removeText(int index) {
    text.removeAt(index);
  }

  @action
  void editText(int index, String newText) {
    text[index] = newText;
  }
}
