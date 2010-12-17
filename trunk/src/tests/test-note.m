/** Test note literal
  * 
  * Construct a note literal and play it
  *
  * @author Ben
  */

main() {
  Note a;
  Sequence b;
  a = A3q;
  b = new_sequence() + a;
  play(b);
}

Note myA() {
  return Ab7;
}
