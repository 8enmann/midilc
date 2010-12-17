/** Test chord
  * 
  * Construct a chord and play it
  *
  * @author Ben
  */

main() {
  Note a;
  Sequence b;
  b = new_sequence();
  a = A3q;
  a = (a as Chord) + C3q + Eb3q;
  b = b + a + a + a;
  play(b);
}
