/* Test global
   Uses global variables to test them 
   @author Fred
   */

Note a;
Sequence b;
Chord d;

main() {
  
  b = new_sequence();
  a = A3q;
  a = (a as Chord) + C3q + Eb3q;
  mod();
  
  play(b);
}

mod()
{
   b = b + a + a + a;
}
