package api.runner;

import com.intuit.karate.junit5.Karate;

public class SmokeRunner {

	@Karate.Test
	public Karate runTest() {
		//address for our feature files. 
		//And tags 
		return Karate.run("classpath:features")
<<<<<<< HEAD
				.tags("@Random");
=======
				.tags("@Smoke");
>>>>>>> c646d1796b01a32552c3ab99e6a8d5858403606b
	}

}