/** Tests subscripting.
  *
  * @author Ben
  */

main() {
  Note a;
  Sequence b;
  Chord c;
  Chord temp;
  Number s;
  a = A5w;
  b = new_sequence();
  a = (a as Chord) + C5 + Eb5;
  c = a;
  c[1] = A6;
  c[2] = A4;
  b = b + a;
  b = b + c;
  b = b + c;
  /* set the start time of a to the start time of the 3rd note */
  temp = b[2];
  s = temp.start;
  a.start = s;
  b[2] = a;
  play(b);
}
