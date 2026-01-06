import 'package:budget_core/budget_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_database_helper.dart';

void main() {
  late LocalDataSource dataSource;
  late CategoryRepositoryImpl repository;

  setUpAll(initializeTestDatabase);

  setUp(() async {
    final database = await createInMemoryDatabase();
    dataSource = LocalDataSource(database);
    repository = CategoryRepositoryImpl(dataSource);
  });

  tearDown(() async {
    await dataSource.database.close();
  });

  group('CategoryRepositoryImpl', () {
    group('save', () {
      test('saves a new category successfully', () async {
        const category = CategoryEntity(
          id: 'cat-1',
          name: 'Custom Category',
          iconCodePoint: 0xe000,
          colorHex: '#FF5733',
        );

        final result = await repository.save(category);

        expect(result.isSuccess, true);

        final getResult = await repository.getById('cat-1');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().name, 'Custom Category');
        expect(getResult.getSuccess().colorHex, '#FF5733');
      });

      test('updates existing category when id exists', () async {
        const category = CategoryEntity(
          id: 'cat-1',
          name: 'Original Name',
          iconCodePoint: 0xe000,
          colorHex: '#FF5733',
        );

        await repository.save(category);

        const updated = CategoryEntity(
          id: 'cat-1',
          name: 'Updated Name',
          iconCodePoint: 0xe001,
          colorHex: '#00FF00',
        );

        await repository.save(updated);

        final getResult = await repository.getById('cat-1');
        expect(getResult.getSuccess().name, 'Updated Name');
        expect(getResult.getSuccess().colorHex, '#00FF00');
      });

      test('saves system category', () async {
        const category = CategoryEntity(
          id: 'cat-sys',
          name: 'System Category',
          iconCodePoint: 0xe000,
          colorHex: '#FF5733',
          isSystem: true,
        );

        await repository.save(category);

        final getResult = await repository.getById('cat-sys');
        expect(getResult.isSuccess, true);
        expect(getResult.getSuccess().isSystem, true);
      });
    });

    group('delete', () {
      test('deletes a non-system category', () async {
        const category = CategoryEntity(
          id: 'cat-1',
          name: 'Custom Category',
          iconCodePoint: 0xe000,
          colorHex: '#FF5733',
        );

        await repository.save(category);
        final deleteResult = await repository.delete('cat-1');

        expect(deleteResult.isSuccess, true);

        final getResult = await repository.getById('cat-1');
        expect(getResult.isFailure, true);
      });

      test('fails to delete a system category', () async {
        const category = CategoryEntity(
          id: 'cat-sys',
          name: 'System Category',
          iconCodePoint: 0xe000,
          colorHex: '#FF5733',
          isSystem: true,
        );

        await repository.save(category);
        final deleteResult = await repository.delete('cat-sys');

        expect(deleteResult.isFailure, true);
        expect(
          deleteResult.getFailure().message,
          'Cannot delete system categories',
        );

        // Verify it still exists
        final getResult = await repository.getById('cat-sys');
        expect(getResult.isSuccess, true);
      });
    });

    group('getAll', () {
      test('returns empty list when no categories', () async {
        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess(), isEmpty);
      });

      test('returns all categories with system first', () async {
        const custom = CategoryEntity(
          id: 'cat-custom',
          name: 'Custom',
          iconCodePoint: 0xe000,
          colorHex: '#FF5733',
        );
        const system = CategoryEntity(
          id: 'cat-sys',
          name: 'System',
          iconCodePoint: 0xe001,
          colorHex: '#00FF00',
          isSystem: true,
        );

        // Save custom first, then system
        await repository.save(custom);
        await repository.save(system);

        final result = await repository.getAll();

        expect(result.isSuccess, true);
        expect(result.getSuccess().length, 2);
        // System categories should be first
        expect(result.getSuccess().first.isSystem, true);
      });
    });

    group('getById', () {
      test('returns category when exists', () async {
        const category = CategoryEntity(
          id: 'cat-1',
          name: 'Test Category',
          iconCodePoint: 0xe000,
          colorHex: '#FF5733',
        );

        await repository.save(category);

        final result = await repository.getById('cat-1');

        expect(result.isSuccess, true);
        expect(result.getSuccess().id, 'cat-1');
      });

      test('returns failure when category not found', () async {
        final result = await repository.getById('non-existent');

        expect(result.isFailure, true);
        expect(result.getFailure().message, 'Category not found');
      });
    });

    group('watchAll', () {
      test('returns a stream', () {
        final stream = repository.watchAll();

        expect(stream, isA<Stream<List<CategoryEntity>>>());
      });

      test('stream can be listened to', () async {
        final stream = repository.watchAll();
        final subscription = stream.listen((_) {});

        await Future<void>.delayed(const Duration(milliseconds: 100));

        await subscription.cancel();
      });
    });
  });
}
