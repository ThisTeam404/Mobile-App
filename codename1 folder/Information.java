package com.mycompany.pageApp;

import java.util.Vector;

import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.Button;
import com.codename1.ui.CheckBox;
import com.codename1.ui.Component;
import com.codename1.ui.Container;
import com.codename1.ui.Form;
import com.codename1.ui.Label;
import com.codename1.ui.TextField;
import com.codename1.ui.Toolbar;
import com.codename1.ui.layouts.BorderLayout;
import com.codename1.ui.layouts.FlowLayout;
import com.codename1.ui.plaf.Border;
import com.mycompany.pageApp.MyButton;
import com.mycompany.pageApp.XCommand;

public class Information extends Form{
	
	private PageActions pa;
	private ScoreView sv;
	
	
	public Information(){
		
		pa = new PageActions();
		sv = new ScoreView();
		pa.addObserver(sv);
		
		
		this.setLayout(new BorderLayout());
		Container topContainer = new Container(new FlowLayout(Component.CENTER));
		topContainer.add(sv);
		topContainer.getAllStyles().setBorder(Border.createLineBorder(2,ColorUtil.GREEN));
		this.add(BorderLayout.NORTH,topContainer);
		
		Container centerContainer = new Container();
		centerContainer.setLayout(new FlowLayout(Component.CENTER));
		centerContainer.getAllStyles().setBgTransparency(255);
		centerContainer.getAllStyles().setBgColor(ColorUtil.LTGRAY);
		centerContainer.getAllStyles().setBorder(Border.createLineBorder(2,ColorUtil.WHITE));
		
		Label key = new Label("Keyway Type: ");
		key.getAllStyles().setFgColor(ColorUtil.BLUE);	
		key.getAllStyles().setPadding(Component.TOP, 3);
		key.getAllStyles().setPadding(Component.BOTTOM, 3);
		
		Button key1 = new Button("1");
		new MyButton(key1,"1");
		Button key2 = new Button("2");
		new MyButton(key2,"2");
		Button key3 = new Button("3");
		new MyButton(key3,"3");
		Button key4 = new Button("4");
		new MyButton(key4,"4");
		Button key5 = new Button("5");
		new MyButton(key5,"5");
		
		Label numKey = new Label("Number of Locks: ");
		numKey.getAllStyles().setFgColor(ColorUtil.BLUE);
		
		final TextField myTextField = new TextField();
		//int num = Integer.parseInt(myTextField.getText());
		//int amountOfKey = Integer.parseInt(num);
		//System.out.printf("Number of Keys Entered: %d", num);
		
		Button confirmButton = new Button("Confirm");
		confirmButton.getAllStyles().setPadding(Component.TOP, 1);
		confirmButton.getAllStyles().setPadding(Component.BOTTOM, 2);
		confirmButton.getAllStyles().setPadding(Component.LEFT, 15);
		confirmButton.getAllStyles().setPadding(Component.RIGHT, 15);
		confirmButton.getUnselectedStyle().setBgTransparency(255);
		confirmButton.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		confirmButton.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		confirmButton.getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.WHITE));
		
		CheckBox myMasterKey = new CheckBox("Master Key: ");
		//myMasterKey.getAllStyles().setBgTransparency(255);
		myMasterKey.getAllStyles().setFgColor(ColorUtil.BLUE);
		
		Button masterKey1 = new Button("1");
		new MyButton(masterKey1,"1");
		Button masterKey2 = new Button("2");
		new MyButton(masterKey2,"2");
		Button masterKey3 = new Button("3");
		new MyButton(masterKey3,"3");
		
		centerContainer.add(key);
		centerContainer.add(key1);
		centerContainer.add(key2);
		centerContainer.add(key3);
		centerContainer.add(key4);
		centerContainer.add(key5);
		centerContainer.add(numKey);
		centerContainer.add(myTextField);
		centerContainer.add(confirmButton);
		centerContainer.add(myMasterKey);
		centerContainer.add(masterKey1);
		centerContainer.add(masterKey2);
		centerContainer.add(masterKey3);
		this.add(BorderLayout.CENTER,centerContainer);
		
		/*
		this.setLayout((new FlowLayout(Component.CENTER)));
		this.getAllStyles().setBgTransparency(255);
		this.getAllStyles().setBgColor(ColorUtil.WHITE);
		
		Label key = new Label("Keyware Type: ");
		key.getAllStyles().setFgColor(ColorUtil.BLUE);
		Label numKey = new Label("Number of Keys: ");
		numKey.getAllStyles().setFgColor(ColorUtil.BLUE);
		final TextField myTextField = new TextField();
		
		CheckBox myMasterKey = new CheckBox("Master Key: ");
		myMasterKey.getAllStyles().setBgTransparency(255);
		myMasterKey.getAllStyles().setBgColor(ColorUtil.WHITE);
		
		/*
		Vector <Button> myButtons = new Vector();
		
		Button key1 = new Button("1");
		Button key2 = new Button("2");
		Button key3 = new Button("3");
		Button key4 = new Button("4");
		Button key5 = new Button("5");
		myButtons.add(key1);
		myButtons.add(key2);
		myButtons.add(key3);
		myButtons.add(key4);
		myButtons.add(key5);
	
		
		Button key1 = new Button("1");
		new MyButton(key1,"1");
		Button key2 = new Button("2");
		new MyButton(key2,"2");
		Button key3 = new Button("3");
		new MyButton(key3,"3");
		Button key4 = new Button("4");
		new MyButton(key4,"4");
		Button key5 = new Button("5");
		new MyButton(key5,"5");
		
		
		Button confirmButton = new Button("Confirm");
		Button cancelButton = new Button("Cancel");
		
		
		confirmButton.getAllStyles().setPadding(Component.TOP, 2);
		confirmButton.getAllStyles().setPadding(Component.BOTTOM, 2);
		confirmButton.getAllStyles().setPadding(Component.LEFT, 10);
		confirmButton.getAllStyles().setPadding(Component.RIGHT, 10);
		confirmButton.getUnselectedStyle().setBgTransparency(255);
		confirmButton.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		confirmButton.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		confirmButton.getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		cancelButton.getAllStyles().setPadding(Component.TOP, 2);
		cancelButton.getAllStyles().setPadding(Component.BOTTOM, 2);
		cancelButton.getAllStyles().setPadding(Component.LEFT, 10);
		cancelButton.getAllStyles().setPadding(Component.RIGHT, 10);
		cancelButton.getUnselectedStyle().setBgTransparency(255);
		cancelButton.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		cancelButton.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		cancelButton.getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		this.add(key);
		this.add(numKey);
		this.add(confirmButton);
		this.add(cancelButton);
		this.add(myMasterKey);
		this.add(myTextField);
		
		add(BorderLayout.NORTH, sv);
		//add(BorderLayout.CENTER, info);
		//add(BorderLayout.SOUTH, bottomContainer);
		*/
		
		Toolbar myToolBar = new Toolbar();
		setToolbar(myToolBar);
		
		myToolBar.setTitleComponent(new Label("LOCK THAT DOWN"));
		
		XCommand exitApp = new XCommand(pa);
		myToolBar.addCommandToSideMenu(exitApp);
	
		
		this.show();
		
		
	}

}
