package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.events.ActionEvent;

public class SK1Command extends Command{

	private Information info;
	public SK1Command(Information i)
	{
		super("SK1");
		info = i;
	}
	public void actionPerformed(ActionEvent ev) 
	{
		info.disableSK1Button();
	}
}
