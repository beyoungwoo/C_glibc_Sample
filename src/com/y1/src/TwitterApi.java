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
			// List<Status> statuses = twitter.getFavorites(); // 20개만 받아오기.
			for (int i = 1; i < 5; i++) { // page 단위로 20개 이상 받아오기.
				Paging paging = new Paging(i);
				List<Status> statuses = twitter.getFavorites("lIl___lIll", paging);
				for (Status status : statuses) {
					System.out.println("@" + status.getUser().getScreenName() + " - " + status.getText());
				}
			}
			System.out.println("done.");
			System.exit(0);
		} catch (TwitterException te) {
			te.printStackTrace();
			System.out.println("Failed to get favorites: " + te.getMessage());
			System.exit(-1);
		}
	}

	public void SearchUser(String inputUser) {

		try {
			Twitter twitter = new TwitterFactory().getInstance();
			int page = 1;
			ResponseList<User> users;
			do {
				users = twitter.searchUsers(inputUser, page);
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

	public void ShowUser(String inputUser) {
        try {
            Twitter twitter = new TwitterFactory().getInstance();
            User user = twitter.showUser(inputUser);
            if (user.getStatus() != null) {
                System.out.println("@" + user.getScreenName() + " - " + user.getStatus().getText());
            } else {
                // the user is protected
                System.out.println("@" + user.getScreenName());
            }
            System.exit(0);
        } catch (TwitterException te) {
            te.printStackTrace();
            System.out.println("Failed to delete status: " + te.getMessage());
            System.exit(-1);
        }
	}
}
