// Ball
//
// A class that defines a ball that can move around in the window, bouncing
// of the top and bottom, and can detect collision with a paddle and bounce off that.

class Ball {

  /////////////// Properties ///////////////

  // Default values for speed and size
  int SPEED = 10;
  int SIZE = 40;

  // The location of the ball
  int x;
  int y;

  // The velocity of the ball
  int vx;
  int vy;

  // The colour of the ball
  //CHANGED TO LEMON YELLOW
  color ballColor = color(random(255),random(255),random(255));


  /////////////// Constructor ///////////////

  // Ball(int _x, int _y)
  //
  // The constructor sets the variable to their starting values
  // x and y are set to the arguments passed through (from the main program)
  // and the velocity starts at SPEED for both x and y 
  // (so the ball starts by moving down and to the right)
  // NOTE that I'm using an underscore in front of the arguments to distinguish
  // them from the class's properties

  Ball(int _x, int _y) {
    x = _x;
    y = _y;
    vx = SPEED;
    vy = SPEED;
  }


  /////////////// Methods ///////////////

  // update()
  //
  // This is called by the main program once per frame. It makes the ball move
  // and also checks whether it should bounce of the top or bottom of the screen
  // and whether the ball has gone off the screen on either side.

  
  void update() {
    // First update the location based on the velocity (so the ball moves)
    //CHANGED made the ball go faster vertically at every frame, it makes it bounce like a basket ball almost
    x += vx;
    y += vy++;
    //This makes the ball jitter from 9 pixels of difference on x and y axis. Inspired by the code of Tickle in https://processing.org/examples/tickle.html
    x += random(-9, 9);
    y += random(-9, 9);

    // Check if the ball is going off the top of bottom
    if (y - SIZE/2 < 0 || y + SIZE/2 > height) {
      // If it is, then make it "bounce" by reversing its velocity
      vy = -vy;
    }
    
    if (x + SIZE/2 < 0) {
     scoreL = scoreL +1; 
    }
    
    else if (x - SIZE/2 > width) {
     scoreR = scoreR+1; 
    }
    
    if (scoreL == winScore || scoreR == winScore){
     
    }
  }
  
  // reset()
  //
  // Resets the ball to the centre of the screen.
  // Note that it KEEPS its velocity
  
  void reset() {
    x = width/2;
    y = height/2;
    x += vx+1;
    y += vy+1;
    
  }
  
  // isOffScreen()
  //
  // Returns true if the ball is off the left or right side of the window
  // otherwise false
  // (If we wanted to return WHICH side it had gone off, we'd have to return
  // something like an int (e.g. 0 = not off, 1 = off left, 2 = off right)
  // or a String (e.g. "ON SCREEN", "OFF LEFT", "OFF RIGHT")
  
  boolean isOffScreen() {
    return (x + SIZE/2 < 0 || x - SIZE/2 > width);
 
  }

  // collide(Paddle paddle)
  //
  // Checks whether this ball is colliding with the paddle passed as an argument
  // If it is, it makes the ball bounce away from the paddle by reversing its
  // x velocity

  void collide(Paddle paddle) {
    // Calculate possible overlaps with the paddle side by side
    boolean insideLeft = (x + SIZE/2 > paddle.x - paddle.WIDTH/2);
    boolean insideRight = (x - SIZE/2 < paddle.x + paddle.WIDTH/2);
    boolean insideTop = (y + SIZE/2 > paddle.y - paddle.HEIGHT/2);
    boolean insideBottom = (y - SIZE/2 < paddle.y + paddle.HEIGHT/2);
    
    // Check if the ball overlaps with the paddle
    if (insideLeft && insideRight && insideTop && insideBottom) {
      // If it was moving to the left
      if (vx < 0) {
        // Reset its position to align with the right side of the paddle
        x = paddle.x + paddle.WIDTH/2 + SIZE/2;
      } else if (vx > 0) {
        // Reset its position to align with the left side of the paddle
        x = paddle.x - paddle.WIDTH/2 - SIZE/2;
      }
      // And make it bounce
      vx = -vx;
    }
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
    // Set up the appearance of the ball (no stroke, a fill, and rectMode as CENTER)
    //ADDED COLORED STROKE TO MAKE IT LOOK LIKE A LEMON SLICE
   
    stroke(255,216,0);
    strokeWeight(5);
    fill(ballColor);
    ellipseMode(CENTER);

    // Draw the ball
    ellipse(x, y, SIZE, SIZE);
  }
}