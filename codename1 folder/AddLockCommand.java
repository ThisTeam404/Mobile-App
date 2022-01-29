package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.events.ActionEvent;

public class AddLockCommand extends Command{

	private MainPages m;
	public AddLockCommand(MainPages mp)
	{
		super("Add Lock");
		m = mp;
	}
	public void actionPerformed(ActionEvent ev) 
	{
		m.disableAddLockButton();
		new App2();
	}
}
