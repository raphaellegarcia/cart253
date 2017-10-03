// this sets the background color to black
color backgroundColor = color(0);

// this set of declarations set the amount, size (min and max) and color of the static background that flashes in white
int numStatic = 1000;
int staticSizeMin = 1;
int staticSizeMax = 3;
color staticColor = color(200);

// This series of declarations set the size, speed and color of the paddle
int paddleX;
int paddleY;
int paddleVX;
int paddleSpeed = 10;
int paddleWidth = 128;
int paddleHeight = 16;
color paddleColor = color(255);

// this set of declarations set the speed, size and color of the ball
int ballX;
int ballY;
int ballVX;
int ballVY;
int ballSpeed = 5;
int ballSize = 16;
color ballColor = color(255);


//This sets up the size of the window's background, the always-already presence of the paddle and ball
void setup() {
  size(640, 480);
  
  setupPaddle();
  setupBall();
 
}

// These lines declare the initial position of the paddle on screen, in the middle of the screen on the x axis, and away from the bottom vertically in the distance on the paddle's thickness, as well as a velocity of 0 pixels on the x axis
void setupPaddle() {
  paddleX = width/2;
  paddleY = height - paddleHeight;
  paddleVX = 0;
}

// these lines setup the position of the ball on screen in the middle on the x axis and in the middle on the y axis. It also sets the initial speed of the all both on the x and y axis.
void setupBall() {
  ballX = width/2;
  ballY = height/2;
  ballVX = ballSpeed;
  ballVY = ballSpeed;
}

//these lines make the background, static, paddle, and ball appear (draw) on screen
void draw() {
  background(backgroundColor);

  drawStatic();

  updatePaddle();
  updateBall();

  drawPaddle();
  drawBall();
}

//these lines declare the way in which the static is going to act on screen. It makes it appear in randome positions on screen, random size between 1 and 3 (max and min), its colour to white, and its shape (square)
void drawStatic() {
  for (int i = 0; i < numStatic; i++) {
   float x = random(0,width);
   float y = random(0,height);
   float staticSize = random(staticSizeMin,staticSizeMax);
   fill(staticColor);
   rect(x,y,staticSize,staticSize);
  }
}

//these lines set the boundaries of the paddle: the speed and constraints in which the paddle can navigate. So within the borders of the window on the x axis and at moving speed at every frame
void updatePaddle() {
  paddleX += paddleVX;  
  paddleX = constrain(paddleX,0+paddleWidth/2,width-paddleWidth/2);
}

// these lines declare that the ball's position will move on the x and y axis at the speed declared. As well as the ball's reaction when it hits the wall, the paddle or the bottom.
void updateBall() {
  ballX += ballVX;
  ballY += ballVY;
  
  handleBallHitPaddle();
  handleBallHitWall();
  handleBallOffBottom();
}

// this draws the paddle at the center, without a stroke, with the paddle's set fill colour, and its size
void drawPaddle() {
  rectMode(CENTER);
  noStroke();
  fill(paddleColor);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}

// this draws the ball at the center, without a stroke, with the ball's set fill colour, and its size
void drawBall() {
  rectMode(CENTER);
  noStroke();
  fill(ballColor);
  rect(ballX, ballY, ballSize, ballSize);
}

// this defines what happens when the ball hits the paddle: it changes direction on the Y axis to minus the direction it was going at, when the position of the ball touches the edge of the paddle mathematically declared here
void handleBallHitPaddle() {
  if (ballOverlapsPaddle()) {
    ballY = paddleY - paddleHeight/2 - ballSize/2;
    ballVY = -ballVY;
    staticColor = color(random(255),random(255),random(255)); //CHANGED: changes color of the static whenever the ball touches the paddle
  }
}

//this declares when the ball hits the side of the paddle, it should bounce back if it hits the top corner, and hit bottom if it hits anywhere else on the side than the top corner
boolean ballOverlapsPaddle() {
  if (ballX - ballSize/2 > paddleX - paddleWidth/2 && ballX + ballSize/2 < paddleX + paddleWidth/2) {
    if (ballY > paddleY - paddleHeight/2) {
      return true;
    }
  }
  return false;
}

//This declares that if the ball hits bottom, it re-appears at the middle of the height and width
void handleBallOffBottom() {
  if (ballOffBottom()) {
    ballX = width/2;
    ballY = height/2;
  }
}

// this is a loop that says, if the ball hits the bottom, it should go back to he initial launch position
boolean ballOffBottom() {
  return (ballY - ballSize/2 > height);
}

//this declares the reaction of the ball when it hits the wall, its velocity on the x axis becomes negative, and depending on if the ball comes from below or above, change the velocity of y to positive or negative
void handleBallHitWall() {
  if (ballX - ballSize/2 < 0) {
    ballX = 0 + ballSize/2;
    ballVX = -ballVX;
  } else if (ballX + ballSize/2 > width) {
    ballX = width - ballSize/2;
    ballVX = -ballVX;
  }
  
  if (ballY - ballSize/2 < 0) {
    ballY = 0 + ballSize/2;
    ballVY = -ballVY;
  }
}

// these line define that when the LEFT keyy is pressed, the paddle's velocity on X axis becomes negative (hence, moves to the left), UNLESS the key RIGHT is pressed, the velocity on X axis becomes positive (hence moves to the right)
void keyPressed() {
  if (keyCode == LEFT) {
    paddleVX = -paddleSpeed;
  } else if (keyCode == RIGHT) {
    paddleVX = paddleSpeed;
  }
}

// These lines define that when the keys are released, the paddle stops moving, hence its velocity on the x axis set to 0
void keyReleased() {
  if (keyCode == LEFT && paddleVX < 0) {
    paddleVX = 0;
  } else if (keyCode == RIGHT && paddleVX > 0) {
    paddleVX = 0;
  }
}