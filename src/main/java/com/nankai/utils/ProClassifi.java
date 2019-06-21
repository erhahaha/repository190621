package com.nankai.utils;

public class ProClassifi {


	//蔬菜类为4，其他类为5
	public static int productType(String proName){
		int type;
		switch (proName) {
		case "小麦":type=1;
			break;
		case "水稻":
		case "稻谷":type=2;
			break;
		case "玉米":type=3;
			break;
		case "高粱":
		case "鲜食玉米":
		case "桃":
		case "西瓜":
		case "葡萄":
		case "甜瓜":
		case "枣":
		case "冬枣":
		case "黄豆":type=5;
			break;
		default:type=4;
			break;
		}
		return type;
	}
}
