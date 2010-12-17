/* Test arpeggio
   Tests creating an arpeggio (sequence) from a chord.  Library function.
   @author Fred
    */

main(){
  Note a;
  Chord c;
  Sequence s;
  Number i;
  
  c = new_chord(C,E,G);
  s = arpeggiate(c);
  play(s);
}

arpeggiate(c)
{
    Number n;
	Number i;
	Sequence s;
	s = new_sequence();
	n = c.length;
	for(i = 0; i < n; i=i+1)
	{
		s = s + c[i];
	}
	return s;
}
