int mapSize = 500, 
speed = 2, 
score = 0, 
numFood, 
gridSize = 10, 
borderSize = 50;
float counter = 1;
Pac woman;
Maze maze;
ArrayList foods;
boolean[][] collisionMap;
PImage colMapImage;
///////////////////////////////classes

class Maze {
  float x, y, blockWidth, blockHeight;
  
  Maze (float xpos, float ypos, float widthValue, float heightValue)  {
    x = xpos;
    y = ypos;
    blockWidth = widthValue;
    blockHeight = heightValue;
  }
  
  void display(){
    fill (#009B95);
    rect (x, y, blockWidth, blockHeight);
  }
}

class Food {
  float x, y;
  float foodDiameter = 4;

  Food(float xpos, float ypos) {
    x = xpos;
    y = ypos;
  }

  void display() {
    fill (#E60042);
    ellipse (x, y, foodDiameter, foodDiameter);
  }
}

class Pac {
  int gridSpacing; 
  float circleWidth = 20, 
  circleX, 
  circleY, 
  bottomLip=PI/6, 
  topLip = 11*PI/6;
  boolean 
    notBlocked = false;

  Pac (float x, float y, int z, int speed) {
    circleX = x; 
    circleY = y;
    gridSpacing = z;
  }

  void display() {
    fill(255);
    arc (circleX, circleY, circleWidth, circleWidth, bottomLip+0.55*sin(counter), topLip-0.55*sin(counter));
  }

  void move() {
    if (keyPressed && (key == CODED)) {
      if (keyCode == LEFT) {
        bottomLip = 7*PI/6; 
        topLip = 17*PI/6;
        notBlocked = collisionMap[int(circleX -gridSize)][int(circleY)];
          if (notBlocked) {
          circleX-=gridSpacing;
        }
      } 
      else if (keyCode == RIGHT) {
        topLip = 11*PI/6; 
        bottomLip = PI/6;
        notBlocked = collisionMap[int(circleX +gridSize)][int(circleY)];
        if (notBlocked) {
          circleX+=gridSpacing;
        }
      }
    }
    if (keyPressed && (key ==CODED)) {
      if (keyCode == UP) {
        bottomLip = 10*PI/6; 
        topLip = 20*PI/6; 
        notBlocked = collisionMap[int(circleX)][int(circleY-gridSize)];
        if (notBlocked){
         circleY-=gridSpacing; 
        }
        
      } 
      else if (keyCode == DOWN) {
        bottomLip = 2*PI/3; 
        topLip = 14*PI/6;
        notBlocked = collisionMap[int(circleX)][int(circleY+gridSize)];
        if (notBlocked){
        circleY+=gridSpacing;
      }
      }
    }

    if (collisionMap [int (circleX)][int(circleY)] == true) {
      println ("no wall");
    } 
    else {
      println ("wall");
    }
  }
  void isonMap() {
    if (circleX > mapSize+borderSize) {
      circleX = borderSize;
    }
    if (circleY > mapSize+borderSize) {
      circleY = borderSize;
    }
    if (circleX < borderSize) {
      circleX = width - borderSize;
    }
    if (circleY < borderSize) {
      circleY = height - borderSize;
    }
  }
}
/////////////////////////////

void setup() {
  size(mapSize+2*borderSize, mapSize+2*borderSize);
  woman = new Pac (width/2, height/2, gridSize, speed);
  maze = new Maze (width/2, height/2, 30, 10);
  /* @pjs preload="/Arty_PacWoman/level_image7.jpg"; */
  //PImage colMapImage;
  colMapImage = loadImage("/Arty_PacWoman/level_image7.jpg");
  collisionArray();
  makeFoods();
}

void makeFoods() {
  foods = new ArrayList<Food>();
  for (int x = borderSize; x<mapSize+borderSize; x+= gridSize) {
    for (int y = borderSize; y< mapSize+borderSize; y+= gridSize) {
      if ((random(10)<4) && (collisionMap[x][y]==true))  {
        foods.add(new Food(x, y));
      
      }
    }
  }
}

void collisionArray() {
  collisionMap = new boolean[width][height];
  color black = color(0);
  color wall = color(0,155,149);

  //check the colour of each pixel in collisionMap and assign collisionMap boolean true or false
  for (int i = 0; i<width; i++) {
    for (int j = 0; j < height; j++) {
      color c = colMapImage.get(i, j);
      if (c==wall) {
        collisionMap[i][j] = false;
      }
      else {
        if (c == black) {
          collisionMap [i][j] = true;
        }
      }
    }
  }
}

////////////////////////////////
void draw() {
  noStroke();
  background(255);
  fill(0);
  rect(borderSize-20, borderSize-20, mapSize+40, mapSize+40);
  image (colMapImage,0,0);
  counter += 0.15;

  for (int i=0; i<foods.size(); i++) {
    Food myFood = (Food)foods.get(i);
    myFood.display();
  }

 // maze.display();
  woman.display();
  woman.move();
  woman.isonMap();
  checkIsFoodEaten();
  drawScore();
 
}


void drawScore() {
  fill(0);
  if (foods.size() == 0) {
    fill(255);
    text("You win!", width/2, height/2);
  } 
  else {
    text("Your score is " + score, width - 150, height - borderSize/4);
  }
}

void checkIsFoodEaten() {

  for (int i=0; i<foods.size(); i++) {
    Food myFood = (Food)foods.get(i);
    if (myFood.x < (woman.circleX + woman.circleWidth/4) && 
      myFood.x > (woman.circleX - woman.circleWidth/4) &&
      myFood.y < (woman.circleY + woman.circleWidth/4) && 
      myFood.y > (woman.circleY - woman.circleWidth/4)) {
      foods.remove(i);
      score++;
      break;
    }
  }
}