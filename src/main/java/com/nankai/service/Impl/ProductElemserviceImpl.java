package com.nankai.service.Impl;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nankai.bean.BasicInfo;
import com.nankai.bean.Section;
import com.nankai.dao.ProductDao;
import com.nankai.service.ProductElemService;

@Service
public class ProductElemserviceImpl implements ProductElemService{

	@Autowired
	ProductDao productdao;
	
	
	//查询某区域所选的农作物
	@Override
		public List<Section> findproductOfRegion(int year,String regionName){
			List<Section> resultmap;
			resultmap=productdao.selectproductOfRegion(year, regionName);
			
			return resultmap;		
		}
	
		//查询某年某区域农作物重金属含量最大值，最小值，平均值
	@Override
			public Map<String,Object> findEleStatisOfRegion(int year,String regionName,int eleid){
			Map<String,Object> resultmap = new HashMap<String,Object>();
			Map<String,Object> maxmap,minmap,avgmap;
			maxmap=productdao.selectproductElemax(year, regionName, eleid);
			minmap=productdao.selectproductElemin(year, regionName, eleid);
			avgmap=productdao.selectproductEleavg(year, regionName, eleid);
			if(maxmap==null||avgmap==null){
				resultmap.put("maxcontent", 0);
				resultmap.put("nameOfmax", 0);	
				resultmap.put("mincontent", 0);
				resultmap.put("nameofmin", 0);
				resultmap.put("avgcontent", 0);
			}else{
				resultmap.put("maxcontent", maxmap.get("maxcontent"));
				resultmap.put("nameOfmax", maxmap.get("nameOfmax"));	
				resultmap.put("mincontent", minmap.get("mincontent"));
				resultmap.put("nameofmin", minmap.get("nameOfmin"));
				resultmap.put("avgcontent", avgmap.get("avgcontent"));
			}
				return resultmap;		
			}
	
		@Override
			public List<BasicInfo> findBasicInfo(int year, String regionName) {
				List<BasicInfo> result = productdao.selectProductInfo(year, regionName);
				DecimalFormat df = new DecimalFormat("0.00000");// 设置double后小数点的位数
				for(int i=0;i<result.size();i++){
					result.get(i).setName(regionName);
					result.get(i).setYear(year);
					String a= result.get(i).getElemCd();
					boolean c=(a.equals("0"));
					String b=df.format(Double.valueOf(result.get(i).getElemCd()));
					result.get(i).setElemCd(result.get(i).getElemCd().equals("0")?"0":df.format(Double.valueOf(result.get(i).getElemCd())));
					result.get(i).setElemHg(result.get(i).getElemHg().equals("0")?"0":df.format(Double.valueOf(result.get(i).getElemHg())));
					result.get(i).setElemAs(result.get(i).getElemAs().equals("0")?"0":df.format(Double.valueOf(result.get(i).getElemAs())));
					result.get(i).setElemCu(result.get(i).getElemCu().equals("0")?"0":df.format(Double.valueOf(result.get(i).getElemCu())));
					result.get(i).setElemPb(result.get(i).getElemPb().equals("0")?"0":df.format(Double.valueOf(result.get(i).getElemPb())));
					result.get(i).setElemCr(result.get(i).getElemCr().equals("0")?"0":df.format(Double.valueOf(result.get(i).getElemCr())));
					result.get(i).setElemZn(result.get(i).getElemZn().equals("0")?"0":df.format(Double.valueOf(result.get(i).getElemZn())));
					result.get(i).setElemNi(result.get(i).getElemNi().equals("0")?"0":df.format(Double.valueOf(result.get(i).getElemNi())));
					/*result.get(i).setElemCd(df.format(Double.valueOf(result.get(i).getElemCd())));
					result.get(i).setElemHg(df.format(Double.valueOf(result.get(i).getElemHg())));
					result.get(i).setElemAs(df.format(Double.valueOf(result.get(i).getElemAs())));
					result.get(i).setElemCu(df.format(Double.valueOf(result.get(i).getElemCu())));
					result.get(i).setElemPb(df.format(Double.valueOf(result.get(i).getElemPb())));
					result.get(i).setElemCr(df.format(Double.valueOf(result.get(i).getElemCr())));
					result.get(i).setElemZn(df.format(Double.valueOf(result.get(i).getElemZn())));
					result.get(i).setElemNi(df.format(Double.valueOf(result.get(i).getElemNi())));*/
				}
				return result;
			}
}
