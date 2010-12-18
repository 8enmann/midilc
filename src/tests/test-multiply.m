/**
   Test multiply
   Tests multiplying 
   @author Ye
   */

main() {
  Note a;
  Sequence b;
  Number n;
  
  b = new_sequence();
  
  a = A4s;
  b = b + a;
  
  for (n = 1; n < 5; n = n + 1) {
  		a.duration = a.duration * 2;
  		b = b + a;
  }

  play(b);
}