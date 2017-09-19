// This line gives the value of the speed at which the circle will move in the sketch. It is an integer of 7
final int CIRCLE_SPEED = 7; 
final color NO_CLICK_FILL_COLOR = color(250, 100, 100);
final color CLICK_FILL_COLOR = color(100, 100, 250);
final color BACKGROUND_COLOR = color(250, 150, 150);
final color STROKE_COLOR = color(250, 150, 150);
final int CIRCLE_SIZE = 50;

int circleX;
int circleY;
int circleVX;
int circleVY;

void setup() {
  size(640, 480);
  circleX = width/2;
  circleY = height/2;
  circleVX = CIRCLE_SPEED;
  circleVY = CIRCLE_SPEED;
  stroke(STROKE_COLOR);
  fill(NO_CLICK_FILL_COLOR);
  background(BACKGROUND_COLOR);
}

void draw() {
    if (dist(mouseX, mouseY, circleX, circleY) < CIRCLE_SIZE/2) {
    fill(CLICK_FILL_COLOR);
  }
  else {
    fill(NO_CLICK_FILL_COLOR);
  }
  ellipse(circleX, circleY, CIRCLE_SIZE, CIRCLE_SIZE);
  circleX += circleVX;
  circleY += circleVY;
  if (circleX + CIRCLE_SIZE/2 > width || circleX - CIRCLE_SIZE/2 < 0) {
    circleVX = -circleVX;
  }
  if (circleY + CIRCLE_SIZE/2 > height || circleY - CIRCLE_SIZE/2 < 0) {
    circleVY = -circleVY;
  }
}
// This means that when the mouse is pressed, the background color is prompted and covers the drawings mades by the circle, giving the impression that it has been reinitialized
void mousePressed() {
  background(BACKGROUND_COLOR);
}