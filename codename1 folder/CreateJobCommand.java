package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.events.ActionEvent;

public class CreateJobCommand extends Command
{
	private MainPages m;
	public CreateJobCommand(MainPages mp)
	{
		super("Create Job");
		m = mp;
		
	}
	public void actionPerformed(ActionEvent ev) 
	{
		m.disableCreateJobButton();
		new App();
	}
}
