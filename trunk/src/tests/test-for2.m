/** Test for loop
  * 
  * Test the for loop by adding chords to a sequence.
  *
  * @author Ben
  */

main() {
  Note a; 
  Sequence b;
  Number i;
  b = new_sequence();
  a = Aq;
  for (i = 0 ; i < 12 ; i = i + 1) {
    b = b + a;
    b = b + ((a as Chord) + (a .+ i));
  }
  play(b);
}
