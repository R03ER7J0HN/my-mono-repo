import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryEntity', () {
    group('colorValue', () {
      test('parses 6-character hex with # prefix', () {
        const category = CategoryEntity(
          id: '1',
          name: 'Food',
          iconCodePoint: 0xe532,
          colorHex: '#FF5733',
        );

        // #FF5733 -> 0xFFFF5733 (with alpha)
        expect(category.colorValue, 0xFFFF5733);
      });

      test('parses 6-character hex without # prefix', () {
        const category = CategoryEntity(
          id: '1',
          name: 'Food',
          iconCodePoint: 0xe532,
          colorHex: 'FF5733',
        );

        expect(category.colorValue, 0xFFFF5733);
      });

      test('parses 8-character hex with alpha', () {
        const category = CategoryEntity(
          id: '1',
          name: 'Food',
          iconCodePoint: 0xe532,
          colorHex: '#80FF5733',
        );

        expect(category.colorValue, 0x80FF5733);
      });

      test('parses 8-character hex without #', () {
        const category = CategoryEntity(
          id: '1',
          name: 'Food',
          iconCodePoint: 0xe532,
          colorHex: '80FF5733',
        );

        expect(category.colorValue, 0x80FF5733);
      });

      test('parses lowercase hex', () {
        const category = CategoryEntity(
          id: '1',
          name: 'Food',
          iconCodePoint: 0xe532,
          colorHex: '#ff5733',
        );

        expect(category.colorValue, 0xFFFF5733);
      });
    });

    group('equality', () {
      test('two categories with same values are equal', () {
        const category1 = CategoryEntity(
          id: '1',
          name: 'Food',
          iconCodePoint: 0xe532,
          colorHex: '#FF5733',
        );

        const category2 = CategoryEntity(
          id: '1',
          name: 'Food',
          iconCodePoint: 0xe532,
          colorHex: '#FF5733',
        );

        expect(category1, category2);
      });
    });
  });
}
