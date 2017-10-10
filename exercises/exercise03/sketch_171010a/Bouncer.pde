// This declares the variables of the bouncer, its position, velocity, size, colour, default colour and their colour when the mouse hovers on the bouncer
class Bouncer {
  
 int x;
 int y;
 int vx;
 int vy;
 int size;
 color fillColor;
 color defaultColor;
 color hoverColor;
 
 //Temp allows to swap between two variables when two bouncers are the same but go in opposite directions
 Bouncer(int tempX, int tempY, int tempVX, int tempVY, int tempSize, color tempDefaultColor, color tempHoverColor) {
   x = tempX;
   y = tempY;
   vx = tempVX;
   vy = tempVY;
   size = tempSize;
   defaultColor = tempDefaultColor;
   hoverColor = tempHoverColor;
   fillColor = defaultColor;
 }
 
 //This declares and updates the motion of the bouncers to move at every frame on the x and y axis
 void update() {
   x += vx;
   y += vy;
   
   handleBounce();
   handleMouse();
 }
 
 //This declares that if the position of x, minus half the size of the ellipse is smaller than zero, and or that the position of x plus half the size of the ellipse is bigger than the width, change direction on the x axis
 //Same applies to the y axis. It also declaures the constraints in which the bouncers have to remain, which is that the furthest pixel of the bouncers that touch the edges of the frame must remain inside.
 void handleBounce() {
   if (x - size/2 < 0 || x + size/2 > width) {
    vx = -vx; 
   }
   
   if (y - size/2 < 0 || y + size/2 > height) {
     vy = -vy;
   }
   
   x = constrain(x,size/2,width-size/2);
   y = constrain(y,size/2,height-size/2);
 }
 
 //This declares that when the mouse is positioned on the x and y location of the ellipse, and that the distance is smaller than the size of the ellipse (hence you're touching it) the colour of the ellipses changes to the hover colour, and if it doesn't, keep the default colour
 void handleMouse() {
   if (dist(mouseX,mouseY,x,y) < size/2) {
    fillColor = hoverColor; 
   }
   else {
     fillColor = defaultColor;
   }
 }
 
 // This draw the ellipse, without a stroke, and with the pre-defined fill colour and size in the window
 void draw() {
   noStroke();
   fill(fillColor);
   ellipse(x,y,size,size);
 }
}