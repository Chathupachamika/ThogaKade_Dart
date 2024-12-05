import 'package:mysql1/mysql1.dart';

class DBConnection {
  static DBConnection? _instance;
  static MySqlConnection? _connection;

  // Private constructor
  DBConnection._();

  // Singleton instance getter
  static Future<DBConnection> getInstance() async {
    if (_instance == null) {
      _instance = DBConnection._();
      await _initializeConnection();
    }
    return _instance!;
  }

  static Future<void> _initializeConnection() async {
    try {
      _connection = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306,
        user: 'root',
        db: 'Thoga_Kade',
        password: '1234',
      ));
      print("Database connected successfully!");
    } catch (e) {
      print("Error connecting to the database: $e");
    }
  }

  static MySqlConnection? get connection => _connection;

  static Future<void> closeConnection() async {
    await _connection?.close();
    _connection = null;
    print("Database connection closed.");
  }
}
