package com.mycompany.a190;

import java.util.Vector;

import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.events.ActionEvent;
import com.codename1.ui.events.ActionListener;
import com.codename1.ui.layouts.BorderLayout;
import com.codename1.ui.layouts.FlowLayout;
import com.codename1.ui.layouts.GridLayout;
import com.codename1.ui.layouts.Layout;
import com.codename1.ui.layouts.BoxLayout;
import com.codename1.ui.plaf.Border;
import com.codename1.ui.*;

public class App extends Form{
		private GameWorld gw;
		private MainPages sv;
		private Information info;
		private Toolbar myToolBar = new Toolbar();
		public App() {
			gw = new GameWorld();
			sv = new MainPages(1);							//checkStatusVal goes to sv, so it can post it on the simulator.
			info = new Information();
			gw.addObserver(sv);
			this.setLayout(new BorderLayout());
			Vector <Button> myButtons = new Vector();					//A vector myButtons for the buttons.

			Button a = new Button("Confirm");
			Button b = new Button("Cancel");
			
			myButtons.add(a);											//Buttons are added in myButtons
			myButtons.add(b);
			
			
			setToolbar(myToolBar);																	//Toolbar is setup.
			this.setTitle("LockThatDown");															//Title for the game
			

			LogoffCommand mylogoff = new LogoffCommand();
			myToolBar.addCommandToRightSideMenu(mylogoff);

			
			ConfirmCommand myconfirmCommand = new ConfirmCommand();
			a.addActionListener(myconfirmCommand);
			CancelCommand mycancelCommand = new CancelCommand(info);
			b.addActionListener(mycancelCommand);
			
			
			
			
			Container leftContainer = new Container(new BoxLayout(BoxLayout.Y_AXIS));								//left container is created and its
			leftContainer.getAllStyles().setPadding(Component.TOP, 75);												//characteristics
			leftContainer.getAllStyles().setBorder(Border.createLineBorder(4,ColorUtil.BLACK));
			
			
			Container bottomContainer = new Container(new FlowLayout(Component.CENTER));							//bottom container is created
			
			
			
			
			Container rightContainer = new Container(new BoxLayout(BoxLayout.Y_AXIS));								//right container is created and
			rightContainer.getAllStyles().setPadding(Component.TOP, 75);											//its characteristics
			rightContainer.getAllStyles().setBorder(Border.createLineBorder(4,ColorUtil.BLACK));
			
			for(int i = 0; i < myButtons.size(); i++)																//In the for loop, the buttons would get these characteristics
			{																										//and will go to the appropriate container
				myButtons.get(i).getUnselectedStyle().setBgTransparency(255);
				myButtons.get(i).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
				myButtons.get(i).getUnselectedStyle().setFgColor(ColorUtil.WHITE);
				
				myButtons.get(i).getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.BLACK));
				
				myButtons.get(i).getAllStyles().setPadding(Component.TOP, 2);
				myButtons.get(i).getAllStyles().setPadding(Component.BOTTOM, 2);
				bottomContainer.add(myButtons.get(i));
				
			}
			
			
			
			add(BorderLayout.NORTH, sv);															//the left, bottom, and right container, sv, and mv 
			add(BorderLayout.CENTER, info);															//are added to certain parts of the simulator
			add(BorderLayout.SOUTH, bottomContainer);
			this.show();																			//The containers are shown.
		}
}

