//fix mousePressed
//66
boolean endS;
boolean bWeapon = true;
boolean bShow = false;
boolean lShow = false;
boolean upKey, downKey;


int hp = 100;
int score = 0;



Star [] stars;
SpaceShip bob = new SpaceShip();
Health h1 = new Health();


ArrayList <Asteroid> asteroids;
ArrayList <Bullet> bullets;
ArrayList <Laser> l1;


public void setup() 
{
  endS = false;
  size(800,800);
  frameRate(100);

  stars = new Star[200];
  //asteroids = new Asteroid[15];
  for(int i=0; i<stars.length; i++)
  {
    stars[i] = new Star(0,0);
  }

// initializing the arraylists
  asteroids = new ArrayList <Asteroid>();
  bullets = new ArrayList <Bullet>();
  l1 = new ArrayList <Laser>();


//adding asteroids to the arraylist
  for(int i = 0; i<15 ; i++)
  {
    asteroids.add(i, new Asteroid());
  }

  /*
  for(int i = 0; i<asteroids.length;i++)
  {
    asteroids[i] = new Asteroid();
  }    
   */ 
}
public void draw() 
{


  background(0);
  fill(255);

  //display hp and score
  text("Your HP is: " + hp, 700,100);
  text("Your Score is: " + score,600, 150);

  //loop through star array calling the show function for each one
  for(int i=0; i<stars.length; i++)
  {
    stars[i].show();
    
  }

//show asteroids in the arraylist
  for(int i = 0; i<asteroids.size();i++)
  {
    asteroids.get(i).show();
    asteroids.get(i).move();
    
    //check for collision (asteroids and spaceship)
    if(dist((float)bob.getX(), (float)bob.getY(), (float)asteroids.get(i).getX(), (float)asteroids.get(i).getY())<23)
    {
      hp--;
    }
  
    
  }

    //check for collision (asteroids and bullets)  
    for(int i = 0; i<asteroids.size();i++)
    {
      for(int j=0; j<bullets.size();j++)
      {

        if(dist((float)asteroids.get(i).getX(), (float)asteroids.get(i).getY(), (float)bullets.get(j).getX(),(float)bullets.get(j).getY())<35)
        {
        asteroids.remove(i);
        bullets.remove(j);
        asteroids.add(new Asteroid());
        score += 10;
      }
      }
    }

  
//if spacebar is pressed, show and move the bullet
  if(bShow == true)
  {
    for(int i=0; i<bullets.size();i++)
    {
      bullets.get(i).show();
      bullets.get(i).move();
    }
  }

  if(lShow == true)
    {
      for(int i = 0 ; i<l1.size() ; i++)
      {
        l1.get(i).show();
      }
    
    }
  

  //show health and move the health when there's a collision
  h1.show();
  if(dist((float)bob.getX(), (float)bob.getY(), (float)h1.getX(), (float)h1.getY())<30)
  {
    h1.setX((int)(Math.random()*800));
    h1.setY((int)(Math.random()*800));
    hp +=5;
  }



//show spaceship and make arrow keys work
  bob.show();
  if(upKey == true)
  {

    //bob.setX((bob.getX()+(int)bob.getDirectionX()));
    //bob.setY((bob.getY()+(int)bob.getDirectionY()));
    bob.accelerate(.15);
  }
  else 
  {
    bob.setX((bob.getX()+(int)bob.getDirectionX()));
    bob.setY((bob.getY()+(int)bob.getDirectionY()));
  }

  if(downKey == true)
  {
    //bob.setX((bob.getX()+(-(int)bob.getDirectionX())));
    //bob.setY((bob.getY()+(-(int)bob.getDirectionY())));  
    bob.accelerate(-.15);
  }
  else
  {
    bob.setX((bob.getX()+(int)bob.getDirectionX()));
    bob.setY((bob.getY()+(int)bob.getDirectionY()));    
  }


  //wrapping
  if(bob.getX() < 0)
  {
    bob.setX(800);
  }
  if(bob.getX() > 800)
  {
    bob.setX(0);
  }  
  if(bob.getY() < 0)
  {
    bob.setY(800);
  }
  if(bob.getY() >800)
  {
    bob.setY(0);
  }



  if(hp<50)
  {
    noLoop();
    endScreen();
  }



}

public void draw2()
{

}


  public void endScreen()
  {
    endS = true;

    background(0);
    textSize(25);
    text("Your Final Score Is: " + score, 250,400);
    rect(350,450,100,50);
    fill(255,0,0);
    
    text("Restart",355,485);

  }

  public void mousePressed()
  {
    if(mouseX>350 && mouseX<450 && mouseY>450 && mouseY<500 && endS == true )
    {      
      textSize(15);

      //reinitialize variables
endS = false;

bWeapon = true;
bShow = false;
lShow = false;



hp = 100;
score = 0;



Star [] stars;
SpaceShip bob = new SpaceShip();
Health h1 = new Health();


ArrayList <Asteroid> asteroids;
ArrayList <Bullet> bullets;
ArrayList <Laser> l1;


      setup();
      redraw();
      
    }
  }


  public void keyPressed()
  {

    //arrow keys
    if(key == CODED)
    {
      if(keyCode ==LEFT)
      {
        bob.rotate(-10);
      }
      if(keyCode ==RIGHT)
      {
        bob.rotate(10);
      }
      if(keyCode ==UP)
      {
        upKey = true;
      }
      if(keyCode == DOWN)
      {
        downKey = true;
      }

    }

    //hyperspace
    if(key == 'z')
    {
      bob.setX((int)(Math.random()*800));
      bob.setY((int)(Math.random()*800));
      bob.setPointDirection((int)(Math.random()*361));
      bob.setDirectionX(0);
      bob.setDirectionY(0);

    }

    //switch weapon
    if(key == 'x')
    {
      if(bWeapon == true)
      {
        //weapon switches to lightning
        bWeapon = false;
      }
      else 
      {
        bWeapon = true;
      }

    }


    //shoot bullets or lasers with spacebar
    if(key == ' ')
    {
      if(bWeapon == true)
      {
        bullets.add(new Bullet(bob));
        bShow = true;        
      }

      else
      {

        l1.add(new Laser(bob));
        lShow = true;
      }
      }

  }
  public void keyReleased() //when up/down is released, inertia
  // when spacebar released when weapon is laser, lShow is false
  {
    if(key == CODED)
    {
      if(keyCode == UP)
      {
        upKey = false;
      }

      if(keyCode == DOWN)
      {
        downKey = false;
      }
    }
    /*
    if(key == ' ' && lShow == true)
    {
      lShow = false;        
    }
    */
  }


class Asteroid extends Floater
{
  private int rSpeed;
  public Asteroid()
  {
    
    corners = 8;
 
    int [] xS = {16,8,-8,-16,-16,-8,8,16};
    int [] yS = {8,16,16,8,-8,-16,-16,-8};
    xCorners = xS;
    yCorners = yS;
    myColor = color(175,50,50);
    myCenterX = Math.random() * 800;
    myCenterY = Math.random()*800;
    myDirectionX = (int)(Math.random()*5-2);
    myDirectionY = (int)(Math.random()*5-2);
    myPointDirection = 0;
    rSpeed = (int)(Math.random()*5-2);

  }

  public void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     
    myPointDirection+=rSpeed;   
    if(rSpeed == 0)
    {
      rSpeed = (int)(Math.random()*5-2);
    }
    if(myDirectionX == 0)
    {
      myDirectionX = (int)(Math.random()*5-2);
    }

    if(myDirectionY == 0)
    {
      myDirectionY = (int)(Math.random()*5-2);
    }

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }      
  }
  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;} 
  public void setY(int y){myCenterY= y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}  
  public double getPointDirection(){return myPointDirection;}
}


class Bullet extends Floater
{
  private double dRadians;
  public Bullet(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    dRadians =myPointDirection*(Math.PI/180);
    myDirectionX= 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY= 5 * Math.sin(dRadians) + theShip.getDirectionY();

  }


  public void show()
  {
    fill(255);
    ellipse((int)myCenterX,(int)myCenterY,10,10);
  }  

  public void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;      
  }


  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;} 
  public void setY(int y){myCenterY= y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}  
  public double getPointDirection(){return myPointDirection;}

}



class Health 
{
  private int myX,myY;
  public Health()
  {
    myX = (int)(Math.random()*800);
    myY = (int)(Math.random()*800);
  }

  public void setX(int x){myX = x;}
  public int getX(){return (int)myX;} 
  public void setY(int y){myY= y;}
  public int getY(){return (int)myY;}

  public void show()
  {
    strokeWeight(1);
    fill(0,255,0);
    ellipse(myX,myY,30,30);
  }

}



class Laser
{
  private int myCenterX, myCenterY;
  private int a,b;

  public Laser(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    a  = (int)(Math.random()*50)-25;
    b = (int)(Math.random()*50)-25; 
  }

  public void show()
  {
    strokeWeight(5);
    stroke((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));

    line(myCenterX, myCenterY,myCenterX+a, myCenterY-b);

    myCenterX = myCenterX + a ;
    myCenterY = myCenterY - b ;

    for(int i = 0 ; i<asteroids.size() ; i++)
    {
      fill(255,0,0);
      noStroke();
      line(myCenterX,myCenterY, asteroids.get(i).getX(), asteroids.get(i).getY());
    }
  
  }
}



class SpaceShip extends Floater  
{  

  public SpaceShip()
  {
    corners = 6;
 
    int [] xS = {20,-10,-20,-14,-20,-10};
    int [] yS = {0,12,12,0,-12,-12};
    xCorners = xS;
    yCorners = yS;
    myColor = color(255);
    myCenterX = 500;
    myCenterY = 500;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }

  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;} 
  public void setY(int y){myCenterY= y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}  
  public double getPointDirection(){return myPointDirection;}

}



class Star    
 {     
  private int myX, myY,col;

  public Star (int x, int y)
  {

    myX = (int)(Math.random()*1000);
    myY = (int)(Math.random()*1000);
    col = color((int)(Math.random()*256));
  }   

  public void show()
  {
    fill(col);
    ellipse(myX,myY,10,10);
  }
}


abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);
  abstract public int getX();
  abstract public void setY(int y);
  abstract public int getY();
  abstract public void setDirectionX(double x);
  abstract public double getDirectionX();
  abstract public void setDirectionY(double y);
  abstract public double getDirectionY();
  abstract public void setPointDirection(int degrees);
  abstract public double getPointDirection();

  // Accelerates the floater in the direction it is pointing (myPointDirection)  

  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move () // move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

