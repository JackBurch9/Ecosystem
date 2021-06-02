class Boid {
  PVector pos;
  PVector vel;
  int ID;
  float calories = 300;
  float size =  (calories * .3) ;
  float radius = size / 2;
  float speed;
  PVector boidColor;
  boolean inDanger = false;

  
  Boid(PVector pos1, PVector vel1, int ID1, float sped, PVector clr ){
    pos = pos1;
    vel = vel1;
    boidColor = clr;
    ID = ID1;
    speed = sped;
    
  }
  
  
  void movement(){
    
    pos = pos.add(vel);
    size = baseSize + (calories/100);
    radius = size / 2;
    
   
  }
  
    void collide(){
      FloatList dists = new FloatList();
      for(int i = 0; i < BE.size(); i++) {
        
        
        BoidEater ftemp = BE.get(i);
        PVector fpos = ftemp.pos;
        
        float d = dist(pos.x,pos.y,fpos.x,fpos.y);
        
        dists.set(i, d);
        
        
        
        

         
        }
        for(int i = 0; i <  dists.size(); i++) {
           if( dists.get(i) == dists.min()){
              
              BoidEater ftemp = BE.get(i);
              PVector fpos = ftemp.pos;
        
              //float d = dist(pos.x,pos.y,fpos.x,fpos.y);
             if (inDanger == true){
              pull(-pos.x,-pos.y,-ftemp.pos.x,-ftemp.pos.y);
             }
              
              
              //float l = dist(pos.x,pos.y,ftemp.pos.x,ftemp.pos.y);
              
              
          }
        }
      
    /*
        for( int i = 0 ; i < boids.size() ; i++){
          if (i != ID && boids.get(i).getBoidColor() != boidColor){
          // float x = boids.get(i).pos.x - pos.x;
           //float y = boids.get(i).pos.y - pos.y;
           float dist = dist(boids.get(i).pos.x, boids.get(i).pos.y , pos.x, pos.y);
           
           float minDist = (boids.get(i).radius + radius) ;
             if (dist < minDist){
               
                if (boids.get(i).getBoidCal() * 1.5 < calories){
                  
                  calories = calories + (boids.get(i).getBoidCal());
                  boids.remove(i);
                  
                }
               /*
               float angle = atan2(x, y);
               float targetX = pos.x + cos(angle) * minDist;
               float targetY = pos.y + sin(angle) * minDist;
               float ax = (targetX - boids.get(i).pos.x) * spring;
               float ay = (targetY - boids.get(i).pos.y) * spring;
               vel.x += ax;
               vel.y += ay;
               boids.get(i).vel.x -= ax;
               boids.get(i).vel.y -= ay;
               
             
           } 
           
         }
         
    }*/
        
      }
  
  void decay(){
    vel.x = (vel.x * .95);
    vel.y = (vel.y * .95);
    vel.y = vel.y + gravity;
    if (speed > 1){
        speed = 1;    
    }
  }
 
  void display(){
    fill(boidColor.x,boidColor.y,boidColor.z);
    size = baseSize + (calories/100);
    radius = size / 2;
    
    ellipse(pos.x,pos.y,size,size);
    fill(255);
  }
  
   void hunt(){
       //if (behavior == "nice"){
       FloatList dists = new FloatList();
     
       
       for(int i = 0; i < Foods.size(); i++) {
        
        
        Food ftemp = Foods.get(i);
        float fx = ftemp.getX();
        float fy = ftemp.getY();
        float d = dist(pos.x,pos.y,fx,fy);
        dists.set(i, d);
        
        
        

         
        }
        
          
        
        for(int i = 0; i <  dists.size(); i++) {
           if( dists.get(i) == dists.min()){
              
              Food ftemp = Foods.get(i);
              float fx = ftemp.getX();
              float fy = ftemp.getY();
              float l = dist(pos.x,pos.y,fx,fy);
             
              // line(pos.x,pos.y,fx,fy);
              
              if (size < 10) {
                if (l < 10){
                calories = calories + ftemp.getCal(); 
                Foods.remove(i);
                dists.remove(i);
                chef();
              }
              } else {
                  if (l < radius){
                    calories = calories + ftemp.getCal(); 
                    Foods.remove(i);
                    dists.remove(i);
                   chef();
                  }
              }
          
            pull(pos.x,pos.y,fx,fy);
          inDanger = false;
          
        }
     
    /* } else if (behavior == "mean"){
       FloatList dists = new FloatList();
       for(int i = 0; i < boids.size(); i++) {
        
        if (boids.get(i).getBehavior() != "nice"){
          Boid ftemp = boids.get(i);
          float fx = ftemp.getPos().x;
          float fy = ftemp.getPos().y;
          float d = dist(pos.x,pos.y,fx,fy);
          dists.set(i, d);
          print(i);
          print(d);
        
        

        }
        }*/
       
       
     //}
   }
   }
   void pull(float x1,float y1,float x2,float y2){
     float pullStrength = speed ;
              PVector pullLeft = new PVector (-pullStrength,0);
              PVector pullRight = new PVector (pullStrength,0);
              PVector pullUp = new PVector (0,-pullStrength);
              PVector pullDown = new PVector (0,pullStrength);
              
              
                
                if(x1 >= x2){
                  vel = vel.add(pullLeft);
                  
                }
                if(x1 <= x2){
                  vel = vel.add(pullRight);
                  
                }
                if(y1 >= y2){
                  vel = vel.add(pullUp);
                  
                }
                if(y1 <= y2){
                  vel = vel.add(pullDown);
                  
                }
    
    
              
         
              
          }
   void hunger(){
     
   // calories = calories - (1 + (speed));
     for ( int i = 0; i < boids.size() ; i++){
        
        
        if (boids.get(i).getBoidCal() >= 1200){
          
          float rand1 = int(random(-50,50));
          float rand2 = int(random(-50,50));
          
          PVector boidLoc = new PVector (boids.get(i).getPos().x + rand1 ,boids.get(i).getPos().y + rand2);
          PVector boidVel = new PVector (0,0);
          float mutation = random(-.2,.2);
          count++;
          boids.add(new Boid (boidLoc, boidVel ,count,boids.get(i).getBoidSpeed() 
          + mutation,boids.get(i).getBoidColor()));
          calories = 300;
          
     
     }
     if ( boids.get(i).getBoidCal() <= 0){
          boids.remove(i);
          
        }
     }
   }
   
   
   
   float getBoidCal(){
     return calories;
     
   }
   float getBoidSpeed(){
     return speed;
   }
   PVector getPos(){
     return pos;
   }
   PVector getVel(){
     return vel;
   }
   PVector getBoidColor(){
     return boidColor;
   }
 

   
}
