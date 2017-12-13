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

  // The images that represents the ball, here, the shady quotes put into an array
  //Nina Parenteau helped me figure this part out
  PImage image;
  PImage p0,p1,p2,p3,p4,p5,p6,p7,p8,p9;
  PImage [] picArray = new PImage [10];
  
//this helps later to make sure the quote changes when the ball hits the paddle  
  int quotePointer;


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
    image = loadImage("images/shadeball.png");

//for loop that insures that the images in the array list change when the ball hits the paddle
// +i+ is a trick to change the images (named 1,2,3,4,5...) go one number up, thus change the image file
//done with the help of Nina Parenteau
for (int i = 0; i < picArray.length; i++) {
picArray[i]= loadImage("images/" +i+ ".png");
}
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
      //if loop to say if the ball's x position is bigger than the width, left player gains a point, and the 
      //shade rectangle's opacity gains 50 points of opacity(making it darker)
      
      if (x > width ) {
        scoreL += 1;
        player2Shade += 50; //helped by Nina Parenteau
        reset();
    }
    //if loop to say if the ball's x position is smaller than the width, right player gains a point, and the 
      //shade rectangle's opacity gains 50 points of opacity(making it darker)
    if (x < 0 ) {
        scoreR += 1;
        player1Shade += 50; //helped by Nina Parenteau
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
      //And make it bounce in opposite direction
      //and updates the pointer to change the quote to the next png file
      vx = -vx;
      quotePointer++; 
    }
  }

  // display()
  //
  // Draw the ball at its position

  void display() {
   imageMode(CENTER);
   image(picArray[quotePointer%10], x,  y, image.width, image.width);
  }
}