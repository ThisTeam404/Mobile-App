package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.Dialog;
import com.codename1.ui.events.ActionEvent;

public class ExitCommand extends Command{
	private GameWorld gw;
	public ExitCommand(GameWorld g)
	{
		super("Exit");
		gw = g;
	}
	public void actionPerformed(ActionEvent ev) {													//When exit button is clicked, the user will be asked whether to exit or not.
		Boolean bOk = Dialog.show("Confirm quit", "Are you sure you want to quit?", "Yes", "No");	//If the yes is clicked, the game ends. Else, they continue the game.
		if(bOk)
		{
			//gw.yes();
		}	
	}
}