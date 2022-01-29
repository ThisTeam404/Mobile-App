package com.mycompany.a190;

import com.codename1.charts.util.ColorUtil;
import com.codename1.ui.ButtonGroup;
import com.codename1.ui.Component;
import com.codename1.ui.Container;
import com.codename1.ui.RadioButton;
import com.codename1.ui.layouts.FlowLayout;

public class DataTableInfo extends Container{
	public DataTableInfo()
	{
		this.setLayout((new FlowLayout(Component.CENTER)));
		this.getAllStyles().setBgTransparency(255);
		this.getAllStyles().setBgColor(ColorUtil.WHITE);
		RadioButton copy = new RadioButton("Copy");
		RadioButton master = new RadioButton("Master");
		new ButtonGroup(copy, master);
		
		copy.getUnselectedStyle().setBgTransparency(255);
		copy.getUnselectedStyle().setBgColor(ColorUtil.LTGRAY);
		copy.getUnselectedStyle().setFgColor(ColorUtil.BLUE);

		
		master.getUnselectedStyle().setBgTransparency(255);
		master.getUnselectedStyle().setBgColor(ColorUtil.LTGRAY);
		master.getUnselectedStyle().setFgColor(ColorUtil.BLUE);
		
		this.add(copy);
		this.add(master);
	}
}
