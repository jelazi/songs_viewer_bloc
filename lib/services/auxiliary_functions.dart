const Map<String, String> collTable = {
  "a": "aa",
  "á": "ab",
  "A": "Aa",
  "Á": "Ab",
  "c": "ca",
  "č": "cb",
  "C": "Ca",
  "Č": "Cb",
  "d": "da",
  "ď": "db",
  "D": "Da",
  "Ď": "Db",
  "e": "ea",
  "é": "eb",
  "ě": "ec",
  "E": "Ea",
  "É": "Eb",
  "Ě": "Ec",
  "i": "ia",
  "í": "ib",
  "I": "Ia",
  "Í": "Ib",
  "n": "na",
  "ň": "nb",
  "N": "Na",
  "Ň": "Nb",
  "o": "oa",
  "ó": "ob",
  "O": "Oa",
  "Ó": "Ob",
  "r": "ra",
  "ř": "rb",
  "R": "Ra",
  "Ř": "Rb",
  "s": "sa",
  "š": "sb",
  "S": "Sa",
  "Š": "Sb",
  "t": "ta",
  "ť": "tb",
  "T": "Ta",
  "Ť": "Tb",
  "u": "ua",
  "ú": "ub",
  "ů": "uc",
  "U": "Ua",
  "Ú": "Ub",
  "Ů": "Uc",
  "y": "ya",
  "ý": "yb",
  "Y": "Ya",
  "Ý": "Yb",
  "z": "za",
  "ž": "zb",
  "Z": "Za",
  "Ž": "Zb"
};
String collKeys = collTable.keys.join("");
final RegExp keysPat = RegExp(r"(cH|ch|CH|Ch|h|H)|([" + collKeys + r"])");

bool isUpperCase(String str) {
  return str.toUpperCase() == str;
}

String collStr(String str) {
  return str.replaceAllMapped(keysPat, (match) {
    assert((match[1] == null) != (match[2] == null));
    if (match[1] != null) {
      // ch group = either h or ch
      String g = match[1]!;
      if (g.length == 1) {
        // h => ha, H => Ha
        return "${g}a";
      } else {
        assert(g.length == 2);
        // need to keep the case of the letters
        String subc = isUpperCase(g[0]) ? 'H' : 'h';
        // ch => hb, Ch => Hb, CH => Hb, cH => hb
        return "${subc}b";
      }
    }
    // diacritics
    return collTable[match[2]]!;
  });
}

int cmpColl(String a, String b) {
  return collStr(a).compareTo(collStr(b));
}

String removeDiacriticsAndWhitespace(String str) {
  const withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÝÿýŽžŘřŤťĚěČčŮůŇňĹĺ';
  const withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYYyyZzRrTtEeCcUuNnLl';

  for (int i = 0; i < withDia.length; i++) {
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }
  str = str.replaceAll(' ', '');

  return str;
}
