/* Test subtraction
   Tests subtracting a duration from a note */

main() {
  Note a;
  Sequence b;
  Chord c;
  b = new_sequence();
  a = A3q;
  a.duration = a.duration - 1;
  c = new_chord(a);
  b = b + c;
  b = b + b;
  play(b);
}