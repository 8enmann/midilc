/* Test play chord
   Tests playing a single chord */

main() {
  Chord c;
  Sequence s;
  s = new_sequence();
  c = new_chord(C, E, G);
  s = s + c;
  play(s);
}
