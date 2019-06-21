package com.nankai.service.Impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nankai.dao.SettingDao;
import com.nankai.service.SettingStandardService;

@Service
public class SettingStandardserviceImpl implements SettingStandardService {

	@Autowired
	private SettingDao settingdao;
	
	@Override
	public List<String> standards(int kind){
		List<String> results =new ArrayList<String>();
		List<String> elems= settingdao.findelements();
		for (int i = 0; i < elems.size(); i++) {
			List<String> kindofelem =settingdao.kindofelem(kind, elems.get(i));
			for (int j = 0; j < kindofelem.size(); j++) {
				switch(elems.get(i)){
					case "Cd": results.add("镉(Cd)");break;
					case "Hg": results.add("汞(Hg)");break;
					case "As": results.add("砷(As)");break;
					case "Cu": results.add("铜(Cu)");break;
					case "Pb": results.add("铅(Pb)");break;
					case "Cr": results.add("铬(Cr)");break;
					case "Zn": results.add("锌(Zn)");break;
					case "Ni": results.add("镍(Ni)");break;
				}
				results.add(kindofelem.get(j));
				results.addAll(settingdao.selectStandard(kind,elems.get(i),kindofelem.get(j)));
			}
		}
		return results;
	}
	
	@Override
	public List<String> findranges(int kind){
		List<String> results =new ArrayList<String>();
		List<String> ranges =settingdao.findranges(kind);
		for (int i = 0; i < ranges.size(); i++) {
			if(i==0)	results.add("PH&lt;="+ranges.get(i));
			else if(i==ranges.size()-1) results.add("PH&gt;"+ranges.get(i-1));
			else results.add(ranges.get(i-1)+"&lt;PH&lt;="+ranges.get(i));
		}
		return results;
	}
}
