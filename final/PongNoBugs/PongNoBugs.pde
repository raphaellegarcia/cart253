//Artist Statement: RuPong
// For this proposed game, I decided to create a version of Pong inspired by the TV series RuPaul's Drag
// Race. My approah toward this game was to implement a part of the drag queen show's culture: readings. 
// Every read is pretty much a "diss" directed toward another drag queen, commenting on their looks, their intelligence, background etc.
//

//Variables for the paddles and the ball
Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;

// The images to use in the different game states, start, play, win and lose as well as the font
PImage backgroundImage;
PImage ruStart;
PImage velour;
PImage eureka;
PFont font;

// The distance of the paddle from the edge, the start scores and the win score
int PADDLE_INSET = 32;
int scoreL = 0;
int scoreR = 0;
int winScore = 6;

// the background colour as well as the colors used for the black rectangles (shade) opacity
// see later to understand the black rectangles
color backgroundColor = color(0);
color player1Shade = color(0,0,0,0);
color player2Shade = color(0,0,0,0);

// String used to define multiple game states
String gameState;

//The song that plays annoyingly in the background
import processing.sound.*;
SoundFile file;
String audioName = "themesong.mp3";
String path;

// Sets the size of the game window, the size of text, the font
void setup() {
  size(1440, 1080);  
  textSize(20);
  fill(255,10,150);
  font = loadFont("8bit.vlw");
  textFont(font);

//declares the first game state
  gameState = "START";

//creates the paddles, defines the inset, position, image and the keys to move the paddles
  leftPaddle = new Paddle(PADDLE_INSET, height/2, "images/drag1.png", '1', 'q');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, "images/drag2.png", '0', 'p');
  
// creates the ball and its initial position  
  ball = new Ball(width/2, height/2);

//loads the background image  
  backgroundImage = loadImage("images/BOARD.png");

//loads the background song  
  path = sketchPath("themesong.mp3");
  file = new SoundFile(this, path);
  file.loop();
}

//draws continuously the game states deoending on which one is supposed to appear 
void draw() {

  if (gameState == "START") {
    startGame();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN") {
    winGame();
  } 
  else if (gameState == "LOSE") {
    loseGame();
  }
}


void scores() {
  fill (255);
  textSize(30);
  text(scoreL, 100, 50);
  text(scoreR, width-100, 50); 
}

void startGame() {
   ruStart = loadImage("images/ruStart.png");
  background(ruStart); 
}

void playGame() {
  background(backgroundImage);
  scores();
  leftPaddle.update();
  rightPaddle.update();
  ball.update();

  ball.collide(leftPaddle);
  ball.collide(rightPaddle);

  leftPaddle.display();
  rightPaddle.display();
  ball.display();
  
  fill(0,0,0,player1Shade);
  rect(0,0,width-720,1080);
  
  fill(0,0,0,player2Shade);
  rect(720,0,720,1080);
  
  
  if(scoreL == winScore) {
    gameState = "WIN";
 }
 
  if(scoreR == winScore) {
    gameState = "LOSE";
 }
}

void winGame() {
  velour = loadImage("images/velour.png");
  background(velour);
//  background(125,10,152);
//   fill(255);
//   text("Sashay Away! \n You just got R-E-A-D Honey!", width/4,height/2);
//   text("Want some more? \n Click anywhere to start again!", width/4-100,height/2 + 150);
   fill(200);
   rect(350,380,100,60);
  if(mousePressed==true && mouseX > 350 && mouseX < 450 && mouseY > 380 && mouseY < 440) {
    resetGame();
  } 
}

void loseGame() {
  eureka = loadImage("images/eureka.png");
  background(eureka);
  
//  background(200,100,10);
//   fill(255);
//   text("SLAYYYY!! YAS QUEEN!", width/4,height/2);
//   text("Want some more? Click anywhere to start again!", width/4-100,height/2 + 150);
   fill(200);
  rect(350,380,100,60);
   
   if(mousePressed==true && mouseX > 350 && mouseX < 450 && mouseY > 380 && mouseY < 440) {
    resetGame();
  }
}

void resetGame() {
    gameState = "START";
    scoreL = 0;
    scoreR = 0;
    player1Shade = 0;
    player2Shade = 0;
}

void clearBackground() {
}

void keyPressed() {
  // Just call both paddles' own keyPressed methods
  leftPaddle.keyPressed();
  rightPaddle.keyPressed();
  
}

void keyReleased() {
  // Call both paddles' keyReleased methods
  leftPaddle.keyReleased();
  rightPaddle.keyReleased();
}

void mouseClicked() {
  gameState = "PLAY";
} 