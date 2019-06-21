package com.nankai.utils;



public class ProGradeSpy {
	
	public static int classify(double Pn){
		if(Pn<=0.6){
			return 1;
		}else if(Pn>=1){
			return 3;
		}else{
			return 2;
		}
	}
	
	
}
