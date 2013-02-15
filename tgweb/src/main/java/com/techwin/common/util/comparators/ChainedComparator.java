package com.techwin.common.util.comparators;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

public class ChainedComparator<T> implements Comparator<T> {

	private List<Comparator<T>> simpleComparators;
	
	@SafeVarargs
	public ChainedComparator(Comparator<T>... simpleComparators) {
		this.simpleComparators = Arrays.asList(simpleComparators);
	}
	
	public int compare(T o1, T o2) {
		for (Comparator<T> comparator : simpleComparators) {
			int result = comparator.compare(o1, o2) ;
			if (result != 0) {
				return result;
			}
		}
		
		return 0;
	}
}
