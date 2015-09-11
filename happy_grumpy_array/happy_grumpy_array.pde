void mouth (float x, float y) {
  noFill();
  float s;
  boolean underHalf;
  boolean smax;
  underHalf = (mouseY>y)? true:false;
  if (underHalf) {
    s = (mouseY - y);
  } else
  {
    s = (y - mouseY);
  }
  smax = (s>50)? true:false;
  if (smax) {
    s=50;
  };
  noFill();
  stroke(0);
  if (underHalf) {
    arc(x, y+10, 45, s/2, 0, PI) ;
  } else
    arc(x, y+10, 45, s/2, PI, TWO_PI);
}

void eye (float x, float y) {
  boolean smiling;
  if (mouseY > y) {
    smiling = true;
  } else {
    smiling = false;
  }
  if (smiling) {
    fill(255, 255, 255) ;
  } else {
    fill(255, 0, 0) ;
  }
  ellipse (x, y, 10, 10);

  fill (0, 0, 0);
  ellipse ((x-3) + (mouseX/90.0), (y-2) + (mouseY/85.0), 2, 2);
}

class Face {
  float x=width/2, y=height*0.25;
  int faceSize = 100;
  boolean overFace = false, locked=false;


  void start(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    fill(255, 62, 210);
    ellipse (x, y, faceSize, faceSize);
    eye (x+20, y-20);
    eye (x-20, y-20);
    mouth (x, y);
  }

  void move() {

    if (y>(0.6)*height) {
      x = x+random (-4, 4);
    }
    fill(255, 62, 210);
    ellipse (x, y++, faceSize, faceSize);
    eye (x+20, y-20);
    eye (x-20, y-20);
    mouth (x, y);
  }
}




Face [] faces; //Face is the object, faces is the array
int numFaces = 5;
int currentFace = 0;
int r, g, b;
boolean overFace = false;
boolean faceLocked;
float bdifx = 0.0;
float bdify = 0.0;
float bx;
float by;
Face hoverFace = null;



void setup () {
  size (640, 360);
  smooth ();
  r = 29;
  g = 182;
  b = 85;
  bx = width/2.0;
  by = height/2.0;
  faces = new Face[numFaces];  //create the array
  for (int i = 0; i< numFaces; i++) {
    faces [i] = new Face();    //create each object in the array
  }
}

void draw() {


  make_background();
  make_Faces();
  //  move_Faces();
  overFace = check_if_overFace();
  println(currentFace);
}


void make_background() {
  float colorMultiplier = 1 - (mouseX / (float)width);
  background(r * colorMultiplier, g * colorMultiplier, b * colorMultiplier);
}

void make_Faces() { 

  //  if (currentFace < numFaces-1) {
  //    if (frameCount % 300 == 0) {
  faces[currentFace].start(width/2, height*0.25);
  //      currentFace+=1;
  //      
  //    }
  //  }
}

//void move_Faces() {
//  if (!faceLocked) {
//    for (int i = 0; i< numFaces; i++) {
//      faces[i].move();
//    }
//  } else {
//    println ("is locked");
//  }
//  
//}


boolean check_if_overFace() {
  boolean OF = false;
  for (int i = 0; i< faces.length; i+=1) {
    Face myFace = (Face)faces[i];
    if (
      mouseX > myFace.x- (myFace.faceSize/2) 
      && mouseX < myFace.x + (myFace.faceSize/2) 
      && mouseY > myFace.y - (myFace.faceSize/2)
      && mouseY < myFace.y + (myFace.faceSize/2)) 
    {
      OF = true;
      hoverFace = (Face)faces[i];
    }
  }
  return OF;
}


void mousePressed() {
  if (overFace) { 
    faceLocked = true;
  } else {

    faceLocked = false;
  }
  if (hoverFace != null) {
    bdifx = mouseX-hoverFace.x; 

    bdify = mouseY-hoverFace.y;
  }
}

void mouseDragged() {

  if (faceLocked) {
    print ("mousedragged");
    if (hoverFace != null) {
      hoverFace.x = mouseX-bdifx; 

      hoverFace.y = mouseY-bdify;
    }
  }
}




void mouseReleased() {

  faceLocked = false;
}