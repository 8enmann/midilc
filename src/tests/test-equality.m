/* Test structural equality
   Tests that checking equality of sequences, chords, and notes works
   (Otherwise, there will be no output) */

main() {
  Note a;
  Number n;
  Sequence b;
  Chord c;
  b = new_sequence();
  a = A3q;
  a = (a as Chord) + C3q + Eb3q;
  c = new_chord(C, E, G);
  b = b + a + a + a;
  n = 4;
  
  if(b == b && c == c && a == a)
  {
	play(b);
  }
}
