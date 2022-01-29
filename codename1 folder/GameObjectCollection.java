package com.mycompany.a190;

import java.util.Vector;

public class GameObjectCollection {
	private Vector theCollection;
	public GameObjectCollection()
	{
		theCollection = new Vector();
	}
	public void add(Object newObject)								//This would allow the gameObjectCollection class to add an object in a vector.	
	{
		theCollection.addElement(newObject);
	}
	public IIterator getIterator()									//This would be used to access the gameObjectCollection.
	{
		return new GameVectorIterator();
	}
private class GameVectorIterator implements IIterator {
		private int currElementIndex;
		public GameVectorIterator()
		{
			currElementIndex = -1;
		}
		public boolean hasNext()									//This would allow a loop to see if there anything next to the object it is checking.
		{
			if(theCollection.size() <= 0)
			{
				return false;
			}
			if(currElementIndex == theCollection.size() - 1)
			{
				return false;
			}
			return true;
		}
		public Object getNext() 									//This would allow to grab the object next to the current object the loop is at.
		{
			currElementIndex ++;
			return(theCollection.elementAt(currElementIndex));
		}
	}
}

