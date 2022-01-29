package com.mycompany.a3;

import com.codename1.ui.events.ActionListener; 
import com.codename1.ui.Label;
//import com.codename1.ui.List;
import com.codename1.ui.TextField; 
import com.codename1.ui.events.ActionEvent; 
import java.lang.String;
import java.util.ArrayList;
import java.util.List;
import com.codename1.ui.Form;
import java.util.concurrent.ThreadLocalRandom;

public class Main extends Form
{
	public Main()
	{
		Label myLabel=new Label("How many locks?:");    
		this.addComponent(myLabel);      
		final TextField myTextField=new TextField();    
		this.addComponent(myTextField);      
		this.show();  
		
		myTextField.addActionListener(new   ActionListener()
		{           
			public void actionPerformed(ActionEvent evt) 
			{  
				String   sCommand=myTextField.getText().toString();           
				myTextField.clear();  
				
				int locks = Integer.parseInt(sCommand);
				
				//put random pins values 1-9 into locks combos for number of locks
				List<Integer> singleLock = new ArrayList<Integer>();
				List<List<Integer>> manyLocks = new ArrayList<List<Integer>>();
				int rndInt = 0;
				for (int i = 0; i < locks; i++)
				{
					//fill single lock with random values 1-9
					for (int j = 0; j < 5; j++)
					{
						rndInt = ThreadLocalRandom.current().nextInt(1, 8);
						rndInt -= 30;
						System.out.print(rndInt + ' ');
						singleLock.add(j, rndInt);
					}
					
					System.out.println();
					manyLocks.add(i, singleLock);
					
					
				}
				
			}
		});
	}
	
	
}
