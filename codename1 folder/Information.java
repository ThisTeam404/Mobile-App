package com.mycompany.a190;

import java.util.Vector;
import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.Button;
import com.codename1.ui.CheckBox;
import com.codename1.ui.Component;
import com.codename1.ui.Container;
import com.codename1.ui.Label;
import com.codename1.ui.TextField;
import com.codename1.ui.layouts.BorderLayout;
import com.codename1.ui.layouts.FlowLayout;
import com.codename1.ui.plaf.Border;

public class Information extends Container{				//A vector for the labels.
	private Vector <Button> myButtons = new Vector();
	private Vector <Button> myButtonNumbers = new Vector();
	private Boolean KW1flag = true;
	private Boolean SK1flag = true;
	private Boolean oneflag = false;
	private Boolean twoflag = false;
	private Boolean threeflag = false;
	private Button key3;
	private Button key4;
	private Button key5;
	private CheckBox myMasterKey = new CheckBox("Master Key?");
	public Information()
	{
		this.setLayout((new FlowLayout(Component.CENTER)));
		this.getAllStyles().setBgTransparency(255);
		this.getAllStyles().setBgColor(ColorUtil.WHITE);
		
	
		Label key = new Label("Keyware Type: ");
		key.getAllStyles().setFgColor(ColorUtil.BLUE);
		Label numKey = new Label("Number of Locks: ");
		numKey.getAllStyles().setFgColor(ColorUtil.BLUE);
		final TextField myTextField =new TextField(); 
		
		
		
		myMasterKey.getAllStyles().setBgTransparency(255);
		myMasterKey.getAllStyles().setBgColor(ColorUtil.WHITE);	
		
		
		MasterKeyCommand myMasterKeyCommand = new MasterKeyCommand(this);
		myMasterKey.setCommand(myMasterKeyCommand);
		
		
		
		
		Button key1 = new Button("KW1");						//The buttons.
		Button key2 = new Button("SK1");
		key3 = new Button("1");
		key4 = new Button("2");
		key5 = new Button("3");

		Button confirm1 = new Button("Confirm");
		Button cancel1 = new Button("Cancel");
		
		myButtons.add(key1);											
		myButtons.add(key2);
		myButtons.add(key3);											
		myButtons.add(key4);
		myButtons.add(key5);
		
		
		myButtonNumbers.add(key3);											
		myButtonNumbers.add(key4);
		myButtonNumbers.add(key5);
		
		
		KW1Command myKW1command = new KW1Command(this);
		key1.addActionListener(myKW1command);
		
		SK1Command mySK1Command = new SK1Command(this);
		key2.addActionListener(mySK1Command);
		
		OneCommand myoneCommand = new OneCommand(this);
		key3.addActionListener(myoneCommand);
		
		TwoCommand mytwoCommand = new TwoCommand(this);
		key4.addActionListener(mytwoCommand);
		
		ThreeCommand mythreeCommand = new ThreeCommand(this);
		key5.addActionListener(mythreeCommand);
		
		
		
		
	
		confirm1.getAllStyles().setPadding(Component.TOP, 2);
		confirm1.getAllStyles().setPadding(Component.BOTTOM, 2);
		confirm1.getAllStyles().setPadding(Component.LEFT, 10);
		confirm1.getAllStyles().setPadding(Component.RIGHT, 10);
		confirm1.getUnselectedStyle().setBgTransparency(255);
		confirm1.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		confirm1.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		confirm1.getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		cancel1.getAllStyles().setPadding(Component.TOP, 2);
		cancel1.getAllStyles().setPadding(Component.BOTTOM, 2);
		cancel1.getAllStyles().setPadding(Component.LEFT, 10);
		cancel1.getAllStyles().setPadding(Component.RIGHT, 10);
		cancel1.getUnselectedStyle().setBgTransparency(255);
		cancel1.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		cancel1.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		cancel1.getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		
		
		
		
		
		
		this.add(key);
		for(int i = 0; i < myButtons.size(); i++)																//In the for loop, the buttons would get these characteristics
		{																										//and will go to the appropriate container
			myButtons.get(i).getUnselectedStyle().setBgTransparency(255);
			myButtons.get(i).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
			myButtons.get(i).getUnselectedStyle().setFgColor(ColorUtil.WHITE);
			
			myButtons.get(i).getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
			
			myButtons.get(i).getAllStyles().setPadding(Component.TOP, 2);
			myButtons.get(i).getAllStyles().setPadding(Component.BOTTOM, 2);
			myButtons.get(i).getAllStyles().setPadding(Component.LEFT, 7);
			myButtons.get(i).getAllStyles().setPadding(Component.RIGHT, 7);
			
			if(i == 2 || i == 3 || i == 4)
			{
				myButtons.get(i).setEnabled(oneflag);
				myButtons.get(i).getDisabledStyle().setBgTransparency(255);
				myButtons.get(i).getDisabledStyle().setBgColor(ColorUtil.WHITE);
				myButtons.get(i).getDisabledStyle().setFgColor(ColorUtil.GREEN);
				myButtons.get(i).getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));		
			}
			
			
			
			if(i <= 1)
			{
				add(myButtons.get(i));
			}
			else
			{
				myButtons.get(i).getAllStyles().setPadding(Component.LEFT, 5);
				myButtons.get(i).getAllStyles().setPadding(Component.RIGHT, 5);
			}
		}
		this.add(numKey);
		this.add(myTextField); 
		this.add(confirm1);
		this.add(cancel1);
		this.add(myMasterKey);
		this.add(key3);
		this.add(key4);
		this.add(key5);
		
		
		Vector <TextField> myTextFields = new Vector();
		
		TextField myTextField1=new TextField(); 
		TextField myTextField2=new TextField(); 
		TextField myTextField3=new TextField(); 
		TextField myTextField4=new TextField(); 
		TextField myTextField5=new TextField(); 
		
		myTextFields.add(myTextField1);
		myTextFields.add(myTextField2);
		myTextFields.add(myTextField3);
		myTextFields.add(myTextField4);
		myTextFields.add(myTextField5);

		
		
		for(int i = 0; i < myTextFields.size(); i++)
		{
			this.add(myTextFields.get(i));
		}
		
		
	}
	public void disableKW1Button() 
	{
		KW1flag = false;
		myButtons.get(0).setEnabled(KW1flag);
		myButtons.get(0).getDisabledStyle().setBgTransparency(255);
		myButtons.get(0).getDisabledStyle().setBgColor(ColorUtil.WHITE);
		myButtons.get(0).getDisabledStyle().setFgColor(ColorUtil.GREEN);
		myButtons.get(0).getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		SK1flag = true;
		
		myButtons.get(1).setEnabled(SK1flag);
		myButtons.get(1).getUnselectedStyle().setBgTransparency(255);
		myButtons.get(1).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		myButtons.get(1).getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		
		myButtons.get(1).getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		myButtons.get(1).getAllStyles().setPadding(Component.TOP, 2);
		myButtons.get(1).getAllStyles().setPadding(Component.BOTTOM, 2);
		myButtons.get(1).getAllStyles().setPadding(Component.LEFT, 7);
		myButtons.get(1).getAllStyles().setPadding(Component.RIGHT, 7);
		
	}
	public void disableSK1Button() 
	{
		SK1flag = false;
		myButtons.get(1).setEnabled(SK1flag);
		myButtons.get(1).getDisabledStyle().setBgTransparency(255);
		myButtons.get(1).getDisabledStyle().setBgColor(ColorUtil.WHITE);
		myButtons.get(1).getDisabledStyle().setFgColor(ColorUtil.GREEN);
		myButtons.get(1).getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		KW1flag = true;
		
		myButtons.get(0).setEnabled(KW1flag);
		myButtons.get(0).getUnselectedStyle().setBgTransparency(255);
		myButtons.get(0).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		myButtons.get(0).getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		
		myButtons.get(0).getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		myButtons.get(0).getAllStyles().setPadding(Component.TOP, 2);
		myButtons.get(0).getAllStyles().setPadding(Component.BOTTOM, 2);
		myButtons.get(0).getAllStyles().setPadding(Component.LEFT, 7);
		myButtons.get(0).getAllStyles().setPadding(Component.RIGHT, 7);
		
	}
	public void disableNumberButtons()
	{
		oneflag = false;
		twoflag = false;
		threeflag = false;
		key3.setEnabled(oneflag);
		key3.getDisabledStyle().setBgTransparency(255);
		key3.getDisabledStyle().setBgColor(ColorUtil.WHITE);
		key3.getDisabledStyle().setFgColor(ColorUtil.GREEN);
		key3.getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		key4.setEnabled(twoflag);
		key4.getDisabledStyle().setBgTransparency(255);
		key4.getDisabledStyle().setBgColor(ColorUtil.WHITE);
		key4.getDisabledStyle().setFgColor(ColorUtil.GREEN);
		key4.getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		key5.setEnabled(threeflag);
		key5.getDisabledStyle().setBgTransparency(255);
		key5.getDisabledStyle().setBgColor(ColorUtil.WHITE);
		key5.getDisabledStyle().setFgColor(ColorUtil.GREEN);
		key5.getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
	}
	public void enableNumberButtons()
	{
		oneflag = true;
		twoflag = true;
		threeflag = true;
		
		key3.setEnabled(oneflag);
		key4.setEnabled(twoflag);
		key5.setEnabled(threeflag);
		
		key3.getUnselectedStyle().setBgTransparency(255);
		key3.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		key3.getUnselectedStyle().setFgColor(ColorUtil.WHITE);		
		key3.getUnselectedStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));		
		key3.getAllStyles().setPadding(Component.TOP, 2);
		key3.getAllStyles().setPadding(Component.BOTTOM, 2);
		key3.getAllStyles().setPadding(Component.LEFT, 5);
		key3.getAllStyles().setPadding(Component.RIGHT, 5);
		
		key4.getUnselectedStyle().setBgTransparency(255);
		key4.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		key4.getUnselectedStyle().setFgColor(ColorUtil.WHITE);		
		key4.getUnselectedStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));		
		key4.getAllStyles().setPadding(Component.TOP, 2);
		key4.getAllStyles().setPadding(Component.BOTTOM, 2);
		key4.getAllStyles().setPadding(Component.LEFT, 5);
		key4.getAllStyles().setPadding(Component.RIGHT, 5);
		
		key5.getUnselectedStyle().setBgTransparency(255);
		key5.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		key5.getUnselectedStyle().setFgColor(ColorUtil.WHITE);		
		key5.getUnselectedStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));		
		key5.getAllStyles().setPadding(Component.TOP, 2);
		key5.getAllStyles().setPadding(Component.BOTTOM, 2);
		key5.getAllStyles().setPadding(Component.LEFT, 5);
		key5.getAllStyles().setPadding(Component.RIGHT, 5);
		
	}
	public void buttonSelected(int num)
	{
		if(num == 1)
		{
			oneflag = false;
			twoflag = true;
			threeflag = true;
			
			key3.setEnabled(oneflag);
			key4.setEnabled(twoflag);
			key5.setEnabled(threeflag);
			key3.getDisabledStyle().setBgTransparency(255);
			key3.getDisabledStyle().setBgColor(ColorUtil.WHITE);
			key3.getDisabledStyle().setFgColor(ColorUtil.GREEN);
			key3.getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
			
			
			for(int i = 1; i < myButtonNumbers.size(); i++)
			{
				myButtonNumbers.get(i).getUnselectedStyle().setBgTransparency(255);
				myButtonNumbers.get(i).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
				myButtonNumbers.get(i).getUnselectedStyle().setFgColor(ColorUtil.WHITE);		
				myButtonNumbers.get(i).getUnselectedStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));		
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.TOP, 2);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.BOTTOM, 2);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.LEFT, 5);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.RIGHT, 5);				
			}
		
		}
		else if(num == 2)
		{
			oneflag = true;
			twoflag = false;
			threeflag = true;
			
			key3.setEnabled(oneflag);
			key4.setEnabled(twoflag);
			key5.setEnabled(threeflag);
			key4.getDisabledStyle().setBgTransparency(255);
			key4.getDisabledStyle().setBgColor(ColorUtil.WHITE);
			key4.getDisabledStyle().setFgColor(ColorUtil.GREEN);
			key4.getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
			
			
			for(int i = 1; i < myButtonNumbers.size(); i+=2)
			{
				myButtonNumbers.get(i).getUnselectedStyle().setBgTransparency(255);
				myButtonNumbers.get(i).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
				myButtonNumbers.get(i).getUnselectedStyle().setFgColor(ColorUtil.WHITE);		
				myButtonNumbers.get(i).getUnselectedStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));		
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.TOP, 2);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.BOTTOM, 2);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.LEFT, 5);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.RIGHT, 5);				
			}
		}
		else
		{
			oneflag = true;
			twoflag = true;
			threeflag = false;
			
			key3.setEnabled(oneflag);
			key4.setEnabled(twoflag);
			key5.setEnabled(threeflag);
			key5.getDisabledStyle().setBgTransparency(255);
			key5.getDisabledStyle().setBgColor(ColorUtil.WHITE);
			key5.getDisabledStyle().setFgColor(ColorUtil.GREEN);
			key5.getDisabledStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
			
			
			for(int i = myButtonNumbers.size() - 1; i >= 0; i--)
			{
				myButtonNumbers.get(i).getUnselectedStyle().setBgTransparency(255);
				myButtonNumbers.get(i).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
				myButtonNumbers.get(i).getUnselectedStyle().setFgColor(ColorUtil.WHITE);		
				myButtonNumbers.get(i).getUnselectedStyle().setBorder(Border.createLineBorder(2, ColorUtil.GREEN));		
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.TOP, 2);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.BOTTOM, 2);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.LEFT, 5);
				myButtonNumbers.get(i).getAllStyles().setPadding(Component.RIGHT, 5);				
			}
			
		}
	}
	public void enableKW1andSK1()
	{
		KW1flag = true;
		
		myButtons.get(0).setEnabled(KW1flag);
		myButtons.get(0).getUnselectedStyle().setBgTransparency(255);
		myButtons.get(0).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		myButtons.get(0).getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		
		myButtons.get(0).getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		myButtons.get(0).getAllStyles().setPadding(Component.TOP, 2);
		myButtons.get(0).getAllStyles().setPadding(Component.BOTTOM, 2);
		myButtons.get(0).getAllStyles().setPadding(Component.LEFT, 7);
		myButtons.get(0).getAllStyles().setPadding(Component.RIGHT, 7);
		
		SK1flag = true;
		
		myButtons.get(1).setEnabled(SK1flag);
		myButtons.get(1).getUnselectedStyle().setBgTransparency(255);
		myButtons.get(1).getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		myButtons.get(1).getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		
		myButtons.get(1).getUnselectedStyle().setBorder(Border.createLineBorder(3, ColorUtil.GREEN));
		
		myButtons.get(1).getAllStyles().setPadding(Component.TOP, 2);
		myButtons.get(1).getAllStyles().setPadding(Component.BOTTOM, 2);
		myButtons.get(1).getAllStyles().setPadding(Component.LEFT, 7);
		myButtons.get(1).getAllStyles().setPadding(Component.RIGHT, 7);
		
	}
	public void deselectMasterkey() //Should uncheck the masterkey check box
	{
		//You would do this through setSelect() method.
		myMasterKey.setSelected(false);
		enableKW1andSK1();
		
	}
	
}

