package com.mycompany.a190;

import com.codename1.ui.CheckBox;
import com.codename1.ui.Command;
import com.codename1.ui.Form;
import com.codename1.ui.Label;
import com.codename1.ui.Toolbar;
import com.codename1.ui.events.ActionEvent;

public class MasterKeyCommand extends Command {
	private Information info;
	public MasterKeyCommand(Information i)
	{
		super("Master Key?");
		info = i;
	}

	public void actionPerformed(ActionEvent evt){
		if (((CheckBox)evt.getComponent()).isSelected())									
		{
			info.enableNumberButtons();
		}	//sc.setCheckStatusVal(true);													
		else
		{
			info.disableNumberButtons();
		}
			//sc.setCheckStatusVal(false);
		
	}
	/*public void setCheckStatusVal(boolean bVal)													
	{																							
		if (bVal)
			checkStatusVal.setText("ON");
		else
		checkStatusVal.setText("OFF");
		s.revalidate();
	}*/
}
