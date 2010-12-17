/* Test upper casts
   Tests casting note to chord, chord to sequence, and node to sequence 
   @author Fred
   */

main() {
  Note n;
  Chord c;
  Sequence s;
  n = A;
  s = new_sequence();
  c = new_chord(n, n .+ 4, n .+ 7);
  
  s = s + c + n;
  play(s);
}
