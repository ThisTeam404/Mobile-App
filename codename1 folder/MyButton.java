package com.mycompany.pageApp;

import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.Button;
import com.codename1.ui.Component;
import com.codename1.ui.Form;
import com.codename1.ui.plaf.Border;

public class MyButton extends Form{

	public MyButton(Button b,String name){
		
		b.getUnselectedStyle().setBgTransparency(255);
		b.getUnselectedStyle().setBgColor(ColorUtil.BLUE);
		b.getUnselectedStyle().setFgColor(ColorUtil.WHITE);
		b.getUnselectedStyle().setBorder(Border.createLineBorder(3,ColorUtil.BLACK));
		b.getAllStyles().setPadding(Component.TOP, 2);
		b.getAllStyles().setPadding(Component.BOTTOM, 2);
		b.getAllStyles().setPadding(Component.LEFT, 3);
		b.getAllStyles().setPadding(Component.RIGHT, 3);
		
	}
	
}
