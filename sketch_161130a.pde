import netP5.*;
import oscP5.*;

 // OSC PARAMETERS & PORTS
  int recvPort = 5000;
  OscP5 oscP5;
  int x;
  int y;
  
  float ac_x;
   float ac_y;
  
  // DISPLAY PARAMETERS
  int WIDTH = 100;
  int HEIGHT = 100;
  int t=0;
  
  //String colours[] = {"yellow","blue","red"};
  
  
  color yellow = color(255, 204, 0);
  color red = color(247, 84, 84);
  color blue = color(144, 195, 212);
  
  int colours[] = {yellow,blue,red};
  
  int c;
  
  int s=30;
  
  
  void setup() {
    size(900,900);
    frameRate(60);
    
    /* start oscP5, listening for incoming messages at recvPort */
    oscP5 = new OscP5(this, recvPort);
    background(0);
  }

  void draw() {
    background(0);
       if (s>200) {
     s=30;
    }
    if (c>2) {
     c=0;
    }
    fill(colours[c]);
    ellipse(x, y, s, s); 
  }
  
  void oscEvent(OscMessage msg) {
  //System.out.println("### got a message " + msg);
  if (msg.checkAddrPattern("/muse/elements/blink")) {  
    
    int blink = msg.get(0).intValue();
    if (blink == 1) {
    c++;
      
  } 
  }
  
    if (msg.checkAddrPattern("/muse/elements/jaw_clench")) {  
      
    int jaw = msg.get(0).intValue();
    if (jaw == 1) {
      s=s+5;
    }
    }
    
    if (msg.checkAddrPattern("/muse/acc")) {  
    
       ac_x = msg.get(2).floatValue();
       
       float x1 = map(ac_x,-751, 620, 0, 10);
       
       int ac_x_int = int(x1);
    
       //println(ac_x_int);
       
       if (ac_x_int < 5) {
          x--;
        }
        
        if (ac_x_int > 5) {
          x++;
        }
       
       
       ac_y = msg.get(0).floatValue();
       
       float y1 = map(ac_y,-660, 773, 0, 10);
       
       int ac_y_int = int(y1);
    
        println(ac_x+","+ac_y);
        
        if (ac_y_int < 2) {
          y--;
        }
        
        if (ac_y_int > 4) {
          y++;
        }
    
    
}
    }