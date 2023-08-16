package api.utility.data;

public class GenerateData {

	public static String getEmail() {
		String prefix = "Software.tester";
		String provider = "@tekschool.us";		
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider; 
		return email;
	}
	
//	Generate Random Phone number
//	@return String random phone number
	
	public static String getPhoneNumber() {
	String phoneNumber = "2";
	for( int i = 0 ; i <9 ; i++) {
		 phoneNumber +=(int)(Math.random()* 10);
	}
		return phoneNumber;
	}
	
	public static String getAddress() {

		String prefix = "Edsall Rd";
		String provider ="Alexandria, Va";
		int random = (int)(Math.random() * 4);
		int zipcode =(int)(Math.random()* 5);
		String autoAddress = random + prefix + zipcode + provider;
		return autoAddress;
	}
	public static void main(String [] args) {
		System.out.println(getAddress());
	}
	}
 



	




