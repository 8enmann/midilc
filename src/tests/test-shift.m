/* Test selection
   Tests selection by shifting notes' pitch */

main(){
  Note a;
  Chord c;
  Chord d;
  Sequence s;
  Number i;
  s = new_sequence();
  
  c = new_chord(C,E,G);
  s = s + shift(c, 0) + shift(c, 4) + shift(c, 0) + shift(c, 7);
  set_tempo(30);
  play(s);
}

shift(c, n)
{
	Number i;
	Number len;
	len = c.length;
	for(i = 0; i < len; i=i+1)
	{
		c[i] = c[i] .+ n;
	}
	return c;
}
