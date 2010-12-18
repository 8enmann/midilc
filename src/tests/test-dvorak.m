/* Test integration
   Try to reproduce part of Dvorak's String Quartet No 12, Op 96, "American"
   first Mvmt.
   @author Ben
    */

main() {
  
  set_instrument("Cello");
  set_tempo(112);
  
  play(transpose(transpose(soprano(), F, C), F, Ab));
  play(transpose(alto(), F, Ab));
  play(transpose(transpose(tenor(), F, C), F, Ab));
  play(transpose(shift(baritone(), (0-24)), F, Ab));
}

Sequence soprano() {
  Sequence sop;
  sop = new_sequence();
  sop = sop + Re;
  while(sop.current/16 < 5) {
    sop = sop + F5s + A5s;
  }
  while(sop.current < 10) {
    sop = sop + F5s + A5s;
  }
  sop = sop+arpeggiate(new_chord(F5s,C5,A,F,A,C5));
  sop = sop + shift(melody(), 12);
  return sop;
}

/** Alto track */
Sequence alto() {
  Sequence alt;
  Number i;
  
  alt = new_sequence();
  alt = alt + Rh + Re;
  while(alt.current/16 < 2) { 
    alt = alt + Es + Gs;
  }
  i = alt.current;
  while((alt.current-i)/16 < 8) { 
    alt = alt + Es + Cs;
  }
  return alt;
}

/** Tenor track */
Sequence tenor() {
  Sequence ten;
  Number i;
  
  ten = new_sequence();
  ten = ten + Rw + Rw;
  ten = ten + shift(melody(), (0-12));
  i = ten.current;
  while((ten.current-i)/16 < 4) { 
    ten = ten + F3s + A3s;
  }
  return ten;
}
Sequence baritone() {
  Sequence bar;
  
  bar = new_sequence();
  bar = bar + Rh + Rq + Re + Ce + (Ch + (16*4));
  bar = bar + Ee + Ge + Ee + (C+2)+Rh+C5e+Re+Ee+Re+Ge+R+C5e+Ce;
  bar = bar + (R+2)+A3e+Re
  + arpeggiate(new_chord(Ce,E,G,C5,R,E5,C5,A5,G5,C5,R));
  return bar;
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

Sequence melody() {
  Sequence m;
  m = new_sequence();
  m = m + Fe + A + C5e + (D5e+1) + F5s + D5;
  m = m + (C5e+1) + As + Fe + Gs + As + C5h;
  m = m + (Ce+1) + Ds + Fs + Ds + Re;
  m = m + (Ce+1) + Ds + Fs + Ds + Re;
  m = m + Cs+Fs+As+C5s+(C5e+1)+As+(F+2)+Re;
  return m;
}

Sequence transpose(Sequence s, Note source, Note target) {
  Number diff;
  Number i;
  Number j;
  Chord temp;

  diff = (target.pitch - source.pitch)%12;
  for(i = 0; i < s.length; i=i+1){
    temp = s[i];
    for(j = 0; j < temp.length; j = j+1) {
      temp[j] = temp[j] .+ diff;
    }
    s[i] = temp;
  }

  return s;
}

Sequence shift(Sequence s, Number steps) {
  Chord temp;
  Number i;
  Number j;
  
  for(i = 0; i < s.length; i=i+1){
    temp = s[i];
    for(j = 0; j < temp.length; j = j+1) {
      temp[j] = temp[j] .+ steps;
    }
    s[i] = temp;
  }

  return s;
}
