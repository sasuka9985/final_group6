class Zombie{
float hp;
int x = 0;
int y = 0;
int speed = 1;
int direction;
String nowDirection = "Down";
PImage zombieImg;

Zombie(int x, int y){
  this.x = x;
  this.y = y;
  
}

void display(){
  zombieImg = loadImage("img/zombie"+nowDirection+".png");
  image(zombieImg,x,y);
  zombie.move();
}

void move(){
  if(x<hero.x){
    x += speed;
    nowDirection = "Right";
  }
  if(x>hero.x){
    x -= speed;
    nowDirection = "Left";
  }
  if(y<hero.y){
    y += speed;
    nowDirection = "Down";
  }
  if(y>hero.y){
    y -= speed;
    nowDirection = "Up";
  }
}


}