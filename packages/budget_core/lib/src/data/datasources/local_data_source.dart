import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite local data source for budget tracking data.
///
/// This class manages the SQLite database connection and provides
/// access to the database instance. It should be instantiated via
/// [createDatabase] and registered in GetIt for dependency injection.
class LocalDataSource {
  /// Creates a LocalDataSource with an initialized database.
  ///
  /// Use [createDatabase] factory to create an instance.
  const LocalDataSource(this._database);

  final Database _database;

  /// Database name
  static const _databaseName = 'budget_tracker.db';

  /// Database version - increment when schema changes
  static const _databaseVersion = 1;

  /// Table names
  static const tableAccounts = 'accounts';
  static const tableTransactions = 'transactions';
  static const tableInstallments = 'installments';
  static const tableCategories = 'categories';
  static const tableMonthlyBudgets = 'monthly_budgets';

  /// Get the database instance.
  Database get database => _database;

  /// Creates and initializes the SQLite database.
  ///
  /// This should be called once during app initialization, and the
  /// resulting [LocalDataSource] should be registered in GetIt.
  static Future<LocalDataSource> createDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    return LocalDataSource(database);
  }

  static Future<void> _onCreate(Database db, int version) async {
    // Create accounts table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableAccounts (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        balance REAL NOT NULL DEFAULT 0,
        credit_limit REAL,
        budget_limit REAL,
        warning_threshold REAL NOT NULL DEFAULT 0.8,
        icon_name TEXT,
        color_hex TEXT,
        is_active INTEGER NOT NULL DEFAULT 1,
        created_at TEXT
      )
    ''');

    // Create transactions table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableTransactions (
        id TEXT PRIMARY KEY,
        account_id TEXT NOT NULL,
        type TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT NOT NULL,
        category TEXT,
        category_id TEXT,
        date TEXT NOT NULL,
        to_account_id TEXT,
        notes TEXT,
        created_at TEXT,
        FOREIGN KEY (account_id) REFERENCES $tableAccounts(id),
        FOREIGN KEY (to_account_id) REFERENCES $tableAccounts(id),
        FOREIGN KEY (category_id) REFERENCES $tableCategories(id)
      )
    ''');

    // Create installments table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableInstallments (
        id TEXT PRIMARY KEY,
        account_id TEXT NOT NULL,
        description TEXT NOT NULL,
        total_amount REAL NOT NULL,
        total_installments INTEGER NOT NULL,
        paid_installments INTEGER NOT NULL DEFAULT 0,
        frequency TEXT NOT NULL DEFAULT 'monthly',
        start_date TEXT NOT NULL,
        merchant_name TEXT,
        notes TEXT,
        created_at TEXT,
        FOREIGN KEY (account_id) REFERENCES $tableAccounts(id)
      )
    ''');

    // Create indexes for common queries
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_transactions_account_id 
      ON $tableTransactions(account_id)
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_transactions_date 
      ON $tableTransactions(date DESC)
    ''');
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_installments_account_id 
      ON $tableInstallments(account_id)
    ''');

    // Create categories table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableCategories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        icon_code_point INTEGER NOT NULL,
        color_hex TEXT NOT NULL,
        is_system INTEGER NOT NULL DEFAULT 0,
        created_at TEXT
      )
    ''');

    // Create monthly budgets table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableMonthlyBudgets (
        id TEXT PRIMARY KEY,
        year INTEGER NOT NULL,
        month INTEGER NOT NULL,
        total_budget REAL NOT NULL,
        spent_amount REAL NOT NULL DEFAULT 0,
        daily_budget REAL,
        notes TEXT,
        created_at TEXT,
        updated_at TEXT,
        UNIQUE(year, month)
      )
    ''');

    // Create index for monthly budgets
    await db.execute('''
      CREATE INDEX IF NOT EXISTS idx_monthly_budgets_year_month 
      ON $tableMonthlyBudgets(year, month)
    ''');

    // Insert default categories
    await _insertDefaultCategories(db);
  }

  static Future<void> _insertDefaultCategories(Database db) async {
    final defaultCategories = [
      {
        'id': 'cat_food',
        'name': 'Food & Dining',
        'icon_code_point': 0xe532, // Icons.restaurant
        'color_hex': '#FF5722',
        'is_system': 1,
      },
      {
        'id': 'cat_transport',
        'name': 'Transportation',
        'icon_code_point': 0xe1d7, // Icons.directions_car
        'color_hex': '#2196F3',
        'is_system': 1,
      },
      {
        'id': 'cat_shopping',
        'name': 'Shopping',
        'icon_code_point': 0xe59c, // Icons.shopping_bag
        'color_hex': '#9C27B0',
        'is_system': 1,
      },
      {
        'id': 'cat_entertainment',
        'name': 'Entertainment',
        'icon_code_point': 0xe40f, // Icons.movie
        'color_hex': '#E91E63',
        'is_system': 1,
      },
      {
        'id': 'cat_bills',
        'name': 'Bills & Utilities',
        'icon_code_point': 0xe8a1, // Icons.receipt
        'color_hex': '#607D8B',
        'is_system': 1,
      },
      {
        'id': 'cat_health',
        'name': 'Health',
        'icon_code_point': 0xe3f3, // Icons.local_hospital
        'color_hex': '#4CAF50',
        'is_system': 1,
      },
      {
        'id': 'cat_salary',
        'name': 'Salary',
        'icon_code_point': 0xe0af, // Icons.attach_money
        'color_hex': '#8BC34A',
        'is_system': 1,
      },
      {
        'id': 'cat_other',
        'name': 'Other',
        'icon_code_point': 0xe3ae, // Icons.category
        'color_hex': '#795548',
        'is_system': 1,
      },
    ];

    for (final category in defaultCategories) {
      await db.insert(tableCategories, {
        ...category,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 1) {
      // Add categories table
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $tableCategories (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          icon_code_point INTEGER NOT NULL,
          color_hex TEXT NOT NULL,
          is_system INTEGER NOT NULL DEFAULT 0,
          created_at TEXT
        )
      ''');

      // Add monthly budgets table
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $tableMonthlyBudgets (
          id TEXT PRIMARY KEY,
          year INTEGER NOT NULL,
          month INTEGER NOT NULL,
          total_budget REAL NOT NULL,
          spent_amount REAL NOT NULL DEFAULT 0,
          daily_budget REAL,
          notes TEXT,
          created_at TEXT,
          updated_at TEXT,
          UNIQUE(year, month)
        )
      ''');

      // Create index for monthly budgets
      await db.execute('''
        CREATE INDEX IF NOT EXISTS idx_monthly_budgets_year_month 
        ON $tableMonthlyBudgets(year, month)
      ''');

      // Add category_id column to transactions
      await db.execute('''
        ALTER TABLE $tableTransactions 
        ADD COLUMN category_id TEXT REFERENCES $tableCategories(id)
      ''');

      // Insert default categories
      await _insertDefaultCategories(db);
    }
  }

  /// Close the database connection.
  Future<void> close() async {
    await _database.close();
  }

  /// Clear all data from all tables and reset to initial state.
  ///
  /// Keeps default categories but removes all user data.
  Future<void> clearAllData() async {
    await _database.transaction((txn) async {
      // Delete all user data in proper order (respecting foreign keys)
      await txn.delete(tableTransactions);
      await txn.delete(tableInstallments);
      await txn.delete(tableMonthlyBudgets);
      await txn.delete(tableAccounts);
      await txn.delete(tableCategories);
    });

    // Re-insert default categories
    await _insertDefaultCategories(_database);
  }

  /// Delete the database file (for testing/reset).
  static Future<void> deleteDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);
    await databaseFactory.deleteDatabase(path);
  }
}
