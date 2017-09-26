//This line tells the distance in pixels from which the circle will move away from its predecessor, giving the impression of speed
final int CIRCLE_SPEED = 2; // CHANGED: slowed the ball down by decreasing the distance in pixels
//This line gives a color of (250, 100, 100) to the circle when it is NOT clicked, in other terms, its initial color (a pink)
final color NO_CLICK_FILL_COLOR = color(250, 200, 6); //CHANGED: color of the circle to yellow
//This line gives a color of (100, 100, 250) to the circle when it is clicked (a blue)
final color CLICK_FILL_COLOR = color(100, 100, 250);
//This line gives the background of the given space a color of (250, 150, 150)
final color BACKGROUND_COLOR = color(250, 150, 150);
//This line gives a colored stroke to the circle
final color STROKE_COLOR = color(250, 150, 150);
//This line gives a radius size of 50 pixels to the circle
final int CIRCLE_SIZE = 50;
final int OTHER_BACKGROUND = color(random(255), random(255), random(255)); //CHANGED, randomly changes the background's colour -> added code from asimes on https://forum.processing.org/one/topic/how-to-choose-random-color-value.html


//These lines declare the variables of the circle
int circleX;
int circleY;
int circleVX;
int circleVY;


//This line gives the setup parameter for the window in which we will operate
void setup() {
  //This line gives the size of the visible and usable window
  size(640, 480);
  //This line defines the variable circleX with a size of half the width of the window
  circleX = width/2;
  //This line defines the variable circleY with a size of half the height of the window
  circleY = height/2;
  //This line defines the velocity of the variable on the X axis to the speed of the circle established earlier, 7
  circleVX = CIRCLE_SPEED;
   //This line defines the velocity of the variable on the Y axis to the speed of the circle established earlier, 7
  circleVY = CIRCLE_SPEED;
   //This line affirms the color of the circle's stroke color
  stroke(STROKE_COLOR);
  //This line affirms the color of the circle when it is not clicked
  fill(NO_CLICK_FILL_COLOR);
  //This line affirms the colour of the background
  background(BACKGROUND_COLOR);
  
}

//This series of lines are giving conditions to the actions that will appear in the window, hence, draw
void draw() {
  //if the position of x and y of the mouse and the position of x and y of the circle is smaller than the radius of the circle divided by 2 (so 25) which means smaller than the size of the cirlce to make sure we touch it
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {
      //if this is true, then change th color of the circle to the defined parameters of CLICK_FILL_COLOR, which is color(100, 100, 250), blue
    fill(CLICK_FILL_COLOR);
  }
  //if this is not true, put the defined NO_CLICK_FILL_COLOR, color, which is the pink defined in the setup
  else {
    fill(NO_CLICK_FILL_COLOR);
  }
  // ADDED if the mouse is near the edge on the e=x axis, change the color of the fill of the circle to (255, 5, 70)
  if (mouseX <= 5 || mouseX >= 635) {
    fill (255, 5, 70);
    }
  //This line defines the circle on which some conditions will be applied
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);
  //These lines make the circle move in x and y axis in space of 7 pixels over / now 2 because of the changes made above
  circleX += circleVX;
  circleY += circleVY;
  //This line declares that when the circle's position touches the edge of the window on the right-most x axis, turn its x position to negative, thus making it going reverse; and/or when the circle touches the left-most x axis, turn the x position to positive.
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
   //This line declares that when the circle's position touches the edge of the window on the top-most y axis, turn its y position to negative, thus making it going reverse; and/or when the circle touches the bottom-most y axis, turn the y position to positive.
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
 
}

//Command defining that when and while the mouse is pressed, apply the background colour on top of the drawings, which gives the impression we are starting over the drawing
void mousePressed() {
  background(BACKGROUND_COLOR);
  
}

void mouseDragged() {
  background(OTHER_BACKGROUND); //CHANGED: added a function to the mouse when dragged on screen, it changes the background color and stays to that new color
}

 