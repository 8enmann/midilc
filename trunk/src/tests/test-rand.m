/**
 * Test the random function. This test has to fail to be valid.
 * @author Ben
 */

main() {
  Note a; 
  Sequence b;
  Number i;
  Number r;
  b = new_sequence();
  a = As;
  for (i = 0 ; i < 20 ; i = i + 1) {
    r = rand(15);
    b = b + (a .+ r + r);
  }
  play(b);
}
