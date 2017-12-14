//Artist Statement: RuPong
// For this proposed game, I decided to create a version of Pong inspired by the TV series RuPaul's Drag
// Race. My approah toward this game was to implement a part of the drag queen show's culture: readings. 
// Every read is pretty much a "diss" directed toward another drag queen, commenting on their looks, their intelligence, background etc.
//This adaption of Pong mixed with RuPaul’s Drag Race, is a game that not only gives a wink to the classic game and the epic TV show, but also, in retrospective, gives you a visual 
//adaption and sense of the act of “throwing shade”. While being part of the drag queen culture, and also being quite funny sometimes, through this game, one may realize how othering 
//these words can be. From a personal experience, playing the game the few times was quite funny. And then it turned sour, as it made me realize the verbal violence used by people in
//a community seeking to be free of boxes. This realization came about during a conversation on the matter with classmates of CART. For a game that aimed to be as funny as when we laugh 
//at all the jokes the queens say, to realizing the impact words deemed entertaining can have on individuals, I believe the aspect of interactivity between machine and real world realization
//has done its job. 
//This game starts with only two drag queens selected randomly, Eureka O’Hara and Sasha Velour, throwing shade at each other (quoted from all the drag queens from the show).
//In terms of design, the techniques that have been used to code the game were with the use of arrays, collisions, if statements, for loops, modulos image loads etc. 
//All in their simplest and clear forms in order to get the desired results. 
//When a player hits the ball, a new quote appears, meaner than the previous one. When a drag queen misses the ball, their side of the game becomes a shade darker, as though 
//they truly have been shaded on. This dark area becomes as pitch as black when they miss too many balls, where the player cannot see its character’s position in space, nor 
//where the ball is located, forcing them to lose the game.

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
//Logo taken from the TV Show
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
  } else if (gameState == "LOSE") {
    loseGame();
  }
}

//Gives position, colour and text size of both scores
void scores() {
  fill (255);
  textSize(30);
  text(scoreL, 100, 50);
  text(scoreR, width-100, 50); 
}

//Puts the image of rupaul as initial background image when the game starts
void startGame() {
   ruStart = loadImage("images/ruStart.png");
  background(ruStart); 
}

//defines components of the game state play
void playGame() {
  background(backgroundImage);
  scores();
  
//update paddles and ball  
  leftPaddle.update();
  rightPaddle.update();
  ball.update();

//check if there is a collision between ball and paddles
  ball.collide(leftPaddle);
  ball.collide(rightPaddle);
  
//check if ball is off screen
  leftPaddle.display();
  rightPaddle.display();
  ball.display();

//defines (color and position) the rectangle of shade hovering on player 1  
  fill(0,0,0,player1Shade);
  rect(0,0,width-720,1080);
  
//defines (color and position) the rectangle of shade hovering on player 2  
  fill(0,0,0,player2Shade);
  rect(720,0,720,1080);
  
//declares if score from left player wins, the game state changes to WIN  
  if(scoreL == winScore) {
    gameState = "WIN";
 }

//declares if score from right player wins, the game state changes to LOSE 
  if(scoreR == winScore) {
    gameState = "LOSE";
 }
}

//puts image of Sasha Velour as background if she wins the shade battle as well as puts the button on which to click
//to restart the game
void winGame() {
  velour = loadImage("images/velour.png");
  background(velour);
  
 //button
  fill(255,181,255);
  rect(350,380,100,60);
  
  //condition to restart the game, click in the box with these coordinates
    if(mousePressed==true && mouseX > 350 && mouseX < 450 && mouseY > 380 && mouseY < 440) {
      resetGame();
  } 
}

//puts image of Eureka O'Hara as background if she wins the shade battle as well as puts the button on which to click
//to restart the game
void loseGame() {
  eureka = loadImage("images/eureka.png");
  background(eureka);
//button
  fill(255,181,255);
  rect(350,380,100,60);
  
//condition to restart the game, click in the box with these coordinates
   if(mousePressed==true && mouseX > 350 && mouseX < 450 && mouseY > 380 && mouseY < 440) {
    resetGame();
  }
}

//turns the score values and opacity levels of the black rectangles back to 0, and change the game state to START
void resetGame() {
    gameState = "START";
    scoreL = 0;
    scoreR = 0;
    player1Shade = 0;
    player2Shade = 0;
}

//clears background
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

//When mouse clicks on the start screen, turns the game state to PLAY
void mouseClicked() {
  gameState = "PLAY";
} 



//Sources
//Logo RuPaul: "Queens of RuPaul’s Drag Race invade Montreal". See. Montreal Rampage. Nicole Yeba. 26 February. 2015. http://montrealrampage.com/queens-of-rupauls-drag-race-invade-montreal/
//Start Page photo: "RuPaul Has So Many Creative Names to Call Donald Trump". W Magazine. March 19th 2017. https://www.wmagazine.com/story/rupaul-drag-race-season-9-lady-gaga
//Sasha Velour image: "Drag Race Champion Sasha Velour on the Moment She Thought She Might Go Home" Cosmopolitan. June 26 2017. http://www.cosmopolitan.com/entertainment/tv/a10222844/sasha-velour-drag-race-interview/
//Eureke O'Hara image: "Last Words With Drag Race's Eureka O'Hara",The Advocate. April 22nd 2017. https://www.advocate.com/television/2017/4/22/last-words-drag-races-eureka-ohara
//RUPaul Theme Song: "RuPaul's Drag Race Theme Song". Youtube. Uploaded by Antonio Lopez, March 4th 2011. https://www.youtube.com/watch?v=B4vsWgECZ6s