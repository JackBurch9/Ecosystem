
PVector baseBoid = new PVector (0,0,0);
ArrayList<Boid> boids = new ArrayList<Boid>();
ArrayList<BoidEater> BE = new ArrayList<BoidEater>();
ArrayList<Food> Foods = new ArrayList<Food>();
int numBoids = 40;
int numbBoidEaters = 5;
float spring = 0.08;
int baseSize = 10;
float gravity = 0.0;
int maxFood = 100;
int count = 0;

//screen 2 stuff
int display = 0;
float ball1x;
float ball2x;
FloatList ball1 = new FloatList();
FloatList ball2 = new FloatList();
FloatList ball3 = new FloatList();
FloatList ball4 = new FloatList();

void setup(){
    size(1400,800);
     ball1x = 0;
     ball2x = 0;
    frameRate(120);
    for(int i = 0; i < numbBoidEaters; i++){
      boidEaterMaker();
    }
    for(int i = 0; i < maxFood; i++){
      
      chef();
    }
   
    for(int i = 0; i < numBoids; i++){
      arrayListMaker();
    }
}

void draw(){
  
  if (display % 2 == 0){
 background(0,154,23);
  //noStroke();
  
 // pointer();

  foodDrawer();
  }
    
    display();
  
  
  boidDrawer();
  boidEaterDrawer();
  
}

void arrayListMaker(){
  
  float rand1 = int(random(baseSize,width - baseSize));
  float rand2 = int(random(baseSize,height - baseSize));
  float rand5 = random(.3, .5);
  float r = random(0,255);
   float g = random(0,255);
   float b = random(0,255);
  
  
  
  PVector clr = new PVector(r,g,b);
  
  
  PVector boidLoc = new PVector (rand1,rand2);
  PVector boidVel = new PVector (0,0);
  
  if (count <= numBoids){
    boids.add(new Boid(boidLoc,boidVel,count,rand5,clr));
     count++;
  }
  
}

void boidDrawer(){
  for (int i = 0; i < boids.size(); i++) {
    
    Boid part = boids.get(i);
    if (display % 2 == 0){
    part.display();
    }
    part.movement();
    part.collide();
    part.decay();
    part.hunt();
    part.hunger();
    //part.behavior();
    fill(255);
    
  }
}
void boidEaterDrawer(){
    for (int i = 0; i < BE.size(); i++) {
    
    BoidEater part = BE.get(i);
     if (display % 2 == 0){
    part.BEDisplay();
    }
    part.movement();
    part.boidHunt();
    part.kids();
    }
    
  
}
void boidEaterMaker(){
    
    float x = random(0,width);
    float y = random(0,height);
    PVector ps = new PVector(x,y);
    BoidEater part = new BoidEater(5,.7,ps);
    BE.add(part);
    
    
  
}
  void chef (){
     
     float x = random(50, width  - 50);
     float y = random(50, height - 50);
     int c = int(random(80,150));
     Food food = new Food(c,x,y);
     Foods.add(food);
     
    
  
  }
  void foodDrawer(){
  for (int i = 0; i < Foods.size(); i++) {
      Food f = Foods.get(i);
      PVector c = f.getClr();
      fill(c.x,c.y,c.z);
      ellipse(f.x,f.y,10,10);
      /*PShape plant;
    plant = createShape();
    plant.beginShape();
  // You can set fill and stroke
      plant.fill(c.x,c.y,c.z);
      plant.vertex 
      plant.endShape(CLOSE);
      shape(plant,f.x,f.y);*/
      fill(255);
}

  }
  
void mouseReleased(){
    display++;
    background(180);
    
}

void display(){
   if ( display % 2 != 0){
    fill(0);
    background(180);
    
    
    line(0,height/2,width,height/2);
    line(0,height* 3/4,width,height * 3/4 );
    for (int i = 0; i < ball1.size(); i++){
      ellipse(ball2.get(i),ball1.get(i),2,2);
    }
    for (int i = 0; i < ball3.size(); i++){
      ellipse(ball4.get(i),ball3.get(i),2,2);
    }
    
    
    //ellipse(ball2x,height * 3/4 - BE.size() * 4,4,4);
    // potential to switch to array to store ball1x/ball2x
    //and have saved info to call back to
    //would fix the no refreshing problem and make switching easier
   }
    if (ball1x < width){
    ball2.push(ball1x);
    ball1.push(height/2 - boids.size());
    ball1x = ball1x +  .1;
    } else {
    
    background(180);
     ball1.clear();
     ball1x = 0 ;
    }
    
    
    if (ball2x < width){
    ball4.push(ball2x);
    ball3.push(height * 3/4 - (BE.size() * 3));
    ball2x = ball2x +  .1;
    } else {
    
    background(180);
    
     ball3.clear();
     ball2x = 0 ;
    }
}
