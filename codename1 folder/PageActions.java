package com.mycompany.pageApp;

import java.util.Observable;

import com.codename1.ui.Dialog;
import com.codename1.ui.Display;

public class PageActions extends Observable{
	
	void enterKeyNum() {
		System.out.println("Key Num Entered: \n");
		setChanged();
		notifyObservers();
	}
	
	/**
	 *  Exit command invoked will call method exitApplication()
	 *  if confirmed. 
	 */
	public void ClosingApp(){
		Boolean bOk = Dialog.show("Confirm Quit", "Are you sure you want to quit?", "OK", "Cancel");
		
		if(bOk){
			Display.getInstance().exitApplication();
		}
	}
}
