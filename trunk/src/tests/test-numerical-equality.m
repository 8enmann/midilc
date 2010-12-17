/* Test numerical equality
   Tests that checking equality of numbers works */

main() {
  Note a;
  Number n;
  Sequence b;
  b = new_sequence();
  a = A3q;
  a = (a as Chord) + C3q + Eb3q;
  b = b + a + a + a;
  n = 4;
  
  if(n == 4)
  {
	play(b);
  }
  else
  {
    b = b + A3q;
	play(b);
  }
}
