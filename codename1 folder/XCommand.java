package com.mycompany.pageApp;

import com.codename1.ui.Command;
import com.codename1.ui.events.ActionEvent;
import com.mycompany.pageApp.PageActions;

public class XCommand extends Command{
	PageActions p;
	public XCommand(PageActions pg){
		super("Exit");
		p = pg;
	}
	@Override
	public void actionPerformed(ActionEvent e){
		System.out.println("Exiting...\n");
			p.ClosingApp();
	}

}
