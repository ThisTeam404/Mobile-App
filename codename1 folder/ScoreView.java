package com.mycompany.pageApp;

import java.util.Observable;
import java.util.Observer;

import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.Button;
import com.codename1.ui.Component;
import com.codename1.ui.Container;
import com.codename1.ui.plaf.Border;

public class ScoreView extends Container implements Observer{
	
	public ScoreView(){
		Button addKey = new Button("Add Key");
		addKey.getAllStyles().setBorder(Border.createEmpty());
		addKey.getUnselectedStyle().setBgTransparency(255);
		addKey.getUnselectedStyle().setBgColor(ColorUtil.GREEN);
		addKey.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		addKey.getUnselectedStyle().setBorder(Border.createLineBorder(3,ColorUtil.BLACK));
		addKey.getAllStyles().setPadding(Component.TOP, 2);
		addKey.getAllStyles().setPadding(Component.BOTTOM, 2);
		addKey.getAllStyles().setPadding(Component.LEFT, 8);
		addKey.getAllStyles().setPadding(Component.RIGHT, 8);
		add(addKey);
		
		
		Button createJob = new Button("Create Job");
		createJob.getAllStyles().setBorder(Border.createEmpty());
		createJob.getUnselectedStyle().setBgTransparency(255);
		createJob.getUnselectedStyle().setBgColor(ColorUtil.GREEN);
		createJob.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		createJob.getUnselectedStyle().setBorder(Border.createLineBorder(3,ColorUtil.BLACK));
		createJob.getAllStyles().setPadding(Component.TOP, 2);
		createJob.getAllStyles().setPadding(Component.BOTTOM, 2);
		createJob.getAllStyles().setPadding(Component.LEFT, 8);
		createJob.getAllStyles().setPadding(Component.RIGHT, 8);
		add(createJob);
	}
	
	public void update(Observable o, Object arg){
		System.out.println("Action Performed in ScoreView. Call PageActions\n");
		
	}

	
}
