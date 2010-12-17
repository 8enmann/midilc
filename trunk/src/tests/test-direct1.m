/**
 * Tests direct selection as lvalue.
 * @author Ben
 */

main() {
  Note a;
  Note f;
  Sequence b;
  Chord c;
  b = new_sequence();
  a = A5q;
  a = (a as Chord) + C5 + Eb5;
  f = A6s;
  c = (f as Chord) + C6 + Eb6;
  c.duration = 32;
  b = b + a;
  b.current = 0;
  b = b + c;
  play(b);
}
