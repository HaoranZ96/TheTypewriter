import twitter4j.*;

TwitterStream twitterStream;
String searchKeywords;
String[] twitterResults;
int i;


void setup() {
  // The whole setup will be packaged into the function, every time this function is called
  // the i will be given the value of 0
  i = 0;
  openTwitter();
  // Set the result number to three
  twitterResults = new String[3];
  // This is a place holder, in the main code, user will enter the search keywords.
  searchKeywords = "#London";
}

void draw() {
  // Keep the draw function to keep processing running.
}

void openTwitter() {
  
  ConfigurationBuilder cb = new ConfigurationBuilder();
  
  // Replace the *** with your own tokens and secrets!
  cb.setOAuthConsumerKey("GZFVJbyXeFEegWVHRY5KOuSxn");
  cb.setOAuthConsumerSecret("uzuKZUA8EZZWu8HCCnq4uYbjB9YGJ6uJKdKg2eKJ6rUdLAfhcB");
  cb.setOAuthAccessToken("1293839581004075013-YHHJoMPYMgtClW6wuKgC9Ec7CfdAZe");
  cb.setOAuthAccessTokenSecret("IGDHxPuHVsfp4JiZpYlwd9273NeTiAbN5Abe9DFIEsKn2");
  
  TwitterStream twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
  
  FilterQuery filtered = new FilterQuery();
  
  String keywords[] = {
    searchKeywords
  };
  
  filtered.track(keywords);
  
  twitterStream.addListener(listener);
  
  if (keywords.length == 0) {
    twitterStream.sample();
  } else {
    twitterStream.filter(filtered);
  }
}

StatusListener listener = new StatusListener() {

  public void onStatus(Status status) {
    System.out.println(status.getUser().getScreenName() + status.getText());
    // Pass the status value to the twitterResults array generator function
    generator(status);
  }
  
  // Catch some errors
  public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
    System.out.println("get status deletion notice" + statusDeletionNotice);
  }
  
  public void onScrubGeo(long userID, long upToStatusId) {
    System.out.println("get scrub notice: " + userID + "Up to status id: " + upToStatusId);
  }
  
  public void onTrackLimitationNotice(int numberOfLimitedStatus) {
    System.out.println("Track limitation notice: " + numberOfLimitedStatus);
  }
  
  public void onStallWarning(StallWarning warning) {
    System.out.println("stall warning: " + warning);
  }
  
  public void onException(Exception ex) {
    ex.printStackTrace();
  }
};

// This is the generator function which will put the text into an array of results.
void generator(Status status) {
  if(i<3) {
    twitterResults[i] = status.getText();
    i++;
  } else {
    // This is the place to initalise the print function!!
  }
}
