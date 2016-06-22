package com.y1.src;

import twitter4j.*;

import java.util.Properties;
import java.util.List;
import java.awt.*;
import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;

public class TwitterApi {

	public void GetFavorites() {
		try {
			Twitter twitter = new TwitterFactory().getInstance();
			List<Status> statuses = twitter.getFavorites();
			for (Status status : statuses) {
				System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText());
			}
			System.out.println("done.");
			System.exit(0);
		} catch (TwitterException te) {
			te.printStackTrace();
			System.out.println("Failed to get favorites: " + te.getMessage());
			System.exit(-1);
		}
	}

	public void SearchUser() {
        try {
            Twitter twitter = new TwitterFactory().getInstance();
            int page = 1;
            ResponseList<User> users;
            do {
                users = twitter.searchUsers("enhance", page);
                for (User user : users) {
                    if (user.getStatus() != null) {
                        System.out.println("@" + user.getScreenName() + " - " + user.getStatus().getText());
                    } else {
                        // the user is protected
                        System.out.println("@" + user.getScreenName());
                    }
                }
                page++;
            } while (users.size() != 0 && page < 50);
            System.out.println("done.");
            System.exit(0);
        } catch (TwitterException te) {
            te.printStackTrace();
            System.out.println("Failed to search users: " + te.getMessage());
            System.exit(-1);
        }
	}
}
