// Ball
class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 5;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // The image that represents the ball
  PImage image;
  PImage p0,p1,p2,p3,p4,p5,p6,p7,p8,p9;
  PImage [] picArray = new PImage [10];


  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // Loads an image of Shaquille O'Neal as the image of the ball
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties

  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    vx = SPEED;
    vy = SPEED;
    image = loadImage("Desktop/PongNoBugs/data/images/shadeball.png");
    p0 = loadImage("Desktop/PongNoBugs/data/images/0.png");
    p1 = loadImage("Desktop/PongNoBugs/data/images/1.png");
    p2 = loadImage("Desktop/PongNoBugs/data/images/2.png");
    p3 = loadImage("Desktop/PongNoBugs/data/images/3.png");
    p4 = loadImage("Desktop/PongNoBugs/data/images/4.png");
    p5 = loadImage("Desktop/PongNoBugs/data/images/5.png");
    p6 = loadImage("Desktop/PongNoBugs/data/images/6.png");
    p7 = loadImage("Desktop/PongNoBugs/data/images/7.png");
    p8 = loadImage("Desktop/PongNoBugs/data/images/8.png");
    p9 = loadImage("Desktop/PongNoBugs/data/images/9.png");
    picArray[0] = p0;
    picArray[1] = p1;
    picArray[2] = p2;
    picArray[3] = p3;
    picArray[4] = p4;
    picArray[5] = p5;
    picArray[6] = p6;
    picArray[7] = p7;
    picArray[8] = p8;
    picArray[9] = p9;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  void update() {
    // First update the location based on the velocity (so the ball moves)
    x += vx;
    y += vy;

    // Check if the ball is going off the top of bottom
    if (y - image.width/2 < 0 || y + image.width/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
 
      }
      if (x > width ) {
        scoreL += 1;
        reset();
    }
    if (x < 0 ) {
        scoreR += 1;
        reset();
    }
  }
  
  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity
  
  void reset() {
    x = width/2;
    y = height/2;
  }
  
  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window
  // otherwise false
  // (If we wanted to return WHICH side it had gone off, we'd have to return
  // something like an int (e.g. 0 = not off, 1 = off left, 2 = off right)
  // or a String (e.g. "ON SCREEN", "OFF LEFT", "OFF RIGHT")
  
  boolean isOffScreen() {
    return (x + image.width/2 < 0 || x - image.width/2 > width);
  }

  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + image.width/2 > paddle.x - paddle.image.width/2);
    boolean insideRight = (x - image.width/2 < paddle.x + paddle.image.width/2);
    boolean insideTop = (y + image.width/2 > paddle.y - paddle.image.height/2);
    boolean insideBottom = (y - image.width/2 < paddle.y + paddle.image.height/2);
    
    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.image.width/2 + image.width/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.image.width/2 - image.width/2;
      }
      // And make it bounce
      vx = -vx;
      image(picArray[int(random(picArray.length))],x,y,image.width,image.width);
    }
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
   imageMode(CENTER);
   image(picArray[int(random(picArray.length))],x,y,image.width,image.width);
  }
}