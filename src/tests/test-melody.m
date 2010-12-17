/* Test creating a melody
   Tests by creating a simple melody 
   @author Fred
   */

main() {
  Note e;
  Note d;
  Note c;
  Note fc;
  Note fd;
  Sequence b;
  
  e = E4q;
  d = D4q;
  c = C4q;
  fc = C4s;
  fd = D4s;
  
  
  b = new_sequence();
  b = b + e + d + c + e + d + c;
  b = b + fc + fc + fc + fc;
  b = b + fd + fd + fd + fd;
  b = b + e + d + c;
  
  play(b);

}
