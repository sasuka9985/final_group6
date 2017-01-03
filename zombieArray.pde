boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;
PImage block;
float bX1,bY1,bX2,bY2;

//---------------------計時器--------------------------//
int savedTime;
int passedTime;
int totalTime = 50;
//---------------------計時器--------------------------//

Hero hero;

int zombieMax = 300;//最大殭屍數量
int zombieNow = 0;
Zombie[] zombieArray = new Zombie[zombieMax];

int gunMax = 5;//預計要寫五支槍
int gunLimit = 3;//第n支槍還不能用
int gunNow = 0;
Gun[] gunArray = new Gun[gunMax];

Treasure treasure;

class Direction
{
  static final int LEFT = 0;
  static final int RIGHT = 1;
  static final int UP = 2;
  static final int DOWN = 3;
}


void setup(){
size(640, 480);
hero = new Hero(width/2,height/2);
treasure = new Treasure();
block = loadImage("img/block.png");
bX1 = 150;
bY1 = 150;
bX2 = 300;
bY2 = 150;
frameRate(60);
//---------------------計時器--------------------------//
  savedTime = millis();
//---------------------計時器--------------------------//
}

void draw(){
  background(#D6C38F);
//---------------------計時器--------------------------//
  //if(Timer()==true){println("ok"+frameCount);}這一段不太懂
  passedTime = millis()-savedTime;
//---------------------計時器--------------------------//
  //Block
  image(block,bX1,bY1);
  image(block,bX2,bY2);
  
  //Treasure
  treasure.display();
  treasure.eaten();
  
  //Hero
  hero.display();
  hero.move(isMovingUp,isMovingDown,isMovingLeft,isMovingRight);
  
  //Gun
  if(gunArray[gunNow] != null){
    gunArray[gunNow].display();
  }
  
  
  //Zombie
  for (int i=0; i<zombieNow; i++){
    if(zombieArray[i].x != width && zombieArray[i].y != height){
      zombieArray[i].move();
      zombieArray[i].display();
      zombieArray[i].hpCheck();
      if(hero.shooting){
        if(zombieArray[i].shooted(hero.nowDirectionNum, i)){
          zombieArray[i].hp -= gunArray[gunNow].power;
          hero.shooting = false;
          println(zombieArray[i].hp);
        }
      }
    }
  }
}

/*-----------------操控--------------------*/
void keyPressed() {
  switch(keyCode) {
  case UP : 
    isMovingUp = true ;
    hero.nowDirectionNum =Direction.UP;
    break ;
  case DOWN : 
    isMovingDown = true ;
    hero.nowDirectionNum =Direction.DOWN;
    break ;
  case LEFT : 
    isMovingLeft = true ; 
    hero.nowDirectionNum =Direction.LEFT;
    break ;
  case RIGHT : 
    isMovingRight = true ;
    hero.nowDirectionNum =Direction.RIGHT;
    break ;
  default :
    break ;
  }
  
  if(key == ' '){
    gunArray[gunNow].stopCount();
    if(gunArray[gunNow].stop1 == false && gunArray[gunNow].stop2 == false){
      hero.shooting = true;
      //println("shoot"+num+"frame"+frameCount);
      //num++;
      gunArray[gunNow].bulletNow --;
      gunArray[gunNow].stop1 = true;
      gunArray[gunNow].stop2 = true;
    }
  }
  
  //槍枝變換 從1號開始 跟鍵盤按鍵、圖片編號一致
  if(key>='1' && key<='9'){
    gunNow = key-48;
    if(gunNow < gunLimit){
      if(gunArray[gunNow] == null){
        gunArray[gunNow] = new Gun(gunNow);
      }
    }
  }
  if(key == 'z'){
    if(zombieNow < zombieMax){
      zombieArray[zombieNow] = new Zombie();
      zombieNow++;
      println(zombieNow);
    }
  } 
}

void keyReleased() {
  switch(keyCode) {
  case UP : 
    isMovingUp = false ;
    break ;
  case DOWN : 
    isMovingDown = false ; 
    break ;
  case LEFT : 
    isMovingLeft = false ; 
    break ;
  case RIGHT : 
    isMovingRight = false ; 
    break ;
  default :
    break ;
  }
  if(key == ' '){
    hero.shooting = false;
  }
}

//---------------------計時器--每隔totalTime秒回傳一次true(單位毫秒)---//
boolean Timer(int totalTime, boolean startNow){
  if(startNow == true){
    passedTime = millis()-savedTime;
  }
    if(passedTime>totalTime){
      savedTime = millis();
      return true;
    }
  return false;
}
//---------------------計時器--------------------------//