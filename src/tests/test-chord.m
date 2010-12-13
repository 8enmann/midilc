main() {
  Note a;
  Sequence b;
  Chord c;
  b = new_sequence();
  a = A3q;
  b = b + (a as Chord);
  play(b);
}
