main() {
  Note a; 
  Sequence b;
  Number i;
  Number r;
  b = new_sequence();
  a = Aq;
  for (i = 0 ; i < 20 ; i = i + 1) {
    r = rand(15);
    b = b + (a .+ r);
  }
  play(b);
}
