package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.events.ActionEvent;

public class OneCommand extends Command{

	private Information info;
	public OneCommand(Information i)
	{
		super("1");
		info = i;
	}
	public void actionPerformed(ActionEvent ev) 
	{
		info.buttonSelected(1);
	}
}
