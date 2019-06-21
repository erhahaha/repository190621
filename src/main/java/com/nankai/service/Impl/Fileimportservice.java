package com.nankai.service.Impl;

import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.nankai.bean.*;
import com.nankai.dao.*;
import com.nankai.utils.ExcelUtil;

@Service
public class Fileimportservice {
/*
	@Autowired
	private UserDao userDao;*/
	
	@Autowired
	private SectionDao sectiondao;
	@Autowired
	private ProductDao productdao;
	
	
	@Transactional
	public void importExcelInfo(InputStream in, MultipartFile file) throws Exception{
	    List<List<Object>> listob = ExcelUtil.getBankListByExcel(in,file.getOriginalFilename());
	   
	    int excelyear=Double.valueOf(listob.get(0).get(2).toString()).intValue();
	    List<Integer> hasyears=sectiondao.findyears();
	    if(hasyears.contains(excelyear)){
	    	List<Integer> productids = sectiondao.findproductids(excelyear);
	    	for (Integer id : productids) {
	    		sectiondao.deleteproduct(id);
			}
	    	sectiondao.deleteregionanal(excelyear);
	    }
	    
	    for (int i = 0; i < listob.size(); i++) {
	        List<Object> ob = listob.get(i);
	        Product product=new Product();
	        Section section=new Section();
	        
	        //解析地区
	        String regionname=String.valueOf(ob.get(0)).trim();
	        int regionID;
	        switch(regionname){
		        case "东丽" : regionID=1; break;
		        case "津南" : regionID=2; break;
		        case "北辰" : regionID=3; break;
		        case "西青" : regionID=4; break;
		        case "汉沽" : regionID=5; break;
		        case "塘沽" : regionID=6; break;
		        case "大港" : regionID=7; break;
		        case "宝坻" : regionID=8; break;
		        case "宁河" : regionID=9; break;
		        case "蓟县" : regionID=10; break;
		        case "蓟州" : regionID=10; break;
		        case "静海" : regionID=11; break;
		        case "武清" : regionID=12; break;
		        default: regionID=1; break;
	        }
	       
	    
	        
	        try {
				//插入农作物记录
				product.setNumber(String.valueOf(ob.get(17)));
				product.setName(String.valueOf(ob.get(18)));
				productdao.insertProductInfo(product);
				int productID=product.getId();
      
				
				
				//插入地段记录
				section.setNumber(String.valueOf(ob.get(1)));
				  //年份可能是有小数的字符串，不能直接转换成int
				section.setYear(Double.valueOf(ob.get(2).toString()).intValue());
				section.setLongitude(String.valueOf(ob.get(3)));
				section.setLatitude(String.valueOf(ob.get(4)));
				section.setRegion_id(regionID);
				section.setProduct_id(productID);
				section.setTowns(String.valueOf(ob.get(5)));
				sectiondao.insertSectionInfo(section);
				int sectionID=section.getId();
				
				//插入地段重金属信息
				sectiondao.insertSection_elementInfo(sectionID, 1, String.valueOf(ob.get(6)));
				sectiondao.insertSection_elementInfo(sectionID, 2, String.valueOf(ob.get(7)));
				sectiondao.insertSection_elementInfo(sectionID, 3, String.valueOf(ob.get(8)));
				sectiondao.insertSection_elementInfo(sectionID, 4, String.valueOf(ob.get(9)));
				sectiondao.insertSection_elementInfo(sectionID, 5, String.valueOf(ob.get(10)));
				sectiondao.insertSection_elementInfo(sectionID, 6, String.valueOf(ob.get(11)));
				sectiondao.insertSection_elementInfo(sectionID, 7, String.valueOf(ob.get(12)));
				sectiondao.insertSection_elementInfo(sectionID, 8, String.valueOf(ob.get(13)));
				sectiondao.insertSection_elementInfo(sectionID, 9, String.valueOf(ob.get(14)));
				sectiondao.insertSection_elementInfo(sectionID, 10, String.valueOf(ob.get(15)));
				sectiondao.insertSection_elementInfo(sectionID, 11, String.valueOf(ob.get(16)));
				
				//插入农作物重金属信息
				productdao.insertProduct_elementInfo(productID, 1, String.valueOf(ob.get(19)));
				productdao.insertProduct_elementInfo(productID, 2, String.valueOf(ob.get(20)));
				productdao.insertProduct_elementInfo(productID, 3, String.valueOf(ob.get(21)));
				productdao.insertProduct_elementInfo(productID, 4, String.valueOf(ob.get(22)));
				productdao.insertProduct_elementInfo(productID, 5, String.valueOf(ob.get(23)));
				productdao.insertProduct_elementInfo(productID, 6, String.valueOf(ob.get(24)));
				productdao.insertProduct_elementInfo(productID, 7, String.valueOf(ob.get(25)));
				productdao.insertProduct_elementInfo(productID, 8, String.valueOf(ob.get(26)));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

	        
	    }
	    
	    
	}
	
	
	
	
}
