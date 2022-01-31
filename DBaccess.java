package lockthatdown;

import java.sql.*;

public class Assn4 {

    public void displayData(String urlStr,String username,String password)
  {

		  try
		  {
			  System.out.println("start the program!");
			  Class.forName ("com.mysql.jdbc.Driver").getDeclaredConstructor().newInstance();

			  Connection conn = DriverManager.getConnection(urlStr,username,password);
			  System.out.println ("Connected to the MySQL database");

			 

			
			  //Closing the connection to the database
			  conn.close();
			  System.out.println("Disconnected");


		  }
		  catch (Exception e)
		  {
			  e.printStackTrace();
		  }

  }

    public static void main(String[] args) {
		/*The server installed by IT is 5.7.35.
       For simplicity, I disabled SSL. You need to use this way for your homework assignment.
       In the newer versions,server should be already correctly configured to use SSL */

    	
// edit these lines if necessary    	
      String url= "jdbc:mysql://localhost:3306/test";
      String username= "root";
      // make a password and put it here
      String password = "";


		Assn4 example = new Assn4();
		example.displayData(url,username,password);
    }
}