import 'dart:io';

Future<void> main() async {
  try {
    // Read data from the input file
    File inputFile = File('input.txt');
    List<String> lines = await inputFile.readAsLines();
    
    // Calculate sum of numbers
    int sum = 0;
    for (String line in lines) {
      sum += int.parse(line);
    }
    
    // Write sum to output file
    File outputFile = File('output.txt');
    await outputFile.writeAsString('Sum: $sum');
    
    print('Sum calculated and written to output.txt successfully.');
  } catch (e) {
    print('Error: $e');
  }
}
