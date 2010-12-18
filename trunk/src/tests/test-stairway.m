main(){
  set_instrument("Voice Oohs");
  set_tempo(80);
  play(stairway1() + stairway1());
}

stairway1(){
  Sequence s;
  s = new_sequence();
  s = s + new_chord(C5e, A3e) + C4e + E4e + A4e;
  s = s + new_chord(B4e, G#e) + E4e + C4e + B4e;
  s = s + new_chord(C5e, Ge) + E4e + C4e + C5e;
  s = s + new_chord(F#4e, F#3e) + D4e + A3e + F#4e;
  s = s + new_chord(E4e, F3e) + C4e + A3e + C4q;
  s = s + E4e + C4e + A3e;
  s = s + new_chord(A2e, D3e, G3e, B3e) + new_chord(A2e, E3e, A3e, C4e) + new_chord(A2q, E3e, A3e, C4e) + Re + A2e + F3e + E3e;
  return s;
}

stairway2(){
  return new_sequence();
}
	
