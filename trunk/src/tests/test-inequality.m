/* Test structural inequality
   Tests that checking equality of sequences, chords, and notes works.
   
   The sequence plays only if all the inequalities work correctly.
   @author Ye
   */

main() {
  Number n1;
  Number n2;
  Note a1;
  Note a2;
  Note a3;
  Sequence s1;
  Sequence s2;
  Sequence s3;
  Chord c1;
  Chord c2;
  Chord c3;
  
  n1 = 4;
  n2 = 8;
  
  /* different duration of the same note, and different notes of the same duration */
  a1 = C;
  a1.duration = n1;
  a2 = C;
  a2.duration = n2;
  a3 = D;
  a3.duration = n2;
  
  /* different duration of the same chord, and different chords of the same duration */
  c1 = new_chord(C, E, G);
  c1.duration = n1;
  c2 = new_chord(C, E, G);
  c2.duration = n2;
  c3 = new_chord(C, E, A);
  c3.duration = n2;
  
  /* different order of same chords in sequence, different sequences */
  s1 = new_sequence();
  s1 = s1 + c1;
  s1 = s1 + c2;
  s2 = new_sequence();
  s2 = s2 + c2;
  s2 = s2 + c1;
  s3 = new_sequence();
  s3 = s3 + c3;
  s3 = s3 + a1;
  
  if(n1 != n2 && a1 != a2 && a2 != a3 && c1 != c2 && c2 != c3 && s1 != s2 && s2 != s3)
  {
	play(s1);
  }
}
