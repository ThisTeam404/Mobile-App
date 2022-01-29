package com.mycompany.a190;

import java.util.Vector;

import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.*;
import com.codename1.ui.layouts.BorderLayout;
import com.codename1.ui.layouts.FlowLayout;
import com.codename1.ui.plaf.Border;

public class App2 extends Form{
	private Toolbar myToolBar = new Toolbar();
	private MainPages sv;
	private DataTableInfo dt;
	public App2()
	{
		sv = new MainPages(2);
		dt = new DataTableInfo();
		setToolbar(myToolBar);	
		this.setLayout(new BorderLayout());
		Vector <Button> myButtons = new Vector();					//A vector myButtons for the buttons.

		Button one = new Button("Delete");
		Button two = new Button("Duplicate");

		
		myButtons.add(one);											//Buttons are added in myButtons
		myButtons.add(two);
		
		
		LogoffCommand mylogoff = new LogoffCommand();
		myToolBar.addCommandToRightSideMenu(mylogoff);
		
		
		setToolbar(myToolBar);																	//Toolbar is setup.
		this.setTitle("LockThatDown");	
		
		Container bottomContainer = new Container(new FlowLayout(Component.CENTER));
		
		for(int i = 0; i < myButtons.size(); i++)																//In the for loop, the buttons would get these characteristics
		{																										//and will go to the appropriate container
			myButtons.get(i).setEnabled(false);
			
			myButtons.get(i).getDisabledStyle().setBgTransparency(255);
			myButtons.get(i).getDisabledStyle().setBgColor(ColorUtil.WHITE);
			myButtons.get(i).getDisabledStyle().setFgColor(ColorUtil.BLUE);
			myButtons.get(i).getDisabledStyle().setBorder(Border.createLineBorder(2, ColorUtil.BLUE));
			
			myButtons.get(i).getAllStyles().setPadding(Component.TOP, 2);
			myButtons.get(i).getAllStyles().setPadding(Component.BOTTOM, 2);
	
			bottomContainer.add(myButtons.get(i));
			
		}
		
		
		
		
		
		
		
		add(BorderLayout.NORTH, sv);															//the left, bottom, and right container, sv, and mv 
		add(BorderLayout.CENTER, dt);															//are added to certain parts of the simulator
		add(BorderLayout.SOUTH, bottomContainer);
		this.show();
		
		
	}
}
