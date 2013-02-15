package com.techwin.common.util.comparators;

import java.util.Map;

@SuppressWarnings("rawtypes")
public class MapAlphanumComparator extends AlphanumComparator {

	private String key = "id";
	
	public MapAlphanumComparator() {}
	
	public MapAlphanumComparator(String key) {
		this.key = key;
	}

	@Override
	public int compare(Object o1, Object o2) {
		if (!(o1 instanceof Map) || !(o2 instanceof Map)) { return 0; }
		Object so1 = ((Map)o1).get(key);
		Object so2 = ((Map)o2).get(key);

		return super.compareWithString(so1, so2);
	}
}