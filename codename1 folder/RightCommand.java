package com.mycompany.a190;

import com.codename1.ui.Command;
import com.codename1.ui.events.ActionEvent;

public class RightCommand extends Command{
	private GameWorld gw;
	public RightCommand(GameWorld g)
	{
		super("Right");
		gw = g;
	}
public void actionPerformed(ActionEvent ev) {
	//gw.changeHeading(2);																////A two is passed so changeHeading can move the ant to the right by 5 degrees.
	}
}

