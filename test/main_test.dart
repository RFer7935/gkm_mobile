import 'package:flutter_test/flutter_test.dart';

// Mock Item model for testing
class Item {
  String id;
  String name;

  Item({required this.id, required this.name});
}

void main() {
  group('CRUD Operations Test', () {
    late List<Item> items;

    setUp(() {
      items = [];
    });

    test('Create - Should add new item to list', () {
      // Create operation
      items.add(Item(id: '1', name: 'Test Item'));

      expect(items.length, 1);
      expect(items.first.name, 'Test Item');
    });

    test('Read - Should retrieve item from list', () {
      // Setup
      items.add(Item(id: '1', name: 'Test Item'));

      // Read operation
      Item? foundItem = items.firstWhere((item) => item.id == '1');

      expect(foundItem.name, 'Test Item');
    });

    test('Update - Should modify existing item', () {
      // Setup
      items.add(Item(id: '1', name: 'Test Item'));

      // Update operation
      int index = items.indexWhere((item) => item.id == '1');
      items[index] = Item(id: '1', name: 'Updated Item');

      expect(items[index].name, 'Updated Item');
    });

    test('Delete - Should remove item from list', () {
      // Setup
      items.add(Item(id: '1', name: 'Test Item'));

      // Delete operation
      items.removeWhere((item) => item.id == '1');

      expect(items.length, 0);
    });
  });
}
