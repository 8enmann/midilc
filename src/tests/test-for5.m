main(){
  Note d;
  Sequence c;
  Number i;
  c = new_sequence();
  c = c + A;
  d = A;
  for(i = 0; i < 20; i=i+1){
    if(i==4){
        continue;
    } else {
        c = c + (d .+ i);
    }
    if(i==12){
        break;
    }
  }
  play(c);
}
