Paddle leftPaddle;
Paddle rightPaddle;
Ball ball;


PImage backgroundImage;
PFont font;


int PADDLE_INSET = 32;
int scoreL = 0;
int scoreR = 0;
int winScore = 6;

color backgroundColor = color(0);
color player1Shade = color(0,0,0,0);
color player2Shade = color(0,0,0,0);


String gameState;

import processing.sound.*;
SoundFile file;
String audioName = "themesong.mp3";
String path;


void setup() {
  size(1440, 1080);  
  textSize(20);
  fill(255,10,150);
  font = loadFont("8bit.vlw");
  textFont(font);

  gameState = "START";

  leftPaddle = new Paddle(PADDLE_INSET, height/2, "images/drag1.png", '1', 'q');
  rightPaddle = new Paddle(width - PADDLE_INSET, height/2, "images/drag2.png", '0', 'p');
  
  ball = new Ball(width/2, height/2);
  
  backgroundImage = loadImage("Desktop/PongNoBugs/data/images/BOARD.png");
  
  path = sketchPath("themesong.mp3");
  file = new SoundFile(this, path);
  file.loop();
}


void draw() {

  if (gameState == "START") {
    startGame();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN") {
    winGame();
  } else if (gameState == "LOSE") {
    loseGame();
  }
}

// void startGame() {
//   textAlign(CENTER);
//   textSize(18);
//   fill(255,0,0);
//   text("Click Anywhere to Play!", width/2, height/2);

//   if (mousePressed==true){
//     gameState = "PLAY";
//   }
// }

void scores() {
  fill (255);
  text(scoreL, 100, 50);
  text(scoreR, width-100, 50);
  
  
}

void startGame() {
  background(backgroundImage); 
  text("click anywhere to start", width/2-500, height/2);
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
   background(100,100,100);
   fill(255);
   text("Sashay Away! You just got R-E-A-D Honey!", width/4,height/2);
   text("Want some more? Click anywhere to start again!", width/4-100,height/2 + 150);  
 }
 
  if(scoreR == winScore) {
   background(100,100,100);
   fill(255);
   text("SLAYYYY!! YAS QUEEN!", width/4,height/2);
   text("Want some more? Click anywhere to start again!", width/4-100,height/2 + 150);
   
 }
}

void winGame() {
  if(mousePressed==true) {
    gameState = "START";
  } 
}

void loseGame() {
   if(mousePressed==true) {
    gameState = "START";
  }
}

void resetGame() {
     if(mousePressed==true) {
    gameState = "START";
  }
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