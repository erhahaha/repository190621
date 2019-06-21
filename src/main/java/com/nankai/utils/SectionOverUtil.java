package com.nankai.utils;

import java.util.List;

public class SectionOverUtil {
	// 判断土壤超标情况及安全划分等级，0表示未超标无风险，1以上表示超标，
	// 1表示低风险，2表示中度风险，3表示高风险
	public static int overproof_one(String elem, String elemcontent, String ph, String product) {
		double result = 0;
		result = overproof(elem, elemcontent, ph, product);
		return (result <= 1) ? 0 : ((1 < result && result <= 2) ? 1 : ((2 < result && result <= 3) ? 2 : 3));
	}

	public static int overproof_all(List<String> elems, List<String> elemcontents, String ph, String product) {
		double result = 0;
		double max = 0;
		for (int i = 0; i < elems.size(); i++) {
			result = overproof(elems.get(i), elemcontents.get(i), ph, product);
			if (result > max)
				max = result;
		}
		return (result <= 1) ? 0 : ((1 < result && result <= 2) ? 1 : ((2 < result && result <= 3) ? 2 : 3));
	}

	public static double overproof_mean(String elem, String elemcontent, String ph, String product) {
		double result = 0;
		result = overproof(elem, elemcontent, ph, product);
		return (result <= 1) ? 0 : result;
	}

	private static double overproof(String elem, String elemcontent, String ph, String product) {
		double result = 0;
		switch (elem) {
		case "Cd":
			result = calculate3(ph, elemcontent, 0.3, 0.4, 0.5);
			break;
		case "Hg":
			result = calculate3(ph, elemcontent, 0.3, 0.5, 0.7);
			break;
		case "As":
			if (product == "水稻" || discernKind(product) == "蔬菜")
				result = calculate3(ph, elemcontent, 25, 20, 20);
			else
				result = calculate3(ph, elemcontent, 40, 30, 30);
			break;
		case "Pb":
			if (discernKind(product) == "蔬菜")
				result = calculate3(ph, elemcontent, 40, 60, 80);
			else
				result = calculate3(ph, elemcontent, 100, 150, 200);
			break;
		case "Cr":
			if (discernKind(product) == "蔬菜")
				result = calculate3(ph, elemcontent, 150, 200, 250);
			else
				result = calculate3(ph, elemcontent, 200, 250, 300);
			break;
		case "Zn":
			result = calculate3(ph, elemcontent, 200, 250, 300);
			break;
		case "Cu":
			if (discernKind(product) == "水果")
				result = calculate3(ph, elemcontent, 150, 200, 200);
			else
				result = calculate3(ph, elemcontent, 50, 100, 100);
			break;
		case "Ni":
			result = calculate3(ph, elemcontent, 40, 50, 60);
			break;
		}
		return result;
	}

	// 污染评价等级,0 代表无污染，1代表轻微污染，2代表轻度污染，3代表中度污染，4代表重度污染
	public static int pollutionlevel_one(String elem, String elemcontent, String ph, String product) {
		double result = 0;
		result = pollutionlevel(elem, elemcontent, ph, product);
		return (result <= 1) ? 0
				: ((1 < result && result <= 2) ? 1
						: ((2 < result && result <= 3) ? 2 : ((3 < result && result <= 5) ? 3 : 4)));
	}

	public static int pollutionlevel_all(List<String> elems, List<String> elemcontents, String ph, String product) {
		double result = 0;
		double max = 0;
		for (int i = 0; i < elems.size(); i++) {
			result = pollutionlevel(elems.get(i), elemcontents.get(i), ph, product);
			if (result > max)
				max = result;
		}
		return (result <= 1) ? 0
				: ((1 < result && result <= 2) ? 1
						: ((2 < result && result <= 3) ? 2 : ((3 < result && result <= 5) ? 3 : 4)));
	}

	private static double pollutionlevel(String elem, String elemcontent, String ph, String product) {
		double result = 0;
		switch (elem) {
		case "Cd":
			if (product == "水稻")
				result = calculate4(ph, elemcontent, 0.3, 0.4, 0.6, 0.8);
			else
				result = calculate4(ph, elemcontent, 0.3, 0.3, 0.3, 0.4);
			break;
		case "Hg":
			if (product == "水稻")
				result = calculate4(ph, elemcontent, 0.5, 0.5, 0.6, 1);
			else
				result = calculate4(ph, elemcontent, 1.3, 1.8, 2.4, 3.4);
			break;
		case "As":
			if (product == "水稻")
				result = calculate4(ph, elemcontent, 30, 30, 25, 20);
			else
				result = calculate4(ph, elemcontent, 40, 40, 30, 25);
			break;
		case "Pb":
			if (product == "水稻")
				result = calculate4(ph, elemcontent, 80, 100, 140, 240);
			else
				result = calculate4(ph, elemcontent, 70, 90, 120, 170);
			break;
		case "Cr":
			if (product == "水稻")
				result = calculate4(ph, elemcontent, 250, 250, 300, 350);
			else
				result = calculate4(ph, elemcontent, 150, 150, 200, 250);
			break;
		case "Zn":
			result = calculate4(ph, elemcontent, 200, 200, 250, 300);
			break;
		case "Cu":
			if (product == "水果")
				result = calculate4(ph, elemcontent, 150, 150, 200, 200);
			else
				result = calculate4(ph, elemcontent, 50, 50, 100, 100);
			break;
		case "Ni":
			result = calculate4(ph, elemcontent, 60, 70, 100,190);
			break;
		}
		return result;
	}

	/**
	 * 累积指数评价，求全量
	 * 
	 * @param 元素名称
	 * @param 元素对应含量
	 * @return 0 代表无累积，1代表轻度累积，2代表中度累积，3代表重度累积
	 */
	public static int accumulatlevel_one(String elem, String elemcontent) {
		double result = 0;
		result = accumulatlevel(elem, elemcontent);
		return (result <= 1) ? 0 : ((1 < result && result <= 2) ? 1 : ((2 < result && result <= 3) ? 2 : 3));
	}

	/**
	 * 累积指数评价，求综合
	 * 
	 * @param 元素名称
	 * @param 元素对应含量
	 * @return 0 代表无累积，1代表轻度累积，2代表中度累积，3代表重度累积
	 */
	public static int accumulatlevel_all(List<String> elems, List<String> elemcontents) {
		double max = 0;
		double all = 0;
		double result = 0;
		for (int i = 0; i < elems.size(); i++) {
			result = accumulatlevel(elems.get(i), elemcontents.get(i));
			all += result;
			if (result > max)
				max = result;
		}
		all /= 8;
		result = Math.sqrt((max * max + all * all) / 2);
		return (result <= 0.7) ? 0 : ((0.7 < result && result <= 1.4) ? 1 : ((1.4 < result && result <= 2.1) ? 2 : 3));
	}

	private static double accumulatlevel(String elem, String elemcontent) {
		double result = 0;
		switch (elem) {
		case "Cd":
			result = Double.parseDouble(elemcontent) / 0.09;
			break;
		case "Hg":
			result = Double.parseDouble(elemcontent) / 0.084;
			break;
		case "As":
			result = Double.parseDouble(elemcontent) / 9.6;
			break;
		case "Pb":
			result = Double.parseDouble(elemcontent) / 21.0;
			break;
		case "Cr":
			result = Double.parseDouble(elemcontent) / 84.2;
			break;
		case "Zn":
			result = Double.parseDouble(elemcontent) / 79.3;
			break;
		case "Cu":
			result = Double.parseDouble(elemcontent) / 28.8;
			break;
		case "Ni":
			result = Double.parseDouble(elemcontent) / 33.3;
			break;
		}
		return result;
	}

	private static double calculate3(String ph, String elemcontent, double denominator1, double denominator2,
			double denominator3) {
		double result = 0;
		if (Double.parseDouble(ph) <= 6.5) {
			result = Double.parseDouble(elemcontent) / denominator1;
		} else if (6.5 < Double.parseDouble(ph) && Double.parseDouble(ph) <= 7.5) {
			result = Double.parseDouble(elemcontent) / denominator2;
		} else {
			result = Double.parseDouble(elemcontent) / denominator3;
		}
		return result;
	}

	private static double calculate4(String ph, String elemcontent, double denominator1, double denominator2,
			double denominator3, double denominator4) {
		double result = 0;
		if (Double.parseDouble(ph) <= 5.5) {
			result = Double.parseDouble(elemcontent) / denominator1;
		} else if (5.5 < Double.parseDouble(ph) && Double.parseDouble(ph) <= 6.5) {
			result = Double.parseDouble(elemcontent) / denominator2;
		} else if (6.5 < Double.parseDouble(ph) && Double.parseDouble(ph) <= 7.5) {
			result = Double.parseDouble(elemcontent) / denominator3;
		} else {
			result = Double.parseDouble(elemcontent) / denominator4;
		}
		return result;
	}

	// 根据农产品分类
	private static String discernKind(String product) {
		String kind = null;
		switch (product) {
		case "水稻":
		case "小麦":
		case "玉米":
		case "高粱":
		case "鲜食玉米":
			kind = "谷物";
			break;
		case "桃":
		case "西瓜":
		case "葡萄":
		case "甜瓜":
		case "枣":
		case "冬枣":
			kind = "水果";
			break;
		case "黄豆":
			kind = "豆类";
			break;
		default:
			kind = "蔬菜";
			break;
		}
		return kind;
	}

	public static double calculatemean(List<Double> contents) {
		double result = 0;
		int num = 0;
		for (int i = 0; i < contents.size(); i++) {
			if (contents.get(i) != 0) {
				result += contents.get(i);
				num++;
			}
		}
		if (num == 0) {
			return 0;
		} else {
			return result / num;
		}
	}
}
