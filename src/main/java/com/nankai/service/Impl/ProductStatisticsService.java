package com.nankai.service.Impl;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nankai.bean.EleOverProof;
import com.nankai.dao.ProductStatisticsDao;
import com.nankai.utils.ProClassifi;
import com.nankai.utils.ProGradeSpy;

@Service
public class ProductStatisticsService {

	
	@Autowired
	ProductStatisticsDao productStatisticsDao;
	
	//用于存储各类农作物在各个行政区的超标点数量（五种重金属有一种超标即为超标点）
	public int[][] proInSectionOverPoint=new int[5][12];
	
	//用于存放各类农作物各种重金属的平均超标倍数
	public double[][] proEleAvgMulti=new double[5][5];
	
	//农产品等级统计
	//按农作物分类
	public int[][] proClassGradeCount=new int[5][3];
	//按行政区分类
	public int[][][] proSecGradeCount=new int[5][12][3];
	
	
	//三级农产品中的极值：5种农产品，5种重金属，3种极值
	public double[][][] proExtreThGrade=new double[5][5][3];
	
	//格式化
	DecimalFormat df = new DecimalFormat("#.00");
	
	//重金属含量极值和平均值
	public List<Map<String,Object>> findProEleExtre(String proScope,int year){
		
		List<Map<String,Object>> eleExtreList;
		eleExtreList=productStatisticsDao.selectproEleExtre(proScope, year);
		return eleExtreList;
	}
	
	//采样点数量
	public Map<String, Object>[] findProscnCount(String proScope,int year){
			Map<String,Object>[] mapArr=new Map[13];
			List<Map<String, Object>> scnCountList;
			scnCountList=productStatisticsDao.selectproScnCount(proScope, year);
			long allcount=0;
			for(Map<String, Object> m:scnCountList){
				//数据库中查询出的region_id为double型的话不能强转成string。结果只能在查询语句中强转
				int tempI=(int)m.get("region_id")-1;
				if(mapArr[tempI]!=null){
					Object tem=mapArr[tempI].get("count");
					mapArr[tempI].put("count", (long)tem+(long)m.get("count"));
				}else{
					mapArr[tempI]=m;
				}
				
				allcount+=(long)m.get("count");
			}
			
			for(int i=0;i<12;i++){
				if(mapArr[i]==null){
					long count=0;
					Map<String,Object> temp=new HashMap<>();
					temp.put("year", year);
					temp.put("region_id", i+1);
					temp.put("count", count);
					mapArr[i]=temp;
				}
			}
			Map<String,Object> temp=new HashMap<>();
			temp.put("allcount", allcount);
			mapArr[12]=temp;
			return mapArr;
		}
	
//表16.	不同行政区各类重金属超标情况	
	public int[][] sectionEleOver(int year)	{
		List<EleOverProof> opListAs=productStatisticsDao.selectOverProofSection("overproofas",year);
		List<EleOverProof> opListHg=productStatisticsDao.selectOverProofSection("overproofhg",year);
		List<EleOverProof> opListPb=productStatisticsDao.selectOverProofSection("overproofpb",year);
		List<EleOverProof> opListCd=productStatisticsDao.selectOverProofSection("overproofcd",year);
		List<EleOverProof> opListCr=productStatisticsDao.selectOverProofSection("overproofcr",year);
		//前五行存放每种重金属的超标点数量。最后一行存放各个行政区超标点数量（五种重金属中有一种超标即为超标）
		int[][] result=new int[6][13];
		
		//set中存储各类农作物超标点的sectionID，因为set中元素不重复，所以可以确保每个点位只存储一次。
		//泛型必须是包装类，不能是基本类型
		Set[] sectionIDSet=new HashSet[12];
		for(int i=0;i<12;i++){
			sectionIDSet[i]=new HashSet<Long>();
		}
		
		
		for(EleOverProof e:opListAs){
			result[0][Integer.parseInt(e.getRegionID())-1]++;
			result[0][12]++;
			sectionIDSet[Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
		}
		for(EleOverProof e:opListHg){
			result[1][Integer.parseInt(e.getRegionID())-1]++;
			result[1][12]++;
			sectionIDSet[Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
		}
		for(EleOverProof e:opListPb){
			result[2][Integer.parseInt(e.getRegionID())-1]++;
			result[2][12]++;
			sectionIDSet[Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
		}
		for(EleOverProof e:opListCd){
			result[3][Integer.parseInt(e.getRegionID())-1]++;
			result[3][12]++;
			sectionIDSet[Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
		}
		for(EleOverProof e:opListCr){
			result[4][Integer.parseInt(e.getRegionID())-1]++;
			result[4][12]++;
			sectionIDSet[Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
		}
		
		int sum=0;
		for(int i=0;i<12;i++){
			int temp=sectionIDSet[i].size();
			result[5][i]=temp;
			sum+=temp;
		}
		result[5][12]=sum;
		
		return result;
		
	}
		
//表17.	不同种植类型的农产品重金属超标情况
//超标点数量
//超标倍数
	public int[][] productEleOver(int year)	{
		List<EleOverProof> opListAs=productStatisticsDao.selectOverProofSection("overproofas",year);
		List<EleOverProof> opListHg=productStatisticsDao.selectOverProofSection("overproofhg",year);
		List<EleOverProof> opListPb=productStatisticsDao.selectOverProofSection("overproofpb",year);
		List<EleOverProof> opListCd=productStatisticsDao.selectOverProofSection("overproofcd",year);
		List<EleOverProof> opListCr=productStatisticsDao.selectOverProofSection("overproofcr",year);
		//数组第五行存储总数。0-4列存储as,hg……的农作物超标数量。第5列存储各类农作物超标点数量（五种重金属有一种超标该点即超标。）
		int[][] result=new int[6][6];
		//set中存储各类农作物超标点的sectionID，因为set中元素不重复，所以可以确保每个点位只存储一次。
		//泛型必须是包装类，不能是基本类型
		Set[] sectionIDSet=new HashSet[5];
		for(int i=0;i<5;i++){
			sectionIDSet[i]=new HashSet<Long>();
		}
		//set中存储各类农作物在每个行政区的超标点的sectionID，因为set中元素不重复，所以可以确保每个点位只存储一次。
		Set[][] sectionIDSetPartsec=new HashSet[5][12];
		for(int i=0;i<5;i++){
			for(int j=0;j<12;j++){
				sectionIDSetPartsec[i][j]=new HashSet<Long>();
			}
		}
		
		//农作物对应元素超标倍数的总和
		//行  对应蔬菜种类；列   对应重金属
		double[][] multiSum=new double[5][5];
		//农作物对应元素超标的点统计
		double[][] multiCount=new double[5][5];
		
		
		//开始逐一遍历
		for(EleOverProof e:opListAs){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				result[0][0]++;
				result[5][0]++;
				//小麦类的点位号
				sectionIDSet[0].add(e.getSectionID());
				//小麦类在某个行政区的点位号加入set
				sectionIDSetPartsec[0][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				//存放超标倍数和超标数量的二维数组，方便后面计算平均超标倍数。
				multiSum[0][0]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[0][0]++;
			}
			break;
			//水稻
			case 2:
			{
				result[1][0]++;
				result[5][0]++;
				//水稻类的点位号
				sectionIDSet[1].add(e.getSectionID());
				sectionIDSetPartsec[1][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				//存放超标倍数和超标数量的二维数组，方便后面计算平均超标倍数。
				multiSum[1][0]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[1][0]++;
			}
			break;
			//玉米
			case 3:
			{
				result[2][0]++;
				result[5][0]++;
				//玉米类的点位号
				sectionIDSet[2].add(e.getSectionID());
				sectionIDSetPartsec[2][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				//存放超标倍数和超标数量的二维数组，方便后面计算平均超标倍数。
				multiSum[2][0]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[2][0]++;
			}
			break;
			//蔬菜
			case 4:
			{
				result[3][0]++;
				result[5][0]++;
				//蔬菜类的点位号
				sectionIDSet[3].add(e.getSectionID());
				sectionIDSetPartsec[3][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				//存放超标倍数和超标数量的二维数组，方便后面计算平均超标倍数。
				multiSum[3][0]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[3][0]++;
			}
			break;
			//其他类
			case 5:
			{
				result[4][0]++;
				result[5][0]++;
				//其他类的点位号
				sectionIDSet[4].add(e.getSectionID());
				sectionIDSetPartsec[4][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				//存放超标倍数和超标数量的二维数组，方便后面计算平均超标倍数。
				multiSum[4][0]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[4][0]++;
			}
			break;
			
			default:
				break;
			}
		}
		for(EleOverProof e:opListHg){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				result[0][1]++;
				result[5][1]++;
				//小麦类的点位号
				sectionIDSet[0].add(e.getSectionID());
				sectionIDSetPartsec[0][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				//存放超标倍数和超标数量的二维数组，方便后面计算平均超标倍数。
				multiSum[0][1]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[0][1]++;
			}
			break;
			//水稻
			case 2:
			{
				result[1][1]++;
				result[5][1]++;
				//水稻类的点位号
				sectionIDSet[1].add(e.getSectionID());
				sectionIDSetPartsec[1][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[1][1]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[1][1]++;
			}
			break;
			//玉米
			case 3:
			{
				result[2][1]++;
				result[5][1]++;
				//玉米类的点位号
				sectionIDSet[2].add(e.getSectionID());
				sectionIDSetPartsec[2][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[2][1]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[2][1]++;
			}
			break;
			//蔬菜
			case 4:
			{
				result[3][1]++;
				result[5][1]++;
				//蔬菜类的点位号
				sectionIDSet[3].add(e.getSectionID());
				sectionIDSetPartsec[3][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[3][1]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[3][1]++;
			}
			break;
			//其他类
			case 5:
			{
				result[4][1]++;
				result[5][1]++;
				//其他类的点位号
				sectionIDSet[4].add(e.getSectionID());
				sectionIDSetPartsec[4][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[4][1]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[4][1]++;
			}
			break;
			
			default:
				break;
			}
		}
		for(EleOverProof e:opListPb){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				result[0][2]++;
				result[5][2]++;
				//小麦类的点位号
				sectionIDSet[0].add(e.getSectionID());
				sectionIDSetPartsec[0][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[0][2]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[0][2]++;
			}
			break;
			//水稻
			case 2:
			{
				result[1][2]++;
				result[5][2]++;
				//水稻类的点位号
				sectionIDSet[1].add(e.getSectionID());
				sectionIDSetPartsec[1][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[1][2]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[1][2]++;
			}
			break;
			//玉米
			case 3:
			{
				result[2][2]++;
				result[5][2]++;
				//玉米类的点位号
				sectionIDSet[2].add(e.getSectionID());
				sectionIDSetPartsec[2][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[2][2]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[2][2]++;
			}
			break;
			//蔬菜
			case 4:
			{
				result[3][2]++;
				result[5][2]++;
				//蔬菜类的点位号
				sectionIDSet[3].add(e.getSectionID());
				sectionIDSetPartsec[3][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[3][2]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[3][2]++;
			}
			break;
			//其他类
			case 5:
			{
				result[4][2]++;
				result[5][2]++;
				//其他类的点位号
				sectionIDSet[4].add(e.getSectionID());
				sectionIDSetPartsec[4][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[4][2]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[4][2]++;
			}
			break;
			
			default:
				break;
			}
		}
		for(EleOverProof e:opListCd){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				result[0][3]++;
				result[5][3]++;
				//小麦类的点位号
				sectionIDSet[0].add(e.getSectionID());
				sectionIDSetPartsec[0][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[0][3]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[0][3]++;
			}
			break;
			//水稻
			case 2:
			{
				result[1][3]++;
				result[5][3]++;
				//水稻类的点位号
				sectionIDSet[1].add(e.getSectionID());
				sectionIDSetPartsec[1][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[1][3]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[1][3]++;
			}
			break;
			//玉米
			case 3:
			{
				result[2][3]++;
				result[5][3]++;
				//玉米类的点位号
				sectionIDSet[2].add(e.getSectionID());
				sectionIDSetPartsec[2][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[2][3]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[2][3]++;
			}
			break;
			//蔬菜
			case 4:
			{
				result[3][3]++;
				result[5][3]++;
				//蔬菜类的点位号
				sectionIDSet[3].add(e.getSectionID());
				sectionIDSetPartsec[3][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[3][3]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[3][3]++;
			}
			break;
			//其他类
			case 5:
			{
				result[4][3]++;
				result[5][3]++;
				//其他类的点位号
				sectionIDSet[4].add(e.getSectionID());
				sectionIDSetPartsec[4][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[4][3]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[4][3]++;
			}
			break;
			
			default:
				break;
			}
		}
		for(EleOverProof e:opListCr){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				result[0][4]++;
				result[5][4]++;
				//小麦类的点位号
				sectionIDSet[0].add(e.getSectionID());
				sectionIDSetPartsec[0][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[0][4]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[0][4]++;
			}
			break;
			//水稻
			case 2:
			{
				result[1][4]++;
				result[5][4]++;
				//水稻类的点位号
				sectionIDSet[1].add(e.getSectionID());
				sectionIDSetPartsec[1][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[1][4]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[1][4]++;
			}
			break;
			//玉米
			case 3:
			{
				result[2][4]++;
				result[5][4]++;
				//玉米类的点位号
				sectionIDSet[2].add(e.getSectionID());
				sectionIDSetPartsec[2][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[2][4]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[2][4]++;
			}
			break;
			//蔬菜
			case 4:
			{
				result[3][4]++;
				result[5][4]++;
				//蔬菜类的点位号
				sectionIDSet[3].add(e.getSectionID());
				sectionIDSetPartsec[3][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[3][4]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[3][4]++;
			}
			break;
			//其他类
			case 5:
			{
				result[4][4]++;
				result[5][4]++;
				//其他类的点位号
				sectionIDSet[4].add(e.getSectionID());
				sectionIDSetPartsec[4][Integer.parseInt(e.getRegionID())-1].add(e.getSectionID());
				multiSum[4][4]+=e.getElecontent()/Double.parseDouble(e.getTopline());
				multiCount[4][4]++;
			}
			break;
			
			default:
				break;
			}
		}
		
		int sum=0;
		for(int i=0;i<5;i++){
			int temp=sectionIDSet[i].size();
			result[i][5]=temp;
			sum+=temp;
		}
		result[5][5]=sum;
		
		for(int i=0;i<5;i++){
			for(int j=0;j<12;j++){
				proInSectionOverPoint[i][j]=sectionIDSetPartsec[i][j].size();
			}
		}
		
		
		for(int i=0;i<5;i++){
			for(int j=0;j<5;j++){
				proEleAvgMulti[i][j]=multiCount[i][j]==0?0:Double.parseDouble(df.format(multiSum[i][j]/multiCount[i][j]));
			}
		}
		
		return result;
		
	}

	
	
	
	
	
	
	
//统计农产品等级	
	public void StaProDataWithPn(int year)	{
		List<EleOverProof> ListAs=productStatisticsDao.selectDataWithPn("overproofas",year);
		List<EleOverProof> ListHg=productStatisticsDao.selectDataWithPn("overproofhg",year);
		List<EleOverProof> ListPb=productStatisticsDao.selectDataWithPn("overproofpb",year);
		List<EleOverProof> ListCd=productStatisticsDao.selectDataWithPn("overproofcd",year);
		List<EleOverProof> ListCr=productStatisticsDao.selectDataWithPn("overproofcr",year);
		
		//按农作物分类
		Set<Long>[][] proClassGrade=new HashSet[5][3];
		//按行政区分类
		Set<Long>[][][] proSecGrade=new HashSet[5][12][3];
		for(int i=0;i<5;i++){
			for(int j=0;j<3;j++){
				proClassGrade[i][j]=new HashSet<Long>();
			}
		}
		for(int i=0;i<5;i++){
			for(int j=0;j<12;j++){
				for(int k=0;k<3;k++){
					proSecGrade[i][j][k]=new HashSet<Long>();
				}
			}
		}
		
		//开始逐一遍历
		for(EleOverProof e:ListAs){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[0][0].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[0][1].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[0][2].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//水稻
			case 2:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[1][0].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[1][1].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[1][2].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//玉米
			case 3:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[2][0].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[2][1].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[2][2].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//蔬菜
			case 4:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[3][0].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[3][1].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[3][2].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//其他类
			case 5:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[4][0].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[4][1].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[4][2].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			
			default:
				break;
			}
		}
		for(EleOverProof e:ListHg){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[0][0].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[0][1].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[0][2].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//水稻
			case 2:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[1][0].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[1][1].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[1][2].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//玉米
			case 3:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[2][0].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[2][1].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[2][2].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//蔬菜
			case 4:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[3][0].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[3][1].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[3][2].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//其他类
			case 5:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[4][0].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[4][1].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[4][2].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			
			default:
				break;
			}
		}
		for(EleOverProof e:ListPb){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[0][0].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[0][1].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[0][2].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//水稻
			case 2:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[1][0].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[1][1].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[1][2].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//玉米
			case 3:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[2][0].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[2][1].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[2][2].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//蔬菜
			case 4:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[3][0].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[3][1].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[3][2].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//其他类
			case 5:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[4][0].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[4][1].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[4][2].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			
			default:
				break;
			}
		}
		for(EleOverProof e:ListCd){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[0][0].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[0][1].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[0][2].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//水稻
			case 2:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[1][0].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[1][1].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[1][2].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//玉米
			case 3:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[2][0].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[2][1].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[2][2].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//蔬菜
			case 4:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[3][0].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[3][1].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[3][2].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//其他类
			case 5:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[4][0].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[4][1].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[4][2].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			
			default:
				break;
			}
		}
		for(EleOverProof e:ListCr){
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[0][0].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[0][1].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[0][2].add(e.getSectionID());
					proSecGrade[0][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//水稻
			case 2:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[1][0].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[1][1].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[1][2].add(e.getSectionID());
					proSecGrade[1][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//玉米
			case 3:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[2][0].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[2][1].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[2][2].add(e.getSectionID());
					proSecGrade[2][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//蔬菜
			case 4:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[3][0].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[3][1].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[3][2].add(e.getSectionID());
					proSecGrade[3][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			//其他类
			case 5:
			{
				if(ProGradeSpy.classify(e.getPn())==1){
					proClassGrade[4][0].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][0].add(e.getSectionID());
				}else if(ProGradeSpy.classify(e.getPn())==2){
					proClassGrade[4][1].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][1].add(e.getSectionID());
				}else{
					proClassGrade[4][2].add(e.getSectionID());
					proSecGrade[4][Integer.parseInt(e.getRegionID())-1][2].add(e.getSectionID());
				}	
			}
			break;
			
			default:
				break;
			}
		}
		
		
		//去重：三等农产品的set等级最高，其中有的regionID另外两个都不能有
		for(int i=0;i<5;i++){
			for(long id:proClassGrade[i][2]){
				if(proClassGrade[i][0].contains(id)){proClassGrade[i][0].remove(id);}
				if(proClassGrade[i][1].contains(id)){proClassGrade[i][1].remove(id);}
			}
			for(long id:proClassGrade[i][1]){
				if(proClassGrade[i][0].contains(id)){proClassGrade[i][0].remove(id);}
			}
		}
		//去重：对每个行政区去重。机制同农产品种类去重。
		for(int i=0;i<5;i++){
			for(int j=0;j<12;j++){
				for(long id:proSecGrade[i][j][2]){
					if(proSecGrade[i][j][0].contains(id)){proSecGrade[i][j][0].remove(id);}
					if(proSecGrade[i][j][1].contains(id)){proSecGrade[i][j][1].remove(id);}
				}
				for(long id:proSecGrade[i][j][1]){
					if(proSecGrade[i][j][0].contains(id)){proSecGrade[i][j][0].remove(id);}
				}
			}
			
		}
		//统计个数
		for(int i=0;i<5;i++){
			for(int j=0;j<3;j++){
				proClassGradeCount[i][j]=proClassGrade[i][j].size();
			}
		}
		for(int i=0;i<5;i++){
			for(int j=0;j<12;j++){
				for(int k=0;k<3;k++){
					proSecGradeCount[i][j][k]=proSecGrade[i][j][k].size();
				}
			}
		}
		
		
		/**
		 * 参照：proClassGrade[0-4][2]
		 * 遍历各个种类农作物中的三级产品，统计各种重金属的最大值最小值平均值*/
		//小麦中五种重金属最大值最小值平均值，其中平均值中首先存储总和，最后计算
		double[][] wheatExtre=new double[5][3];
		double[][] RiceExtre=new double[5][3];
		double[][] cornExtre=new double[5][3];
		double[][] vegetablesExtre=new double[5][3];
		double[][] otherExtre=new double[5][3];
		//记录数量：行存储农作物种类，列存储重金属种类
		int[][] count=new int[5][5];
		//遍历AS重金属
		for(EleOverProof e:ListAs){
			
			switch (ProClassifi.productType(e.getName())) {
			//小麦
			case 1:
			{
				//小麦类
				if(proClassGrade[0][2].contains(e.getSectionID())){
					double temp=e.getElecontent();
					if(temp>wheatExtre[0][0]){wheatExtre[0][0]=temp;}
					if(temp<wheatExtre[0][1]){wheatExtre[0][1]=temp;}
					wheatExtre[0][2]+=temp;
					count[0][0]++;
				}
			}
			break;
			//水稻
			case 2:
			{
				//水稻类
				if(proClassGrade[1][2].contains(e.getSectionID())){
					double temp=e.getElecontent();
					if(temp>RiceExtre[0][0]){RiceExtre[0][0]=temp;}
					if(temp<RiceExtre[0][1]){RiceExtre[0][1]=temp;}
					RiceExtre[0][2]+=temp;
					count[1][0]++;
				}
			}
			break;
			//玉米
			case 3:
			{
				//玉米类
				if(proClassGrade[2][2].contains(e.getSectionID())){
					double temp=e.getElecontent();
					if(temp>cornExtre[0][0]){cornExtre[0][0]=temp;}
					if(temp<cornExtre[0][1]){cornExtre[0][1]=temp;}
					cornExtre[0][2]+=temp;
					count[2][0]++;
				}
			}
			break;
			//蔬菜
			case 4:
			{
				//蔬菜类
				if(proClassGrade[3][2].contains(e.getSectionID())){
					double temp=e.getElecontent();
					if(temp>vegetablesExtre[0][0]){vegetablesExtre[0][0]=temp;}
					if(temp<vegetablesExtre[0][1]){vegetablesExtre[0][1]=temp;}
					vegetablesExtre[0][2]+=temp;
					count[3][0]++;
				}
			}
			break;
			//其他类
			case 5:
			{
				//蔬菜类
				if(proClassGrade[4][2].contains(e.getSectionID())){
					double temp=e.getElecontent();
					if(temp>otherExtre[0][0]){otherExtre[0][0]=temp;}
					if(temp<otherExtre[0][1]){otherExtre[0][1]=temp;}
					otherExtre[0][2]+=temp;
					count[4][0]++;
				}
			}
			break;
			
			default:
				break;
			}
		}
		//遍历Hg重金属
				for(EleOverProof e:ListHg){
					
					switch (ProClassifi.productType(e.getName())) {
					//小麦
					case 1:
					{
						//小麦类
						if(proClassGrade[0][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>wheatExtre[1][0]){wheatExtre[1][0]=temp;}
							if(temp<wheatExtre[1][1]){wheatExtre[1][1]=temp;}
							wheatExtre[1][2]+=temp;
							count[0][1]++;
						}
					}
					break;
					//水稻
					case 2:
					{
						//水稻类
						if(proClassGrade[1][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>RiceExtre[1][0]){RiceExtre[1][0]=temp;}
							if(temp<RiceExtre[1][1]){RiceExtre[1][1]=temp;}
							RiceExtre[1][2]+=temp;
							count[1][1]++;
						}
					}
					break;
					//玉米
					case 3:
					{
						//玉米类
						if(proClassGrade[2][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>cornExtre[1][0]){cornExtre[1][0]=temp;}
							if(temp<cornExtre[1][1]){cornExtre[1][1]=temp;}
							cornExtre[1][2]+=temp;
							count[2][1]++;
						}
					}
					break;
					//蔬菜
					case 4:
					{
						//蔬菜类
						if(proClassGrade[3][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>vegetablesExtre[1][0]){vegetablesExtre[1][0]=temp;}
							if(temp<vegetablesExtre[1][1]){vegetablesExtre[1][1]=temp;}
							vegetablesExtre[1][2]+=temp;
							count[3][1]++;
						}
					}
					break;
					//其他类
					case 5:
					{
						//蔬菜类
						if(proClassGrade[4][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>otherExtre[1][0]){otherExtre[1][0]=temp;}
							if(temp<otherExtre[1][1]){otherExtre[1][1]=temp;}
							otherExtre[1][2]+=temp;
							count[4][1]++;
						}
					}
					break;
					
					default:
						break;
					}
				}
				//遍历Pb重金属
				for(EleOverProof e:ListPb){
					
					switch (ProClassifi.productType(e.getName())) {
					//小麦
					case 1:
					{
						//小麦类
						if(proClassGrade[0][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>wheatExtre[2][0]){wheatExtre[2][0]=temp;}
							if(temp<wheatExtre[2][1]){wheatExtre[2][1]=temp;}
							wheatExtre[2][2]+=temp;
							count[0][2]++;
						}
					}
					break;
					//水稻
					case 2:
					{
						//水稻类
						if(proClassGrade[1][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>RiceExtre[2][0]){RiceExtre[2][0]=temp;}
							if(temp<RiceExtre[2][1]){RiceExtre[2][1]=temp;}
							RiceExtre[2][2]+=temp;
							count[1][2]++;
						}
					}
					break;
					//玉米
					case 3:
					{
						//玉米类
						if(proClassGrade[2][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>cornExtre[2][0]){cornExtre[2][0]=temp;}
							if(temp<cornExtre[2][1]){cornExtre[2][1]=temp;}
							cornExtre[2][2]+=temp;
							count[2][2]++;
						}
					}
					break;
					//蔬菜
					case 4:
					{
						//蔬菜类
						if(proClassGrade[3][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>vegetablesExtre[2][0]){vegetablesExtre[2][0]=temp;}
							if(temp<vegetablesExtre[2][1]){vegetablesExtre[2][1]=temp;}
							vegetablesExtre[2][2]+=temp;
							count[3][2]++;
						}
					}
					break;
					//其他类
					case 5:
					{
						//蔬菜类
						if(proClassGrade[4][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>otherExtre[2][0]){otherExtre[2][0]=temp;}
							if(temp<otherExtre[2][1]){otherExtre[2][1]=temp;}
							otherExtre[2][2]+=temp;
							count[4][2]++;
						}
					}
					break;
					
					default:
						break;
					}
				}
				//遍历Cd重金属
				for(EleOverProof e:ListCd){
					
					switch (ProClassifi.productType(e.getName())) {
					//小麦
					case 1:
					{
						//小麦类
						if(proClassGrade[0][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>wheatExtre[3][0]){wheatExtre[3][0]=temp;}
							if(temp<wheatExtre[3][1]){wheatExtre[3][1]=temp;}
							wheatExtre[3][2]+=temp;
							count[0][3]++;
						}
					}
					break;
					//水稻
					case 2:
					{
						//水稻类
						if(proClassGrade[1][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>RiceExtre[3][0]){RiceExtre[3][0]=temp;}
							if(temp<RiceExtre[3][1]){RiceExtre[3][1]=temp;}
							RiceExtre[3][2]+=temp;
							count[1][3]++;
						}
					}
					break;
					//玉米
					case 3:
					{
						//玉米类
						if(proClassGrade[2][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>cornExtre[3][0]){cornExtre[3][0]=temp;}
							if(temp<cornExtre[3][1]){cornExtre[3][1]=temp;}
							cornExtre[3][2]+=temp;
							count[2][3]++;
						}
					}
					break;
					//蔬菜
					case 4:
					{
						//蔬菜类
						if(proClassGrade[3][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>vegetablesExtre[3][0]){vegetablesExtre[3][0]=temp;}
							if(temp<vegetablesExtre[3][1]){vegetablesExtre[3][1]=temp;}
							vegetablesExtre[3][2]+=temp;
							count[3][3]++;
						}
					}
					break;
					//其他类
					case 5:
					{
						//蔬菜类
						if(proClassGrade[4][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>otherExtre[3][0]){otherExtre[3][0]=temp;}
							if(temp<otherExtre[3][1]){otherExtre[3][1]=temp;}
							otherExtre[3][2]+=temp;
							count[4][3]++;
						}
					}
					break;
					
					default:
						break;
					}
				}
		
				//遍历Cr重金属
				for(EleOverProof e:ListCr){
					
					switch (ProClassifi.productType(e.getName())) {
					//小麦
					case 1:
					{
						//小麦类
						if(proClassGrade[0][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>wheatExtre[4][0]){wheatExtre[4][0]=temp;}
							if(temp<wheatExtre[4][1]){wheatExtre[4][1]=temp;}
							wheatExtre[4][2]+=temp;
							count[0][4]++;
						}
					}
					break;
					//水稻
					case 2:
					{
						//水稻类
						if(proClassGrade[1][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>RiceExtre[4][0]){RiceExtre[4][0]=temp;}
							if(temp<RiceExtre[4][1]){RiceExtre[4][1]=temp;}
							RiceExtre[4][2]+=temp;
							count[1][4]++;
						}
					}
					break;
					//玉米
					case 3:
					{
						//玉米类
						if(proClassGrade[2][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>cornExtre[4][0]){cornExtre[4][0]=temp;}
							if(temp<cornExtre[4][1]){cornExtre[4][1]=temp;}
							cornExtre[4][2]+=temp;
							count[2][4]++;
						}
					}
					break;
					//蔬菜
					case 4:
					{
						//蔬菜类
						if(proClassGrade[3][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>vegetablesExtre[4][0]){vegetablesExtre[4][0]=temp;}
							if(temp<vegetablesExtre[4][1]){vegetablesExtre[4][1]=temp;}
							vegetablesExtre[4][2]+=temp;
							count[3][4]++;
						}
					}
					break;
					//其他类
					case 5:
					{
						//蔬菜类
						if(proClassGrade[4][2].contains(e.getSectionID())){
							double temp=e.getElecontent();
							if(temp>otherExtre[4][0]){otherExtre[4][0]=temp;}
							if(temp<otherExtre[4][1]){otherExtre[4][1]=temp;}
							otherExtre[4][2]+=temp;
							count[4][4]++;
						}
					}
					break;
					
					default:
						break;
					}
				}
		
		/**将统计好的极值写入全局变量
		 * */
		for(int i=0;i<5;i++){
			wheatExtre[i][2]=count[0][i]==0 ? 0:wheatExtre[i][2]/count[0][i];
			RiceExtre[i][2]=count[1][i]==0 ? 0:RiceExtre[i][2]/count[1][i];
			cornExtre[i][2]=count[2][i]==0 ? 0:cornExtre[i][2]/count[2][i];
			vegetablesExtre[i][2]=count[3][i]==0 ? 0:vegetablesExtre[i][2]/count[3][i];
			otherExtre[i][2]=count[4][i]==0 ? 0:otherExtre[i][2]/count[4][i];
		}
		for(int i=0;i<5;i++){
			for(int j=0;j<3;j++){
				proExtreThGrade[0][i][j]=wheatExtre[i][j];
				proExtreThGrade[1][i][j]=RiceExtre[i][j];
				proExtreThGrade[2][i][j]=cornExtre[i][j];
				proExtreThGrade[3][i][j]=vegetablesExtre[i][j];
				proExtreThGrade[4][i][j]=otherExtre[i][j];
			}
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		
}
