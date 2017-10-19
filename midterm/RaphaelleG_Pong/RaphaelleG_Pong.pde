// Pong
//
// A simple version of Pong using object-oriented programming.
// Allows to people to bounce a ball back and forth between
// two paddles that they control.
//
// No scoring. (Yet!)
// No score display. (Yet!)
// Pretty ugly. (Now!)
// Only two paddles. (So far!)

//I learned how to add the score on this link by Tanay Singhal
//https://www.youtube.com/watch?v=Xdeih9syh4I

// Global variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// The distance from the edge of the window a paddle should be
int PADDLE_INSET = 8;

// The background colour during play (black)
color backgroundColor = color(0);

int scoreL = 0;
int scoreR = 0;
int winScore = 3;
int speedX = 5;
int speedY = 5;

//Declares the new image for the background and the new font
PImage bg;
PFont font;


// setup()
//
// Sets the size and creates the paddles and ball

void setup() {
  // Set the size: CHANGED TO 1920 x 1080
  size(1920, 1080);
  
  
  //Declares the size, alignment, loads the fon in the data folder
  textSize(40);
  textAlign(CENTER,CENTER);
  font = loadFont("Faster.vlw");
  textFont(font);
  
  //declares the file for the background
  bg = loadImage("scared.png");
  // Create the paddles on either side of the screen. 
  // Use PADDLE_INSET to to position them on x, position them both at centre on y
  // Also pass through the two keys used to control 'up' and 'down' respectively
  // NOTE: On a mac you can run into trouble if you use keys that create that popup of
  // different accented characters in text editors (so avoid those if you're changing this)
  leftPaddle = new Paddle(PADDLE_INSET, height/2, 'w', 's');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, 'o', 'l');

  // Create the ball at the centre of the screen
  ball = new Ball(width/2, height/2);
}

// draw()
//
// Handles all the magic of making the paddles and ball move, checking
// if the ball has hit a paddle, and displaying everything.

void draw() {
  // Fill the background each frame so we have animation
  background(bg);
  scores();
  gameOver();
 

  // Update the paddles and ball by calling their update methods
  leftPaddle.update();
  rightPaddle.update();
  ball.update();

  // Check if the ball has collided with either paddle
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);

  // Check if the ball has gone off the screen
  if (ball.isOffScreen()) {
    // If it has, reset the ball
    ball.reset();
  }
  

  // Display the paddles and the ball
  leftPaddle.display();
  rightPaddle.display();
  ball.display();
}

// keyPressed()
//
// The paddles need to know if they should move based on a keypress
// so when the keypress is detected in the main program we need to
// tell the paddles

//declares the position of the scores and color
void scores() {
  fill(255,216,0);
  text(scoreR,100,50);
  text(scoreL, width-100,50);
}

void gameOver(){
 if(scoreL == winScore) {
  
   text("Left wins!", CENTER, CENTER);
   text("Click to play again", CENTER,CENTER - 50);
   speedX = 0;
   speedY = 0;
   scoreL = 0;
   scoreR = 0;
 }
  if(scoreR == winScore) {
    
  text("Right wins!", CENTER, CENTER);
   text("Click to play again", CENTER,CENTER - 50);
   speedX = 0;
   speedY = 0;
   scoreL = 0;
   scoreR = 0;
 }
 if(mousePressed) {
   scoreR = 0;
   scoreL = 0;
   speedX = 5;
   speedY = 5;
 }
}


void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
}

// keyReleased()
//
// As for keyPressed, except for released!

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}

void mousePressed(){
 
}