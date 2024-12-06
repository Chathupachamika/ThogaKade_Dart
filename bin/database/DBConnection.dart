class DBConnection {
  static DBConnection? _instance;
  static List<Map<String, dynamic>> _database = [];

  DBConnection._();

  // Singleton instance
  static DBConnection getInstance() {
    _instance ??= DBConnection._();
    return _instance!;
  }

  // CRUD Operations
  void create(Map<String, dynamic> record) {
    _database.add(record);
  }

  List<Map<String, dynamic>> readAll() {
    return _database;
  }

  Map<String, dynamic>? readById(String id) {
    return _database.firstWhere((record) => record['id'] == id, orElse: () => {});
  }

  void update(String id, Map<String, dynamic> updatedRecord) {
    final index = _database.indexWhere((record) => record['id'] == id);
    if (index != -1) {
      _database[index] = updatedRecord;
    } else {
      throw Exception('Record not found.');
    }
  }

  void delete(String id) {
    _database.removeWhere((record) => record['id'] == id);
  }

  // Clear all records
  void clearDatabase() {
    _database.clear();
  }
}
