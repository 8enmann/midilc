/* Test minor
   Tests creating a minor chord from its root.  Library function. */

main(){
  Sequence s;
  Chord c;
  s = new_sequence();
  
  c = minor(C);
  s = s + c;
  set_tempo(30);
  play(s);
}

minor(root)
{
	Chord c;
	
	c = new_chord(root);
	
	c = c + (root .+ 3);
	c = c + (root .+ 7);
	return c;
}
