package com.mycompany.a190;

import java.util.Observable;
import java.util.Observer;
import java.util.Vector;
import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.Button;
import com.codename1.ui.Component;
import com.codename1.ui.Container;
import com.codename1.ui.Label;
import com.codename1.ui.layouts.FlowLayout;
import com.codename1.ui.plaf.Border;

public class MainPages extends Container implements Observer {
	private Vector <Label> myMasterKeyNumbers = new Vector();					//A vector for the labels.
	private Boolean addLockFlag = true;
	private Boolean createJobflag = false;
	private Button a;
	private Button b;
	
	
	public MainPages(int num)
	{
		this.setLayout((new FlowLayout(Component.CENTER)));
		this.getAllStyles().setBgTransparency(255);
		this.getAllStyles().setBgColor(ColorUtil.GREEN);
		
		Vector <Button> myButtons = new Vector();
		
		a = new Button("Add Lock");						//The buttons.
		b = new Button("Create Job");
		
		myButtons.add(a);											//The labels are added in the vector
		myButtons.add(b);
		
		
		AddLockCommand myaddlockcommand = new AddLockCommand(this);
		a.addActionListener(myaddlockcommand);
		
		CreateJobCommand mycreatejobcommand = new CreateJobCommand(this);
		b.addActionListener(mycreatejobcommand);
		
		
		
		
		
		
		
		for(int i = 0; i < myButtons.size(); i++)																//In the for loop, the buttons would get these characteristics
		{																										//and will go to the appropriate container
			myButtons.get(i).getUnselectedStyle().setBgTransparency(255);
			myButtons.get(i).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
			myButtons.get(i).getUnselectedStyle().setFgColor(ColorUtil.WHITE);
			
			myButtons.get(i).getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
			
			myButtons.get(i).getAllStyles().setPadding(Component.TOP, 2);
			myButtons.get(i).getAllStyles().setPadding(Component.BOTTOM, 2);
			myButtons.get(i).getAllStyles().setPadding(Component.LEFT, 8);
			myButtons.get(i).getAllStyles().setPadding(Component.RIGHT, 8);
			this.add(myButtons.get(i));
		}
		if(num == 1)
		{
			b.setEnabled(createJobflag);
			b.getDisabledStyle().setBgTransparency(255);
			b.getDisabledStyle().setBgColor(ColorUtil.WHITE);
			b.getDisabledStyle().setFgColor(ColorUtil.GREEN);
			b.getDisabledStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));
		}
		else
		{
			a.setEnabled(!addLockFlag);
			a.getDisabledStyle().setBgTransparency(255);
			a.getDisabledStyle().setBgColor(ColorUtil.WHITE);
			a.getDisabledStyle().setFgColor(ColorUtil.GREEN);
			a.getDisabledStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));
		}
		
	}
	public void update(Observable o, Object arg)					//Update will print out time, lives, lastFlagRach, foodlevel, 
	{																//and health.
		/*IIterator theElements = ((GameWorld)o).getTheGameCollection().getIterator();
		GameObject spo = null;
		boolean flag = true;										
		while(theElements.hasNext() && flag) {						//The while loop will find the ant object
			spo = (GameObject) theElements.getNext();
			if(spo instanceof Ant)									//When the ant is found, the flag becomes false and the program
			{														//gets out of the while loop.
				flag = false;
			}
		}*/
		//myLabels.get(1).setText(String.valueOf(((GameWorld)o).getTime()));			//Update can possibly change time, lives, 
		//myLabels.get(3).setText(String.valueOf(((GameWorld)o).getLives()));			//lastFlagRach, foodlevel, and health
		/*myLabels.get(5).setText(String.valueOf(((Ant)spo).getLastFlagReach()));
		myLabels.get(7).setText(String.valueOf((((Ant)spo).getFoodLevel())));
		myLabels.get(9).setText(String.valueOf((((Ant)spo).getHealth())));*/
		revalidate();

	}
	
	public void disableAddLockButton() //Button a is the add lock button
	{
		addLockFlag = false;
		a.setEnabled(addLockFlag);
		a.getDisabledStyle().setBgTransparency(255);
		a.getDisabledStyle().setBgColor(ColorUtil.WHITE);
		a.getDisabledStyle().setFgColor(ColorUtil.GREEN);
		a.getDisabledStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));
		
		createJobflag = true;
		
		b.setEnabled(createJobflag);
		b.getUnselectedStyle().setBgTransparency(255);
		b.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		b.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		
		b.getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		b.getAllStyles().setPadding(Component.TOP, 2);
		b.getAllStyles().setPadding(Component.BOTTOM, 2);
		b.getAllStyles().setPadding(Component.LEFT, 8);
		b.getAllStyles().setPadding(Component.RIGHT, 8);
		
	}
	public void disableCreateJobButton() //Button b is the job create button
	{
		createJobflag = false;
		b.setEnabled(createJobflag);
		b.getDisabledStyle().setBgTransparency(255);
		b.getDisabledStyle().setBgColor(ColorUtil.WHITE);
		b.getDisabledStyle().setFgColor(ColorUtil.GREEN);
		b.getDisabledStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));
		
		addLockFlag = true;
		
		a.setEnabled(addLockFlag);
		a.getUnselectedStyle().setBgTransparency(255);
		a.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		a.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		
		a.getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		a.getAllStyles().setPadding(Component.TOP, 2);
		a.getAllStyles().setPadding(Component.BOTTOM, 2);
		a.getAllStyles().setPadding(Component.LEFT, 8);
		a.getAllStyles().setPadding(Component.RIGHT, 8);
		
	}
}


