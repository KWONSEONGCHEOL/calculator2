package com.juht.calculator;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
/** This is calcluator sevice class
    Hongtaek Ju
*/
@Service
public class Calculator {
	@Cacheable
	int sum(int a, int b){
		return a+b;
	}
	int dif(int a, int b){
		return a-b;
	}
}
