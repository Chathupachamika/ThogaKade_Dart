import 'dart:io';

class FileService {
  Future<void> backupData(String filePath) async {
    try {
      final file = File(filePath);
      final backupPath = '${filePath}_backup';
      await file.copy(backupPath);
      print('Backup completed successfully!');
    } catch (e) {
      throw Exception('Failed to backup data: $e');
    }
  }

  Future<void> restoreData(String backupPath, String restorePath) async {
    try {
      final backupFile = File(backupPath);
      final restoreFile = File(restorePath);
      await backupFile.copy(restoreFile.path);
      print('Restore completed successfully!');
    } catch (e) {
      throw Exception('Failed to restore data: $e');
    }
  }
}
