import 'generator.dart';

class CYK_Utils {
  static final String epsilon = 'ε';

  static List<Generator> convertToFNC(List<Generator> gens) {
    var symbols = <String>[];
    var newGens = <Generator>[];
    // Get the unique symbols.
    for (var gen in gens) {
      var args = gen.arguments;
      for (var arg in args) {
        for (var i = 0; i < arg.length; i++) {
          var symbol = arg[i];
          if (symbol == symbol.toLowerCase()) {
            if (!symbols.contains(symbol)) {
              symbols.add(symbol);
            }
          }
        }
      }
    }
    print(symbols);
    return null;
  }
}