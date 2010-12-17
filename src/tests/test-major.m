/* Test major
   Tests creating a major chord from its root.  Library function. 
   @author Fred
   */

main(){
  Sequence s;
  Chord c;
  s = new_sequence();
  
  c = major(C);
  s = s + c;
  set_tempo(30);
  play(s);
}

major(root)
{
	Chord c;
	
	c = new_chord(root);
	
	c = c + (root .+ 4);
	c = c + (root .+ 7);
	return c;
}
