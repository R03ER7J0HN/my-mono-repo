import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Initialize sqflite_ffi for desktop testing.
void initializeTestDatabase() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

/// Create an in-memory database for testing.
Future<Database> createInMemoryDatabase() async {
  initializeTestDatabase();

  final database = await openDatabase(
    inMemoryDatabasePath,
    version: 1,
    onCreate: _onCreate,
  );

  return database;
}

Future<void> _onCreate(Database db, int version) async {
  // Create accounts table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS accounts (
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
    CREATE TABLE IF NOT EXISTS transactions (
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
      FOREIGN KEY (account_id) REFERENCES accounts(id),
      FOREIGN KEY (to_account_id) REFERENCES accounts(id),
      FOREIGN KEY (category_id) REFERENCES categories(id)
    )
  ''');

  // Create installments table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS installments (
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
      FOREIGN KEY (account_id) REFERENCES accounts(id)
    )
  ''');

  // Create categories table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS categories (
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
    CREATE TABLE IF NOT EXISTS monthly_budgets (
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
}
