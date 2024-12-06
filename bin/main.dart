import 'dart:io';
import 'cli/command_handler.dart';

void main() {
  final commandHandler = CommandHandler();
  commandHandler.displayMenu();
}
