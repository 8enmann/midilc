/* Test divide
   Tests division operator.
   @author Ben
    */

main() {
  Note a;
  Chord c;
  Sequence s;
  Sequence final;
  Number i;
  
  c = new_chord(Ch,E,G, G#);
  final = new_sequence();
  s = new_sequence();
  s = arpeggiate(c);
  final = final + s;
  
  while(c.duration/2 != 0) {
    s = divide(s);
    final = final + s;
    c = s[0];
  }
  set_instrument("58");
  set_tempo(160);
  play(final);
}

Sequence arpeggiate(Chord c) {
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

Sequence divide(Sequence s) {
  Sequence result;
  Number dur;
  Number i;
  Chord temp;
  
  result = new_sequence();
  for(i = 0; i < s.length; i=i+1) {
    temp = s[i];
    dur = temp.duration;
    dur = dur/2;
    temp.duration = dur;
    result = result + temp;
  }
  result = result + result;
  return result;
}
