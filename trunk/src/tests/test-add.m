/**
   Test add
   Tests adding a duration to a note 
   @author Fred
   */

main() {
  Note a;
  Sequence b;
  Chord c;
  b = new_sequence();
  a = A3q + 4;
  c = new_chord(a);
  b = b + c;
  b = b + b;
  play(b);
}
