package com.mycompany.a190;

public interface ICollection {
	public void add(Object newObject);		//This would allow the GameObjectCollection class to add an object in a vector.
	public IIterator getIterator();			//This would be used to access the gameObjectCollection.
}
