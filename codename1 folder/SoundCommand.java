package com.mycompany.a190;

import com.codename1.ui.CheckBox;
import com.codename1.ui.Command;
import com.codename1.ui.Toolbar;
import com.codename1.ui.events.ActionEvent;

public class SoundCommand extends Command {
	private App myForm;
	private Toolbar myToolBar;
	public SoundCommand (App fForm, Toolbar tb)
	{
		super("Sound");
		myForm = fForm;
		myToolBar = tb;
	}

	public void actionPerformed(ActionEvent evt){
		/*if (((CheckBox)evt.getComponent()).isSelected())									//When the sound checkbox is checked or unchecked, the
			myForm.setCheckStatusVal(true);													//side menu is closes.
		else
			myForm.setCheckStatusVal(false);
		myToolBar.closeSideMenu();*/
	}
}
