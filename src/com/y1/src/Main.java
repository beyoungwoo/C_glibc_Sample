package com.y1.src;

public class Main {
	
	private static TwitterApi ta = new TwitterApi();

	public static void main(String[] args) throws InterruptedException {
		new Main().test();
	}

	public void test() {
		ta.GetFavorites();
		//ta.SearchUser();
	}
}
