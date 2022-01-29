package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.events.ActionEvent;

public class ThreeCommand extends Command{

	private Information info;
	public ThreeCommand(Information i)
	{
		super("3");
		info = i;
	}
	public void actionPerformed(ActionEvent ev) 
	{
		info.buttonSelected(3);
	}
}
