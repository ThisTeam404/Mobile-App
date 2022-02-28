package masterKeyAlgorithm;


public class MasterKeyAlgorithm {
	
	public static void main(String[] args) {
		String keywayType = "KW1";
		int numKeys = 20;
		int[] masterKey;
		
		CodeGenerator generateKeys = new CodeGenerator(keywayType);
		masterKey = generateKeys.getMasterKey();
		
		//print out master key
		System.out.print("Master Key: ");
		for(int i = 0; i < masterKey.length; i++) {
			System.out.print(masterKey[i]);
		}
		System.out.println("\n");
		
		//generates and displays change keys, change pins and master pins
		generateKeys.generateChangeKeys(numKeys, masterKey, keywayType);
	}
}
