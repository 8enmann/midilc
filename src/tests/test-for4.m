main() {
  Sequence b;
  Sequence c;
  Chord d;
  Chord e;
  Chord f;
  Note rest;
  Note g;
  Number i;

  b = new_sequence();
  c = new_sequence();
  g = Fh;

  d = new_chord(Fw,A,C);
  e = new_chord(Gw,B,D);
  f = new_chord(Cw,E,G);


  for(i = 0; i <= 12; i=i+1){
     if(i == 0 || i == 2 || i == 4 || i==5 || i==7 || i==9 || i==11 || i==12){
         c = c + (g .+ i);
    } else {
         if(i%2 == 0){
          c = c + f;
         }
         else {
          c = c + e;
         }
    }
  } 
  c = c + d;
  rest = Rh;
  play(b);
  play(c);
}
