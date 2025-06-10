import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements DatabaseRepository {
  final SharedPreferences _prefs;

  SharedPreferencesRepository(this._prefs);

  static const String _key = 'items';

  @override
  Future<void> addItem(String item) async {
    final items = await getItems();
    items.add(item);
    await _prefs.setStringList(_key, items);
  }

  @override
  Future<void> deleteItem(int index) async {
    final items = await getItems();
    items.removeAt(index);
    await _prefs.setStringList(_key, items);
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    final items = await getItems();
    if (index >= 0 && index < items.length) {
      items[index] = newItem;
      await _prefs.setStringList(_key, items);
    }
  }

  @override
  Future<int> getItemCount() async {
    final items = await getItems();
    return items.length;
  }

   @override
  Future<List<String>> getItems() async {
    return _prefs.getStringList(_key) ?? [];
  }
  
}