package com.mycompany.a190;

public interface IIterator {
	public boolean hasNext();				//This would allow a loop to see if there anything next to the object it is checking.
	public Object getNext();				//This would allow to grab the object next to the current object the loop is at.
}
