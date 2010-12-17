/**
 * Tests setting the instrument used.
 *
 * @author Fred
 */

main() {
  Note a;
  Sequence b;
  Chord c;
  b = new_sequence();
  a = A3q;
  a = (a as Chord) + C3q + Eb3q;
  b = b + a + a + a;
  set_instrument("Piano");
  play(b);
}
