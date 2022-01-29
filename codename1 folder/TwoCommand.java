package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.events.ActionEvent;

public class TwoCommand extends Command{

	private Information info;
	public TwoCommand(Information i)
	{
		super("2");
		info = i;
	}
	public void actionPerformed(ActionEvent ev) 
	{
		info.buttonSelected(2);
	}
}
