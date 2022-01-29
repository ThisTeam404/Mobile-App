package com.mycompany.a190;

import java.util.Observable;
import java.util.Random;
import java.util.Vector;

import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.Display;

public class GameWorld extends Observable{
	private GameObjectCollection theGameCollection;							//Initialization for theGameCollection, time, and lives
	private int time, lives, width, height;									//lives, width, and height
	public GameWorld()
	{
		time = 0;
		lives = 3;
	}
	public void init(/*int w, int h*/) 											//initializes all the objects
	{
		/*theGameCollection = new GameObjectCollection();			//Makes the game "reset" when the ant loses a life when it is equal to zero.
		width = w;
		height = h;
		Random rn = new Random();								//Random variable needed to declare a random number for some of the locations, size, heading, and speed.
		Flag flag1 = new Flag(10, 0.0f, 0.0f, 1);  				//Size, locationX, locationY, sequenceNum
		Flag flag2 = new Flag(10, 500.0f, 0.0f, 2);
		Flag flag3 = new Flag(10, 500.0f, 500.0f, 3);
		Flag flag4 = new Flag(10, 200.0f, 500.0f, 4);
		Ant ant = Ant.getAnt();									//The numbers such as size, location, and so on are declared in the Ant's constructor.
		Spider spider1 = new Spider(3 + rn.nextInt(18), rn.nextInt(501), rn.nextInt(501), rn.nextInt(360), 5 + rn.nextInt(5));  	//size, locationX, locationY, heading, speed 
		Spider spider2 = new Spider(3 + rn.nextInt(18), rn.nextInt(501), rn.nextInt(501), rn.nextInt(360), 5 + rn.nextInt(5));
		FoodStation food1 = new FoodStation(5 + rn.nextInt(16), rn.nextInt(501), rn.nextInt(501), 1); 								//size, locationX, locationY, FoodStation number
		FoodStation food2 = new FoodStation(2 + rn.nextInt(16), rn.nextInt(501), rn.nextInt(501), 2);
		theGameCollection.add(flag1);							//all of the objects will be stored in theGameCollection
		theGameCollection.add(flag2);
		theGameCollection.add(flag3);
		theGameCollection.add(flag4);
		theGameCollection.add(ant);
		theGameCollection.add(spider1);
		theGameCollection.add(spider2);
		theGameCollection.add(food1);
		theGameCollection.add(food2);*/

	}
	/*public int getTime()									//getters for time, lives, width, height, and theGameCollection
	{
		return time;
	}
	public int getLives()
	{
		return lives;
	}
	public int getWidth()
	{
		return width;
	}
	public int getHeight()
	{
		return height;
	}
	public GameObjectCollection getTheGameCollection()
	{
		return theGameCollection;
	}
	public void setTime(int t)								//setters for time, lives, width, and height
	{
		time = t;
	}
	public void setLives(int l)
	{
		lives = l;
	}
	public void setWidth(int w)
	{
		width = w;
	}
	public void setHeight(int h)
	{
		height = h;
	}*/

	
	/*public void accelerate() 											//Ant accelerates to the max speed or a little bit.
	{
		IIterator theElements = theGameCollection.getIterator();
		GameObject a = null;
		boolean flag = true;
		while(theElements.hasNext() && flag) {							//The while loop will find the ant object
			a = (GameObject) theElements.getNext();
			if(a instanceof Ant)										//When the ant is found, the flag becomes false and the program
			{															//gets out of the while loop.
				flag = false;
			}
		}
		if(((Ant)a).getSpeed() < ((Ant)a).getMaxSpeed()) {
			if(((Ant)a).getFoodLevel() >= 70 && ((Ant)a).getHealth() == 10)	//If everything is full, the Speed is at max.
			{
				((Ant)a).setSpeed(((Ant)a).getMaxSpeed());
				System.out.println("The spider is about to accelerate.");
			}
			else
			{
				double a1 = (((Ant)a).getFoodLevel()/70.0);
				double b2 = (((Ant)a).getHealth()/10.0);
				double c = (a1 + b2)/2;
				double d = (((Ant)a).getSpeed() * c) + ((Ant)a).getSpeed();
				int num = (int) d;
				if(num >= ((Ant)a).getMaxSpeed())						//Depending on the level of food level and health, the ant may accelerate is a little.
				{
					((Ant)a).setSpeed(((Ant)a).getMaxSpeed());
				}
				else
				{
					((Ant)a).setSpeed(num);
				}
				System.out.println("The spider is about to accelerate.");
			}
		}
		else													//If the ant tries to accelerate when it is at max speed, it can not go any faster.
		{
			System.out.println("The spider can't accelerate any further.");
		}
		setChanged();											//setChanged and notifyObservers are called to
		notifyObservers();										//let the observers know that the Ant's speed is changed.
	}
	public void brake() 					//The ant's speed would slow down.	
	{
		IIterator theElements = theGameCollection.getIterator();
		GameObject a = null;
		boolean flag = true;
		while(theElements.hasNext() && flag) {					//The while loop will find the ant object
			a = (GameObject) theElements.getNext();
			if(a instanceof Ant)								//When the ant is found, the flag becomes false and the program
			{													//gets out of the while loop.
				flag = false;
			}
		}
		if(((Ant)a).getSpeed() > 0)
		{
			if(((Ant)a).getSpeed() - 4 <= 0)					//If the speed goes below zero, it will be set to zero.
			{
				((Ant)a).setSpeed(0);
				System.out.println("The speed is at 0.");
				setChanged();
				notifyObservers();
				return;
			}
			((Ant)a).setSpeed(((Ant)a).getSpeed() - 4);			//The ant's speed would slow down.
			System.out.println("Brakes are applied.");
			setChanged();
			notifyObservers();
			return;
		}
		System.out.println("The speed is at 0.");
		setChanged();											//setChanged and notifyObservers are called
		notifyObservers();										//to let the observers know that the Ant's speed is changed.
	}
	public void changeHeading(int num) 		//The heading will change depending on the user wants to go left (1) or right (2).
	{ 
		IIterator theElements = theGameCollection.getIterator();
		GameObject a = null;
		boolean flag = true;
		while(theElements.hasNext() && flag) {					//The while loop will find the ant object
			a = (GameObject) theElements.getNext();
			if(a instanceof Ant)								//When the ant is found, the flag becomes false and the program
			{													//gets out of the while loop.
				flag = false;
			}
		}
		if(num == 1)						//The ant will move left by 5 degrees.
		{
			((Ant)a).changeHeading(-5);
			System.out.println("The ant moved to the left by 5 degrees.");
		}
		else 								//The ant will move right by 5 degrees.
		{
			((Ant)a).changeHeading(5);
			System.out.println("The ant moved to the right by 5 degrees.");
		}
		setChanged();											//setChanged and notifyObservers are called
		notifyObservers();										//to let the observers know that the Ant's heading is changed.
		
	}
	public void antAtFlag(int num) 				//When the ant is near the correct flag, the lastFlagReach variable is incremented by one.
	{
		IIterator theElements = theGameCollection.getIterator();
		GameObject a1 = null;
		GameObject a = null;
		GameObject f = null;
		boolean flag = false;
		int n = 1;
		while(theElements.hasNext()) {							//The while loop will find the ant and flag objects.
			a1 = (GameObject) theElements.getNext();
			if(a1 instanceof Ant)								
			{
				a = a1;
			}
			if(n == num)
			{
				flag = true;
			}
			if(a1 instanceof Flag && flag)						//When the correct Flag is found, the boolean flag becomes false and the program
			{													//will not go to this if statement.
				f = a1;	
				flag = false;
			}
			n++;
		}
		double x = Math.abs(((Flag)f).getLocationX() - ((Ant)a).getLocationX());
		double y = Math.abs(((Flag)f).getLocationY() - ((Ant)a).getLocationY());
		int s = a.getSize() + f.getSize();
		if(x <= s &&  y <= s && ((Ant)a).getLastFlagReach() == ((Flag)f).getSequenceNumber())				//When the ant is near the correct flag, the lastFlagReach variable is incremented by one. 
		{
			System.out.println("The ant has reached flag number " + ((Ant)a).getLastFlagReach() +".");
			((Ant)a).setLastFlagReach(((Ant)a).getLastFlagReach() + 1);
		}
		else
		{
			System.out.println("The ant is not at the correct flag.");
		}
		if(((Ant)a).getLastFlagReach() == 5)		//When the ant goes to all 4 flags, the user wins the game.
		{
			System.out.println("Game over, you win! Total time: " + getTime());
			try {
				Thread.sleep(4000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.exit(0);
		}
		setChanged();								//setChanged and notifyObservers are called
		notifyObservers();							//to let the observers know that thelastFlagReach number is changed.
		
	}
	public void antAtFoodStation()			//When the ant is near one of the foodStations, the ant's food level increases.
	{
		IIterator theElements = theGameCollection.getIterator();
		GameObject a1 = null;
		GameObject a = null;
		GameObject fs1 = null;
		GameObject fs2 = null;
		boolean flag = true;
		boolean flag2 = true;
		while(theElements.hasNext() && (flag || flag2)) {			//The while loop will find the ant and both foodStations objects.
			a1 = (GameObject) theElements.getNext();
			if(a1 instanceof Ant)
			{
				a = a1;
				flag = false;
			}
			else if(a1 instanceof FoodStation)						//When both foodStations are found, the both boolean flags
			{														//becomes false and the program gets out of the while loop.
				if(fs1 == null)
				{
					fs1 = a1;
					flag = false;
				}	
				else if(fs2 == null)
				{
					fs2 = a1;
					flag2 = false;
				}
			}
		}
			

		double x = Math.abs(((FoodStation)fs1).getLocationX() - ((Ant)a).getLocationX());
		double y = Math.abs(((FoodStation)fs1).getLocationY() - ((Ant)a).getLocationY());
		double x2 = Math.abs(((FoodStation)fs2).getLocationX() - ((Ant)a).getLocationX());
		double y2 = Math.abs(((FoodStation)fs2).getLocationY() - ((Ant)a).getLocationY());
		int s = ((Ant)a).getSize() + ((FoodStation)fs1).getSize();
		if(((FoodStation)fs1).getCapacity() >= 0 && x <= s && y <= s)			//When the ant is near one of the foodStations, the ant's food level increases.
		{
			((Ant)a).setFoodLevel(((Ant)a).getFoodLevel() + 10);
			((FoodStation)fs1).foodEaten();
			((FoodStation)fs1).setColor(ColorUtil.red(((FoodStation)fs1).getColor())-25,0,0);
			System.out.println("The ant's food meter has increased.");
		}
		else if(((FoodStation)fs2).getCapacity() >= 0 && x2 <= s && y2 <= s)
		{
			((Ant)a).setFoodLevel(((Ant)a).getFoodLevel() + 10);
			((FoodStation)fs2).foodEaten();
			((FoodStation)fs2).setColor(ColorUtil.red(((FoodStation)fs2).getColor())-25,0,0);
			System.out.println("The ant's food meter has increased.");
		}
		else													//If the ant is not at a foodStation, the user will be informed that they are not near a foodStation.
		{
			System.out.println("The ant is not at a foodstation with food.");
		}
		if(((FoodStation)fs1).getCapacity() == 0)								//After the Ant is finished with the food at a foodStation, one of them would be replaced.
		{
			addFoodStation(1); 
		}
		else if(((FoodStation)fs2).getCapacity() == 0)
		{
			addFoodStation(2); 
		}
		setChanged();						//setChanged and notifyObservers are called to let the observers know that one of the foodStations is changed.
		notifyObservers();
	}
	public void antDamaged()				//The ant get hurt, max speed is decreased, ant could lose a life, and the game could end.
	{
		IIterator theElements = theGameCollection.getIterator();
		GameObject a = null;
		boolean flag = true;
		while(theElements.hasNext() && flag) {							//The while loop will find the ant object.
			a = (GameObject) theElements.getNext();
			if(a instanceof Ant)										//When the ant is found, the flag becomes false and the program
			{															//gets out of the while loop.
				flag = false;
			}
		}
		((Ant)a).setHealth(((Ant)a).getHealth() - 1);					
		((Ant)a).setMaxSpeed(((Ant)a).getMaxSpeed() - 1);
		if(((Ant)a).getMaxSpeed() < ((Ant)a).getSpeed())				//As the ant get hurt, the MaxSpeed is decreased.
		{
			((Ant)a).setSpeed(((Ant)a).getMaxSpeed());
		}
		System.out.println("The ant was damaged.");
		((Ant)a).setColor(0,0,ColorUtil.blue(a.getColor())-15);
		if(((Ant)a).getHealth() == 0)									//The current Ant loses a life and a new one is created and placed at (0,0).
		{
			if(getLives() >= 1)											//The ant's variables are reset.
			{
				((Ant)a).setHealth(10);
				((Ant)a).setColor(0,0,255);
				((Ant)a).setSpeed(10);
				((Ant)a).setMaxSpeed(20);
				((Ant)a).setFoodLevel(70);
				((Ant)a).setLocationX(0.0f);
				((Ant)a).setLocationY(0.0f);
				((Ant)a).setHeading(0);
			}
			init(getWidth(),getHeight());
			lives--;
			System.out.println("The ant has died.");
		}
		if(lives == 0)											//If the lives are at zero, the game ends with the message being displayed for 4 seconds.
		{
			System.out.println("Game over, you failed!");
			try {
				Thread.sleep(4000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			Display.getInstance().exitApplication();
		}
		setChanged();						//setChanged and notifyObservers are called to let the observers know that some of the Ant's variables are changed.
		notifyObservers();
	}
	public void gameClock() 				//The clock increments by one second and the ant and spiders move.
	{
		setTime(getTime() + 1);
		IIterator theElements = theGameCollection.getIterator();
		GameObject a = null;
		while(theElements.hasNext()) {				//The while loop will find all movable objects objects.
			a = (GameObject) theElements.getNext();
			if(a instanceof Movable) 				//When it finds the movable objects,
			{										//it will both the ant and spiders move.
				Movable a2 = (Movable) a;
				if(a2 instanceof Spider)
				{
					Random rn = new Random();
					int r = rn.nextInt(3);
					if(r == 0)						//Before the spider moves, it randomly changes the heading by adding or subtracting by 5 or no change.
					{
						a2.setHeading(a2.getHeading() - 5);
					}
					else if(r == 1)
					{
						a2.setHeading(a2.getHeading() + 5);
					}
				}
				if(a2 instanceof Ant)
				{
					((Ant) a2).setFoodLevel((((Ant) a2).getFoodLevel() - ((Ant) a2).getFoodConsumptionRate()));			//When the ant moves, the food level goes down.
					if(((Ant) a2).getFoodLevel() == 0)			//When the ant's food level is at zero, both the speed and food level is at zero and can not move.
					{
						a2.setSpeed(10);
						((Ant)a).setMaxSpeed(20);
						((Ant)a2).setColor(0,0,255);
						((Ant)a2).setHealth(10);
						setLives(getLives() - 1);
						init(getWidth(), getHeight());								//The game restarts when the ant's health go to zero.
						System.out.println("The ant is too hungry to keep going.");
						a2.setLocationX(0);
						a2.setLocationY(0);
						if(getLives() == 0)											//If the lives are at zero, the game ends with the message being displayed for 4 seconds.
						{
							System.out.println("Game over, you failed!");
							try {
								Thread.sleep(4000);
							} catch (InterruptedException e) {
								e.printStackTrace();
							}
							Display.getInstance().exitApplication();
						}
					}
				}
				a2.move(getWidth(), getHeight());				//The spiders and ant move to a new location.
				if(a2 instanceof Ant && ((Ant)a2).getFoodLevel() == 0)
				{
					((Ant)a2).setFoodLevel(70);
					a2.setLocationX(0.0f);
					a2.setLocationY(0.0f);
					a2.setHeading(0);
				}
			}
		}
		System.out.println("The ant and spiders are moving.");
		setChanged();						//setChanged and notifyObservers are called to let the observers
		notifyObservers();					//know that ant and spider's move, time, heading, and foodLevel changed.
	}
	public void map() 						//Calls the toString() from the every element in theGameCollection.
	{
		IIterator theElements = theGameCollection.getIterator();
		while(theElements.hasNext()) {
			GameObject spo = (GameObject) theElements.getNext();
			System.out.println(spo.toString());
		}	
		System.out.println(); 				//To make the output easier to read.
	}
	public void addFoodStation(int num)		//When this method is called the gameObjects are put into a dummy vector variable and
	{										//theGameCollection is reinitialized and the gameObjects are given back, except for the 
		Random rn = new Random();			//empty foodStation. A replacement would be added.
		Vector <GameObject> gameObjects = new Vector();				//A dummy vector variable
		IIterator theElements = theGameCollection.getIterator();
		while(theElements.hasNext()) {								//The gameObjects are put into the vector
			GameObject spo = (GameObject) theElements.getNext();
			gameObjects.add(spo);
		}
		theGameCollection = new GameObjectCollection();				//theGameCollection is reinitialized
		for(int i = 0; i < gameObjects.size(); i++)					//The gameObjects are given back to the GameCollection
		{															//if the for loop finds an empty foodStation, a replacement
			((FoodStation)gameObjects.get(7)).getNumber();			//will be added instead of the empty one.
			if(gameObjects.get(i) instanceof FoodStation && num == 1 && ((FoodStation)gameObjects.get(i)).getCapacity() == 0)
			{
				theGameCollection.add(new FoodStation(2 + rn.nextInt(16), rn.nextInt(501), rn.nextInt(501), 1));
			}
			else if(gameObjects.get(i) instanceof FoodStation && num == 2 && ((FoodStation)gameObjects.get(i)).getCapacity() == 0)
			{
				theGameCollection.add(new FoodStation(2 + rn.nextInt(16), rn.nextInt(501), rn.nextInt(501), num));
			}
			else
			{
				theGameCollection.add(gameObjects.get(i));
			}
		}
	}
	public void yes() 									//When the user wants to exit the program, this method is called.
	{
		Display.getInstance().exitApplication();	
	}*/
}
