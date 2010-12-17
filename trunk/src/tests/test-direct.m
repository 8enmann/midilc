/*  Test direct selection
    Transposes a chord from one key to another through direct selection 
    @author Fred
    */

main(){
  Note a;
  Chord c;
  Sequence s;
  Number i;
  
  s = new_sequence();
  
  c = new_chord(C,E,G);
  s = s + transpose(c, C, C) + transpose(c, C, E) + transpose(c, C, C) + transpose(c, C, G);
  set_tempo(30);
  play(s);
}

transpose(input, first, second)
{
    Number n;
	n = first.pitch - second.pitch;
	return shift(input, n);
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
