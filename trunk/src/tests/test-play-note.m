/* Test play note
   Tests playing a single note 
   @author Fred
   */

main() {
  Note a;
  Sequence s;
  s = new_sequence();
  a = A3q;
  s = s + a;
  play(s);
}
