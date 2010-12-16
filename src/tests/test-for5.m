/**
 *  This code demonstrates continue and break.
 *
 *  The output is shown to not include C#, as we continue on i==4.
 *  In addition, the length of output is limited by the break command.
 */

main(){
  Note d;
  Sequence c;
  Number i;

  c= new_sequence();
  d = A;

  for(i = 0; i < 200; i=i+1){
    if(i==4){
        continue;
    } else {
        c = c + (A .+ i);
    }
    if(i==12){
        break;
    }
  }
  play(c);
}
