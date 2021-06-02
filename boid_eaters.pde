class BoidEater{
  float size;
  float speed = .4;
  PVector pos;
  PVector vel = new PVector (0,0);;
  PVector boidEaterColor = new PVector(0,0,0);;
  float cal = 300;
  float kidCooldown;
  
  BoidEater(float sz,float spd, PVector ps){
    size = sz;
    speed = spd;
    pos = ps;
  }
  
  void BEDisplay(){
    PShape star;
    star = createShape();
    star.beginShape();
  // You can set fill and stroke
    star.fill(boidEaterColor.x);
    star.stroke(100);
    star.strokeWeight(2);
    // Here, we are hardcoding a series of vertices
    star.vertex(0, -size * 2.5);
    star.vertex(size * .7, -size);
    star.vertex((size * 4.7)/2, -(size * 1.5 )/2);
    star.vertex((size * 2.3)/2, (size * .7)/2);
    star.vertex((size * 2.9)/2, (size * 4)/2);
    star.vertex(0, (size * 2.5)/2);
    star.vertex(-(size * 2.9)/2, (size * 4.0)/2);
    star.vertex((size * -2.3)/2, (size * .7)/2);
    star.vertex((size *-4.7)/2,(size * -1.5)/2);
    star.vertex((size *-1.4)/2, (size * -2.0)/2);
    star.endShape(CLOSE);
    
    shape(star,pos.x,pos.y);
  }
  
  void boidHunt(){
    FloatList dists = new FloatList();
    for(int i = 0; i < boids.size(); i++) {
        
        
        Boid ftemp = boids.get(i);
        PVector fpos = ftemp.getPos();
        
        float d = dist(pos.x,pos.y,fpos.x,fpos.y);
        
        dists.set(i, d);
        
        
        
        

         
        }
        for(int i = 0; i <  dists.size(); i++) {
           if( dists.get(i) == dists.min()){
              
              Boid ftemp = boids.get(i);
              
              pull(pos.x,pos.y,ftemp.pos.x,ftemp.pos.y);
              
              float l = dist(pos.x,pos.y,ftemp.pos.x,ftemp.pos.y);
              if (l < 150){
                ftemp.inDanger = true;
              }
             
               if (l < 15){
                
                cal = cal + (ftemp.getBoidCal()*.3);
                boids.remove(i);
                dists.remove(i);
              
              }
          }
        }
  }
  void movement(){
    
    pos = pos.add(vel);
    
    vel.x = vel.x * .9;
    vel.y = vel.y * .9;
    
    
   
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
  
  
  void kids(){
        cal -= 2;
        if (cal >= 2500){
            boidEaterMaker();
            cal = 500;
        } 
        for (int i = 0; i < BE.size(); i++){
            BoidEater ftemp = BE.get(i);
            if(ftemp.cal <= 0){
               BE.remove(i);
            }
            
        }
  
  }
  
  
  
  
}
