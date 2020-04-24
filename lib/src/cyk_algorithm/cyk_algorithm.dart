import 'dart:collection';

import 'generator.dart';

void main() {
  print('Hello');
}

class CYK_Algorithm {
  String w;
  List<Generator> generators;
  HashMap<String, List<Generator>> processedStrings;

  CYK_Algorithm(String w, List<Generator> generators) {
    this.w = w;
    this.generators = generators;
    _process();
  }

  void _process() {
    // Process the base generators.
    for (var i = 0; i < w.length; i++) {
      var charGenerators = <Generator>[];
      for (var gen in generators) {
        if (gen.hasArgument(w[i])) {
          charGenerators.add(gen);
        }
      }
      // Add the generators of the character.
      for (var gen in charGenerators) {
        processedStrings[w[i]].add(gen);
      }
    }
    // Generate the rest of the generators using the base ones.
    for (var i = w.length-1; i > 0; i--) {
      for (var y = 0; y < i; y++) {
        // TODO: Functionality.-
      }
    }
  }
}