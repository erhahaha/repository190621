package com.nankai.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


import com.nankai.service.UserService;
import com.nankai.service.Impl.Fileimportservice;



@Controller
@RequestMapping("/fileupload")
public class Fileimportcontroller {

	@Autowired
	private Fileimportservice fileimportservice;
	
	@RequestMapping("/import")
	public void impotr(HttpServletRequest request,HttpServletResponse response, Model model) throws Exception {
	     //int adminId = 1;
		 response.setContentType("text/html;charset=utf-8");
		 PrintWriter out=response.getWriter();
		try {
		     //获取上传的文件
		     MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) request;
		     MultipartFile file = multipart.getFile("upfile");
		     //String month = request.getParameter("month");
		     InputStream in = file.getInputStream();
		     //数据导入
		     //salaryService.importExcelInfo(in,file,month,adminId);
			 fileimportservice.importExcelInfo(in, file);
			 in.close();
			 out.print("<script language='JavaScript'>alert('文件上传成功！');window.location.href='"+request.getContextPath()+"/fileupload/enterinput';</script>");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.print("<script language='JavaScript'>alert('失败！失败！文件上传失败！');window.location.href='"+request.getContextPath()+"/fileupload/enterinput';</script>");
		}
	}
	
	@RequestMapping("/fileoutput")
	public void fileoutput(HttpServletRequest request,HttpServletResponse response, Model model) throws Exception {
		// 创建HSSFWorkbook对象(excel的文档对象)
				HSSFWorkbook wb = new HSSFWorkbook();
				// 建立新的sheet对象（excel的表单）
				HSSFSheet sheet = wb.createSheet("student");
				// 在sheet里创建第一行，参数为行索引(excel的行)，可以是0～65535之间的任何一个
				HSSFRow row1 = sheet.createRow(0);
				row1.createCell(0).setCellValue("地区");
				row1.createCell(1).setCellValue("土壤编号");
				row1.createCell(2).setCellValue("年份");
				row1.createCell(3).setCellValue("东经");
				row1.createCell(4).setCellValue("北纬");
				row1.createCell(5).setCellValue("乡镇");
				row1.createCell(6).setCellValue("土壤Cd镉(mg/kg)");
				row1.createCell(7).setCellValue("土壤Pb铅(mg/kg)");
				row1.createCell(8).setCellValue("土壤Cr铬(mg/kg)");
				row1.createCell(9).setCellValue("土壤As砷(mg/kg)");
				row1.createCell(10).setCellValue("土壤Hg汞(mg/kg)");
				row1.createCell(11).setCellValue("土壤Cu铜(mg/kg)");
				row1.createCell(12).setCellValue("土壤Zn锌(mg/kg)");
				row1.createCell(13).setCellValue("土壤Ni镍(mg/kg)");
				row1.createCell(14).setCellValue("pH");
				row1.createCell(15).setCellValue("阳离子交换量(cmol/kg)");
				row1.createCell(16).setCellValue("有机质");
				row1.createCell(17).setCellValue("编号");
				row1.createCell(18).setCellValue("作物名称");
				row1.createCell(19).setCellValue("农产品铜(mg/kg)");
				row1.createCell(20).setCellValue("农产品锌(mg/kg)");
				row1.createCell(21).setCellValue("农产品铅(mg/kg)");
				row1.createCell(22).setCellValue("农产品镉(mg/kg)");
				row1.createCell(23).setCellValue("农产品汞(mg/kg)");
				row1.createCell(24).setCellValue("农产品砷(mg/kg)");
				row1.createCell(25).setCellValue("农产品铬(mg/kg)");
				row1.createCell(26).setCellValue("农产品镍(mg/kg)");

				
				//将excel的数据写入文件
				ByteArrayOutputStream fos = null;
				byte[] retArr = null;
				try {
					fos = new ByteArrayOutputStream();
					wb.write(fos);
					retArr = fos.toByteArray();
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					try {
						fos.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				OutputStream os = response.getOutputStream();
				//PrintWriter out=response.getWriter();
				try {
					response.reset();
					response.setHeader("Content-Disposition", "attachment; filename=refer.xls");//要保存的文件名
					response.setContentType("application/octet-stream; charset=utf-8");
					os.write(retArr);
					os.flush();
					//out.print("<script language='JavaScript'>alert('文件下载成功！');window.location.href='"+request.getContextPath()+"/fileupload/enterinput';</script>");
				} finally {
					if (os != null) {
						os.close();
					}
				}
	}

	@RequestMapping("/enterinput")
	public String hrefpage() {
		return "input";
	}
}
