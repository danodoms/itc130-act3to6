import 'dart:io';

Future<void> main() async {
  try {
    // Read user-provided file name
    print('Enter file name:');
    String? fileName = stdin.readLineSync();

    if (fileName == null) {
      print('No file name provided.');
      return;
    }

    // Open and read file
    File file = File(fileName);
    if (!file.existsSync()) {
      throw FileSystemException('File not found');
    }
    List<String> lines = await file.readAsLines();

    // Print file contents
    print('File contents:');
    for (String line in lines) {
      print(line);
    }
  } catch (e) {
    print('Error: $e');
  }
}
