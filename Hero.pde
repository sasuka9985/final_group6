class Hero{
float hp;
int x = width/2;
int y = height/2;
int speed = 3;
int gunNum;
String nowDirection = "Down";
PImage heroImg;
Hero(int x , int y ){
  this.x = x;
  this.y = y;
}

void display(){
  heroImg = loadImage("img/player"+nowDirection+".png");
  image(heroImg,x,y);
    if (isMovingUp) {
      this.move(Direction.UP);
      nowDirection = "Up";
    }
    if (isMovingDown) {
      this.move(Direction.DOWN);
      nowDirection = "Down";
    }
    if (isMovingLeft) {
      this.move(Direction.LEFT);
      nowDirection = "Left";
    }
    if (isMovingRight) {
      this.move(Direction.RIGHT);
      nowDirection = "Right";
    }
}

void move(int direct){
  switch (direct) {
      case Direction.UP:
        this.y-= speed;
       
        break;
      case Direction.DOWN:
        this.y+= speed;
        
        break;
      case Direction.LEFT:
        this.x-= speed;
        
        break;
      case Direction.RIGHT:
        this.x+= speed;
        
        break;
      }
}


}