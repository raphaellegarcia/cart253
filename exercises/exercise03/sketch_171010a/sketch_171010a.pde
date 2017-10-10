// This declares the background colour to a dark pink, the first and second bouncer
color backgroundColor = color(200,150,150);
Bouncer bouncer;
Bouncer bouncer2;

// This affirms in the setup, the background colour, the bouncers' initial size, position, colour
void setup() {
  size(640,480);
  background(backgroundColor);
  bouncer = new Bouncer(width/2,height/2,2,2,50,color(150,0,0,50),color(255,0,0,50));
  bouncer2 = new Bouncer(width/2,height/2,-2,2,50,color(0,0,150,50),color(0,0,255,50));
}

// This draws the bouncers, and allows their updates over time
void draw() {
  bouncer.update();
  bouncer2.update();
  bouncer.draw();
  bouncer2.draw();
}