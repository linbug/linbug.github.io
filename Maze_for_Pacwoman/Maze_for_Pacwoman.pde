int mapSize = 450, 
score = 0, 
numFood, 
gridSize = 30, 
borderSize = 50;
int [][] mazeArray;
float counter = 1;
Pac woman;
ArrayList foods;
Enemy [] enemies; //Enemy is the object, enemies is the array
int numEnemies = 5;

///////////////////////////classes

int[][] loadMaze() {
    
    mazeArray = new int [15][15];
    mazeArray[0] = new int[] { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
    mazeArray[1] = new int[] { 1,0,1,0,1,1,0,1,0,1,1,1,1,1,1};
    mazeArray[2] = new int[] { 1,0,1,0,0,0,0,1,0,0,0,0,0,0,1};
    mazeArray[3] = new int[] { 1,0,0,0,1,1,0,0,0,1,1,1,1,0,1};
    mazeArray[4] = new int[] { 1,0,1,1,1,1,0,1,1,1,1,1,1,0,1};
    mazeArray[5] = new int[] { 1,0,1,1,1,1,0,0,1,1,1,0,0,0,1};
    mazeArray[6] = new int[] { 1,0,0,0,1,1,1,0,1,1,1,1,0,1,1};
    mazeArray[7] = new int[] { 1,1,1,0,1,0,0,0,1,0,1,1,0,1,1};
    mazeArray[8] = new int[] { 1,1,1,0,1,0,1,1,1,0,1,1,0,1,1};
    mazeArray[9] = new int[] { 1,1,1,0,0,0,1,1,1,0,1,1,0,1,1};
    mazeArray[10] = new int[] { 1,1,1,1,0,1,1,1,1,0,1,0,0,1,1};
    mazeArray[11] = new int[] { 1,1,1,1,0,1,1,0,0,0,0,0,1,1,1};
    mazeArray[12] = new int[] { 1,1,1,1,0,0,0,0,1,1,1,1,1,1,1};
    mazeArray[13] = new int[] { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
    mazeArray[14] = new int[] { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};
    
    return mazeArray;
}

void makeMaze(){
  for (int i = 0; i <= 14 ; i++) {
    
    for (int j = 0; j <= 14 ; j++) {
      
      if (mazeArray[j][i] == 1) {
        fill (#009b95);
        rectMode(CORNER);
        rect(borderSize+(gridSize*i), borderSize+(gridSize*j), gridSize, gridSize);
        
      }
    }
  }
}

class Food {
  float gridX, gridY;
  float foodDiameter = 4;

  Food(float x, float y) {
    gridX = x;
    gridY = y;
  }

  void display() {
    fill (#E60042);
    ellipse (borderSize + gridSize/2+ (gridX*gridSize),  borderSize+ gridSize/2+(gridY*gridSize), foodDiameter, foodDiameter);
  }
}

class Enemy {
  int squareWidth = 10;
  float squareX, 
  squareY;

  void start (float x, float y) {
    squareX = x;
    squareY = y;
  } 

  void display() {
    fill(255);
    rect (squareX, squareY, squareWidth, squareWidth);
  }
}

class Pac {
  int gridSpacing, 
  gridX, 
  gridY; 

  float circleWidth = gridSize - 5, 

  bottomLip=PI/6, 
  topLip = 11*PI/6;
  boolean notBlocked = true;
  
  Pac (int x, int y, int z) {
    gridX = x; 
    gridY = y;
    gridSpacing = z;
  }

  void display() {
      fill(255);                 
      ellipseMode(CENTER);
      if (keyPressed && (key == CODED)) {
        arc (borderSize+gridSize/2+ (gridSize*gridX), borderSize+ gridSize/2+(gridSize*gridY), circleWidth, circleWidth, bottomLip, topLip);
      } else {
        arc (borderSize+gridSize/2+ (gridSize*gridX), borderSize+ gridSize/2+(gridSize*gridY), circleWidth, circleWidth, bottomLip+0.55*sin(counter), topLip-0.55*sin(counter));
      }
    }
  
  
  void move() {
    if (keyPressed && (key == CODED)) {
      if (keyCode == LEFT) {
        bottomLip = 7*PI/6; 
        topLip = 17*PI/6;

        if (mazeArray[gridY][gridX-1] == 0) {
          notBlocked = true;
        } else {
          notBlocked = false;
        }
        //notBlocked = collisionMap[int(gridX -gridSize)][int(gridY)];

        if (notBlocked) {
          gridX-=1;
        }
      } else if (keyCode == RIGHT) {
        topLip = 11*PI/6; 
        bottomLip = PI/6;
        if (mazeArray[gridY][gridX+1] == 0) {
          notBlocked = true;
        } else {
          notBlocked = false;
        }
        //notBlocked = collisionMap[int(gridX +gridSize)][int(gridY)];
        if (notBlocked) {
          gridX+=1;
        }
      }
    }

    if (keyPressed && (key ==CODED)) {
      if (keyCode == UP) {
        bottomLip = 10*PI/6; 
        topLip = 20*PI/6;
        if (mazeArray[gridY-1][gridX] == 0) {
          notBlocked = true;
        } else {
          notBlocked = false;
        }

        if (notBlocked) {
          gridY-=1;
        }
      } else if (keyCode == DOWN) {
        bottomLip = 2*PI/3; 
        topLip = 14*PI/6;
        if (mazeArray[gridY+1][gridX] == 0) {
          notBlocked = true;
        } else {
          notBlocked = false;
        }

        if (notBlocked) {
          gridY+=1;
        }
      }
      //delay(200);
    }
  }
}

/////////////////////

void setup() {
  size(mapSize+2*borderSize, mapSize+2*borderSize);
  noStroke();
  rect(borderSize-20, borderSize-20, mapSize+40, mapSize+40);
  woman = new Pac (1, 1, gridSize);
  mazeArray = loadMaze();
  makeFoods();
  makeEnemies();
}

void makeFoods() {
  foods = new ArrayList<Food>();
  for (int i = 0; i <= 14; i++) {

    for (int j = 0; j <= 14; j++) {

      if (mazeArray[j][i] == 0) {
        ellipseMode(CENTER);
        foods.add(new Food(i, j));
      }
    }
  }
}


void makeEnemies() {
  enemies = new Enemy[numEnemies];  //create the array
  for (int i = 0; i< numEnemies; i++) {
    enemies [i] = new Enemy();
    enemies[i].start(random(0, width), random(0, height));
  }
}



void draw() {
  
  counter += 0.15;
  noStroke();
  background(#ef1d74);
  fill(0);
  rect(borderSize-20, borderSize-20, mapSize+40, mapSize+40);
  makeMaze();
  displayFoods();
  woman.display();
  woman.move();
  checkIsFoodEaten();
//  drawEnemies();
  drawScore();
}


void displayFoods() {
  for (int i=0; i<foods.size (); i++) {
    Food myFood = (Food)foods.get(i);
    myFood.display();
  }
}


void checkIsFoodEaten() {

  for (int i=0; i<foods.size (); i++) {
    Food myFood = (Food)foods.get(i);
    if ((myFood.gridX == woman.gridX) &&
      (myFood.gridY == woman.gridY )) {
      foods.remove(i);
      score++;
      break;
    }
  }
}


//Draw enemies on map
void drawEnemies() {
  for (int i = 0; i< numEnemies; i++) { 
    enemies[i].display();
  }
}

void drawScore() {
  textSize(20);
  fill(0);
  if (foods.size() == 0) {
    
    text("You win!", width/2 - 25, height - borderSize/4);
  } else 
  {
    textSize(12);
    text("Your score is " + score, width - 150, height - borderSize/4);
  }
}