package masterKeyAlgorithm;

import java.lang.Math;
import java.util.Random;

/* uses Hold & Vary system to create a master key system*/
/* I think ideally, KW1 can produce at most 30 and SC1 can produce at most 80*/
public class CodeGenerator {
	private static int KW1MACSValue = 4;
	private static int SC1MACSValue = 7;
	
	private static int KW1MinValue = 1;
	private static int KW1MaxValue = 7;
	private static int SC1MinValue = 0;
	private static int SC1MaxValue = 9;
	
	private int combinationLength = 5;
	
	private int[] masterKey;
	
	/* constructor: generates the random master key bitting*/
	public CodeGenerator(String keywaytype) {
		masterKey = new int[5];
		generateMasterKey(keywaytype); 
	}
	
	/* get the value of master key*/
	public int[] getMasterKey() {
		return masterKey;
	}
	
	/* set the value of master Key */
	private void setMasterKey(int[] masterKey) {
		this.masterKey = masterKey;
	}
	
	/*displays change keys*/
	private void displayChangeKeys(String[] changeKeys, int numChangeKeys) {
		int i;
		System.out.print("Change Keys:     [");
		for(i = 0; i < (numChangeKeys - 1); i++) {
			System.out.print(changeKeys[i] + ", ");
		}
		System.out.print(changeKeys[i] + "]");
	}
	
	/*display change pins*/
	private void displayChangePins(String[] changeKeyPins, int numChangeKeys) {
		int i;
		System.out.print("\nChange Key Pins: [");
		for(i = 0; i < (numChangeKeys - 1); i++) {
			System.out.print(changeKeyPins[i] + ", ");
		}
		System.out.print(changeKeyPins[i] + "]");
	}
	
	/*display master pins*/
	private void displayMasterPins(String[] masterPins, int numChangeKeys) {
		int i;
		System.out.print("\nMaster Pins:     [");
		for(i = 0; i < (numChangeKeys - 1); i++) {
			System.out.print(masterPins[i] + ", ");
		}
		System.out.print(masterPins[i] + "]\n");
	}
	
	/* checks whether adjacent values in the bitting surpass the MACS value
	 * if it surpasses MACS value, then it is not a viable key bitting
	 */
	public boolean checkMACSValue(int macsValue, int[] key) {
		boolean isKeyCutAllowed = true;
		for(int i = 0; i < (key.length - 1); i++)  {
			if(Math.abs(key[i] - key[i+1]) > macsValue) {
				isKeyCutAllowed = false;
				return isKeyCutAllowed;
			}
		}
		return isKeyCutAllowed;
	}
	
	/* The master key must contain the lowest bitting value.
	 * Method checks if master key bitting has it's lowest biting value
	 */
	public boolean hasLowestBittingValue(int lowestBittingValue, int[] masterKey) {
		for(int i = 0; i < masterKey.length; i++) {
			if(masterKey[i] == lowestBittingValue) {
				return true;
			}
		}
		return false;
	}
	
	/* checks if the current change key bitting generated is a repeat bitting for the current job */
	public boolean isRepeatChangeKey(int numKeysGenerated, String[] changeKeys, String currentKey) {
		for(int i = 0; i < numKeysGenerated; i++) {
			if(currentKey.equals(changeKeys[i])) {
				return true;
			}
		}
		return false;
	}
	
	/*calculates and returns the number of viable keys the master key can generate using single vary*/
	public int numViableKeysSingleVary(int[] masterKey, String keyway) {
		int numViableKeys = 0;
		int[] currentKey;
		int currentMChamber, possibleVal;
		for(currentMChamber = 0; currentMChamber < combinationLength; currentMChamber++) {
			currentKey = new int[combinationLength];
			
			if(keyway.equals("KW1")) {
				for(possibleVal = KW1MinValue; possibleVal <= KW1MaxValue; possibleVal++) {
					//for the current master key chamber , every possible vary is used to create a key
					if (((masterKey[currentMChamber] % 2) == (possibleVal % 2)) && (masterKey[currentMChamber] != possibleVal)) {
						
						//create the change key 
						for(int j = 0; j < combinationLength; j++) {
							if(j == currentMChamber) {
								currentKey[j] = possibleVal;
							}
							else {
								currentKey[j] = masterKey[j];
							}
						}
						
						//check if the key generated is viable
						if(checkMACSValue(KW1MACSValue, currentKey)) {
							numViableKeys++;
						}	
					}
				}
			}
			
			else if(keyway.equals("SC1")) {
				for(possibleVal = SC1MinValue; possibleVal <= SC1MaxValue; possibleVal++) {
					if (((masterKey[currentMChamber] % 2) == (possibleVal % 2)) && (masterKey[currentMChamber] != possibleVal)) {
						
						//create the change key 
						for(int j = 0; j < combinationLength; j++) {
							if(j == currentMChamber) {
								currentKey[j] = possibleVal;
							}
							else {
								currentKey[j] = masterKey[j];
							}
						}
						
						//check if the key generated is viable
						if(checkMACSValue(SC1MACSValue, currentKey)) {
							numViableKeys++;
						}	
					}
				}
			}
		}
	
		return numViableKeys;
	}
	
	/*calculates and returns the number of viable keys the master key can generate using two vary*/
	public int numViableKeysTwoVary(int[] masterKey, String keyway) {
		int numViableKeys = 0;
		int[] currentKey;
		int currentMChamber1, currentMChamber2, possibleVal1, possibleVal2;
		
		for(currentMChamber1 = 0; currentMChamber1 < (combinationLength - 1); currentMChamber1++) {
			for(currentMChamber2 = currentMChamber1 + 1; currentMChamber2 < combinationLength; currentMChamber2++) {
				currentKey = new int[combinationLength];
				
				if(keyway.equals("KW1")) {
					for(possibleVal1 = KW1MinValue; possibleVal1 <= KW1MaxValue; possibleVal1++) {
						for(possibleVal2 = KW1MinValue; possibleVal2 <= KW1MaxValue; possibleVal2++) {
							
							//for the current master key chambers, every possible vary is used to create a key
							if (((masterKey[currentMChamber1] % 2) == (possibleVal1 % 2)) && (masterKey[currentMChamber1] != possibleVal1)) {
								if (((masterKey[currentMChamber2] % 2) == (possibleVal2 % 2)) && (masterKey[currentMChamber2] != possibleVal2)) {
									
									//create the change key 
									for(int j = 0; j < combinationLength; j++) {
										if(j == currentMChamber1) {
											currentKey[j] = possibleVal1;
										}
										else if(j == currentMChamber2) {
											currentKey[j] = possibleVal2;
										}
										else {
											currentKey[j] = masterKey[j];
										}
									}
									
									//check if the key generated is viable
									if(checkMACSValue(KW1MACSValue, currentKey)) {
										numViableKeys++;
									}
								}
							}
						}
					}
				}
				
				else if(keyway.equals("SC1")) {
					for(possibleVal1 = SC1MinValue; possibleVal1 <= SC1MaxValue; possibleVal1++) {
						for(possibleVal2 = SC1MinValue; possibleVal2 <= SC1MaxValue; possibleVal2++) {
							//for the current master key chambers, every possible vary is used to create a key
							if (((masterKey[currentMChamber1] % 2) == (possibleVal1 % 2)) && (masterKey[currentMChamber1] != possibleVal1)) {
								if (((masterKey[currentMChamber2] % 2) == (possibleVal2 % 2)) && (masterKey[currentMChamber2] != possibleVal2)) {
									
									//create the change key 
									for(int j = 0; j < combinationLength; j++) {
										if(j == currentMChamber1) {
											currentKey[j] = possibleVal1;
										}
										else if(j == currentMChamber2) {
											currentKey[j] = possibleVal2;
										}
										else {
											currentKey[j] = masterKey[j];
										}
									}
									
									//check if the key generated is viable
									if(checkMACSValue(SC1MACSValue, currentKey)) {
										numViableKeys++;
									}	
								}
							}
						}
					}
				}
			}	
		}
	
		return numViableKeys;
	}
	/* method that generates a random master key bitting based on the keyway type.
	 * should use even odd or odd even bitting
	 */
	private void generateMasterKey(String keywayType) {
		int[] masterKeyBitting = new int[5];
		Random rand = new Random();
		boolean isViableKey = false;
		
		/* Kwikset: possible values 1-7*/
		if(keywayType == "KW1") {
			while (isViableKey == false) {
				for(int i = 0; i < masterKeyBitting.length; i++) {
					int randomValue = (rand.nextInt(KW1MaxValue) + KW1MinValue);
					
					//check for oddeven/evenodd bitting pattern
					if(i > 0) {
						//if previous bitting value is odd, next bitting value should be even
						if((masterKeyBitting[i-1] % 2) == 1) {
							
							while((randomValue % 2) != 0) {
								randomValue = (rand.nextInt(KW1MaxValue) + KW1MinValue);
							}
						}
						//if previous bitting value is even, next bitting value should be odd
						else if((masterKeyBitting[i-1] % 2) == 0) {
							while((randomValue % 2) != 1) {
								randomValue = (rand.nextInt(KW1MaxValue + 1) + KW1MinValue);
							}
						}
					}
					masterKeyBitting[i] = randomValue;
				}
				
				//if master key bitting doesn't surpass macs value and also has the lowest bitting value, then it's a viable key
				if(checkMACSValue(KW1MACSValue, masterKeyBitting) && hasLowestBittingValue(KW1MinValue, masterKeyBitting)) {
					isViableKey = true;
				}
			}
		}
		
		/* Schlage: possible values 0-9*/
		else if(keywayType == "SC1") {
			while (isViableKey == false) {
				for(int i = 0; i < masterKeyBitting.length; i++) {
					int randomValue = rand.nextInt(SC1MaxValue + 1) + SC1MinValue;
					
					//check for oddeven/evenodd bitting pattern
					if(i > 0) {
						//if previous bitting value is odd, next bitting value should be even
						if((masterKeyBitting[i-1] % 2) == 1) {
							while((randomValue % 2) != 0) {
								randomValue = (rand.nextInt(KW1MaxValue + 1) + KW1MinValue);
							}
						}
						//if previous bitting value is even, next bitting value should be odd
						else if((masterKeyBitting[i-1] % 2) == 0) {
							while((randomValue % 2) != 1) {
								randomValue = (rand.nextInt(KW1MaxValue + 1) + KW1MinValue);
							}
						}
					}
					masterKeyBitting[i] = randomValue;
				}
				
				//if master key bitting doesn't surpass macs value and also has the lowest bitting value, then it's a viable key
				if(checkMACSValue(SC1MACSValue, masterKeyBitting) && hasLowestBittingValue(SC1MinValue, masterKeyBitting)) {
					isViableKey = true;
				}
			}
		}
		
		//set the master key
		setMasterKey(masterKeyBitting);
	}
	
	/* generates the number of change keys requested
	 *  A single vary is used for 7 or less keys
	 *  A 2 vary is used for greater than 7 (currently assuming that more than 120 keys won't be requested)
	 */
	public void generateChangeKeys(int numChangeKeys, int[] masterKey, String keywayType) {
		Random randVal = new Random();
		
		boolean isViableKey = false;
		
		int[] changeKeyBitting;
		int varyChamber1 = 0, varyChamber2 = 0, varyValue1 = 0, varyValue2 = 0;
		int numKeysGenerated = 0;
		
		String[] changeKeys = new String[numChangeKeys];
		String tempKey = "";
		
		int numViableKeys1Vary = numViableKeysSingleVary(masterKey, keywayType);
		int numViableKeys2Vary = numViableKeysTwoVary(masterKey, keywayType);
		
		for(int i = 0; i < numChangeKeys; i++) {
			changeKeyBitting = new int[combinationLength];
			while(isViableKey == false) {
				tempKey = "";
				
				//if greater than 7 keys are requested, use 2 hold and vary, else use single vary
				if((numChangeKeys > numViableKeys1Vary) && (numChangeKeys <= numViableKeys2Vary)) {
					varyChamber1 = randVal.nextInt(combinationLength);
					varyChamber2 = randVal.nextInt(combinationLength);
					
					//the 2 vary chambers should be different
					while(varyChamber1 == varyChamber2) {
						varyChamber2 = randVal.nextInt(combinationLength);
					}
					
					//generate a random value for each chamber that is varied
					if(keywayType.equals("KW1")) {
						varyValue1 = randVal.nextInt(KW1MaxValue) + KW1MinValue;
						varyValue2 = randVal.nextInt(KW1MaxValue) + KW1MinValue;
					}
					else if(keywayType.equals("SC1")) {
						varyValue1 = randVal.nextInt(SC1MaxValue) + SC1MinValue;
						varyValue2 = randVal.nextInt(SC1MaxValue) + SC1MinValue;
						
					}
					
					//regenerate a random value if varyValue1 is invalid
					while (((masterKey[varyChamber1] % 2) != (varyValue1 % 2)) || (varyValue1 == masterKey[varyChamber1])) {
						if(keywayType == "KW1") {
							varyValue1 = randVal.nextInt(KW1MaxValue) + KW1MinValue;
						}
						else if(keywayType == "SC1") {
							varyValue1 = randVal.nextInt(SC1MaxValue) + SC1MinValue;
						}
					}
					
					//regenerate a random value if varyValue2 is invalid
					while (((masterKey[varyChamber2] % 2) != (varyValue2 % 2)) || (varyValue2 == masterKey[varyChamber2])) {
						if(keywayType == "KW1") {
							varyValue2 = randVal.nextInt(KW1MaxValue) + KW1MinValue;
						}
						else if(keywayType == "SC1") {
							varyValue2 = randVal.nextInt(SC1MaxValue) + SC1MinValue;
						}
					}
					
					//create the change key 
					for(int j = 0; j < combinationLength; j++) {
						if(j == varyChamber1) {
							changeKeyBitting[j] = varyValue1;
						}
						else if(j == varyChamber2) {
							changeKeyBitting[j] = varyValue2;
						}
						else {
							changeKeyBitting[j] = masterKey[j];
						}
					}
				}
				else if (numChangeKeys <= numViableKeys1Vary) {
					varyChamber1 = randVal.nextInt(combinationLength);
					
					//generate a random value for the chamber that is varied
					if(keywayType == "KW1") {
						varyValue1 = randVal.nextInt(KW1MaxValue) + KW1MinValue;
					}
					else if(keywayType == "SC1") {
						varyValue1 = randVal.nextInt(SC1MaxValue) + SC1MinValue;
					}
					
					//regenerate a random value for varyValue1 if value is invalid
					while (((masterKey[varyChamber1] % 2) != (varyValue1 % 2)) || (varyValue1 == masterKey[varyChamber1])) {
						if(keywayType == "KW1") {
							varyValue1 = randVal.nextInt(KW1MaxValue) + KW1MinValue;
						}
						else if(keywayType == "SC1") {
							varyValue1 = randVal.nextInt(SC1MaxValue) + SC1MinValue;
						}
					}
					
					//create change key 
					for(int j = 0; j < combinationLength; j++) {
						if(j == varyChamber1) {
							changeKeyBitting[j] = varyValue1;
						}
						else {
							changeKeyBitting[j] = masterKey[j];
						}
					}
				}
				else {
					System.out.println("Not possible to produce this may keys with this masterkey.\n");
					return;
				}
				//convert current change key biting from int[] to String
				for(int j = 0; j < combinationLength; j++) {
					tempKey += changeKeyBitting[j];
				}
				
				//checks if there exist a change key with same combination (within same job)
				if(!(isRepeatChangeKey(numKeysGenerated, changeKeys, tempKey))) {
					//checks if combination doesn't surpass it's macs value
					if((keywayType == "KW1") && checkMACSValue(KW1MACSValue, changeKeyBitting)) {
						isViableKey = true;
					}
					else if((keywayType == "SC1") && checkMACSValue(SC1MACSValue, changeKeyBitting)) {
						isViableKey = true;
					}
				}
			}
	
			changeKeys[numKeysGenerated] = tempKey;
			numKeysGenerated++;
			isViableKey = false;
		}
		
		displayChangeKeys(changeKeys, numChangeKeys);
		generateChangePins(numChangeKeys, masterKey, changeKeys);
		generateMasterPins(numChangeKeys, masterKey, changeKeys);
	}
	
	/* Generates the change key pins */
	private void generateChangePins(int numChangeKeys, int[] masterKey, String[] changeKeys) {
		String[] changeKeyPins = new String[numChangeKeys];
		String changeKeyPin = "";
		char tempChar;
		
		//compare each change key to the master key and take the lower values
		for(int i = 0; i < numChangeKeys; i++) {
			for(int j = 0; j < combinationLength; j++) {
				tempChar = (changeKeys[i]).charAt(j);
				
				if(masterKey[j] < Integer.parseInt(String.valueOf(tempChar))) {
					changeKeyPin += masterKey[j];
				}
				else if(Integer.parseInt(String.valueOf(tempChar)) < masterKey[j]) {
					changeKeyPin += tempChar;
				}
				else {
					changeKeyPin += masterKey[j];
				}
			}
			changeKeyPins[i] = changeKeyPin;
			changeKeyPin = "";
		}
		
		displayChangePins(changeKeyPins, numChangeKeys);
	}
	
	/* generates the master pins for each change key*/
	private void generateMasterPins(int numChangeKeys, int[] masterKey, String[] changeKeys) {
		String[] masterKeyPins = new String[numChangeKeys];
		String masterPin = "";
		char tempChar;
		int tempInt;
		int tempMasterPin;
		
		//take the difference of the master key and each change key to find the master pins
		for(int i = 0; i < numChangeKeys; i++) {
			for(int j = 0; j < combinationLength; j++) {
				tempChar = (changeKeys[i]).charAt(j);
				tempInt = Integer.parseInt(String.valueOf(tempChar));
				tempMasterPin = Math.abs(masterKey[j] - tempInt);
				masterPin += tempMasterPin;
			}
			masterKeyPins[i] = masterPin;
			masterPin = "";
		}
		
		displayMasterPins(masterKeyPins, numChangeKeys);
	}
}


