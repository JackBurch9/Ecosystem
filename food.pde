class Food{
  
  int cal;
  float x;
  float y;
  PVector clr = new PVector (0,75,0);
  Food(int cal1,  float x1, float y1){
    cal = cal1;
    x = x1;
    y = y1;
  }
  
  float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  int getCal(){
    return cal;
  }
  PVector getClr(){
    return clr;
  }
  
  
  void setColor(int r, int g, int b){
    PVector p = new PVector(r,g,b);
    clr = p;
  }
}
