/**
 * Test sequences
 * @author Fred
 */

main() {
  Note a;
  Sequence b;
  Sequence seq;
  Note root;
  
  Chord chor;
  Chord chor2;
  Chord chor3;
  b = new_sequence();
  seq = new_sequence();
  root = C4q;
  chor = (root as Chord) + E4q + G4q;
  b = b + chor;
  root = F4q;
  chor2 = (root as Chord) + A5q + C5q;
  root = G4q;
  chor3 = (root as Chord) + B5q + D5q;
  seq = seq + chor2 + chor3;
  seq = b + seq;
  play(seq);
}
