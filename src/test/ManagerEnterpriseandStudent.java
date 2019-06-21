package myaction;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import myentity.Enterprise;
import myentity.Student;
import myutils.DatabaseConnect;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ManagerEnterpriseandStudent extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	Connection con;
	Statement sql;
	ResultSet rs;
	
	private String enterprise_search_content;
	private String student_search_content;
	private String checkenterpriseID;
	private String checkstudentID;
	private Enterprise enterprise=new Enterprise();
	private Student student=new Student();
	
	public String getCheckenterpriseID() {
		return checkenterpriseID;
	}

	public void setCheckenterpriseID(String checkenterpriseID) {
		this.checkenterpriseID = checkenterpriseID;
	}

	public String getCheckstudentID() {
		return checkstudentID;
	}

	public void setCheckstudentID(String checkstudentID) {
		this.checkstudentID = checkstudentID;
	}
	
	
	public String getEnterprise_search_content() {
		return enterprise_search_content;
	}

	public void setEnterprise_search_content(String enterprise_search_content) {
		this.enterprise_search_content = enterprise_search_content;
	}

	public String getStudent_search_content() {
		return student_search_content;
	}

	public void setStudent_search_content(String student_search_content) {
		this.student_search_content = student_search_content;
	}
	

	public Enterprise getEnterprise() {
		return enterprise;
	}

	public void setEnterprise(Enterprise enterprise) {
		this.enterprise = enterprise;
	}

	public Student getStudent() {
		return student;
	}

	public void setStudent(Student student) {
		this.student = student;
	}
//-------------------------------------------------------------------------------------------
	public void searchEnterprise() throws Exception{
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		Enterprise ETP=new Enterprise();
		JSONArray array=new JSONArray();
		JSONObject json=new JSONObject();
		String condition="select * from enterprise where name like '%"+enterprise_search_content+"%'";
		con=DatabaseConnect.connect();
		sql=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		rs=sql.executeQuery(condition);
		while(rs.next()){
			ETP.setEnterpriseID(rs.getString(1));
			ETP.setName(rs.getString(2));
			ETP.setAdress(rs.getString(3));
			array.add(ETP);
		}
		json.put("jsonarray", array);
   		out.print(json.toString());
		con.close();
	}
//-------------------------------------------------------------------------------------------	
	public String addEnterprise() throws Exception{
		String condition="insert into enterprise values("+enterprise.getEnterpriseID()+",'"+enterprise.getName()+"','"+enterprise.getAdress()+"')";
		con=DatabaseConnect.connect();
		sql=con.createStatement();
		sql.executeUpdate(condition);
		return "successupdateEnterprise";
	}
//-------------------------------------------------------------------------------------------	
    public String deleteEnterprise() throws Exception{
    	HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
    	String Confirmcondition="select * from projects where enterprise_num="+enterprise.getEnterpriseID();
    	String condition="delete from enterprise where ID="+enterprise.getEnterpriseID();
		con=DatabaseConnect.connect();
		sql=con.createStatement();
		rs=sql.executeQuery(Confirmcondition);
		if(rs.next()){
			out.print("<script language='JavaScript'>alert('企业存在合作项目，不可删除！！');window.location.href='managerManEnterprise.jsp';</script>");
		}
		else{
			sql.executeUpdate(condition);
	    	return "successupdateEnterprise";
		}
		return NONE;
	}
//-------------------------------------------------------------------------------------------
    public void checkEnterpriseID() throws Exception{
    	HttpServletResponse response=ServletActionContext.getResponse();
		PrintWriter pw = response.getWriter();
		String conditon="select * from enterprise where ID="+checkenterpriseID;
        Connection con = DatabaseConnect.connect();
        Statement sql=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs=sql.executeQuery(conditon);
        
        if (!rs.next())
            pw.print("legalName");
        else
        {
            pw.print(checkenterpriseID);
        }
        rs.close();
        con.close();
        sql.close();
    }
//-------------------------------------------------------------------------------------------
    public void searchStudent() throws Exception{
    	HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		Student STU=new Student();
		JSONArray array=new JSONArray();
		JSONObject json=new JSONObject();
		String condition="select * from student where name like '%"+student_search_content+"%'";
		String condition2="select * from student where number like '%"+student_search_content+"%'";
		con=DatabaseConnect.connect();
		sql=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
		rs=sql.executeQuery(condition);
		if(rs.next()){
			STU.setStudentNumber(rs.getString(1));
			STU.setStudentName(rs.getString(2));
			STU.setPassword(rs.getString(3));
			STU.setDepartment(rs.getString(4));
			STU.setMajor(rs.getString(5));
			array.add(STU);
		}else{
			rs=sql.executeQuery(condition2);
		}
		while(rs.next()){
			STU.setStudentNumber(rs.getString(1));
			STU.setStudentName(rs.getString(2));
			STU.setPassword(rs.getString(3));
			STU.setDepartment(rs.getString(4));
			STU.setMajor(rs.getString(5));
			array.add(STU);
		}
		json.put("jsonarray", array);
   		out.print(json.toString());
		con.close();
		
	}
//-------------------------------------------------------------------------------------------    
    public String addStudent() throws Exception{
    	String condition="insert into student values("+student.getStudentNumber()+",'"+student.getStudentName()+"',"+student.getPassword()+",'"+student.getDepartment()+"','"+student.getMajor()+"',null,null)";
		con=DatabaseConnect.connect();
		sql=con.createStatement();
		sql.executeUpdate(condition);
    	return "successupdateStudent";
	}
//-------------------------------------------------------------------------------------------
    public String deleteStudent() throws Exception{
    	HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
    	String Confirmcondition="select * from project_of_student where student_num="+student.getStudentNumber();
    	String condition="delete from student where number="+student.getStudentNumber();
		con=DatabaseConnect.connect();
		sql=con.createStatement();
		rs=sql.executeQuery(Confirmcondition);
		if(rs.next()){
			out.print("<script type='text/javascript'>alert('该生有参与项目，不可删除！！！');window.location.href= 'managerManStudent.jsp ';</script>");
		}else{
			sql.executeUpdate(condition);
	    	return "successupdateStudent";
		}
		return NONE;
    
    }
//------------------------------------------------------------------------------------------
    public void checkStudentID() throws Exception{
    	HttpServletResponse response=ServletActionContext.getResponse();
		PrintWriter pw = response.getWriter();
		String conditon="select * from student where number="+checkstudentID;
        Connection con = DatabaseConnect.connect();
        Statement sql=con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs=sql.executeQuery(conditon);
        
        if (!rs.next())
            pw.print("legalName");
        else
        {
            pw.print(checkstudentID);
        }
        rs.close();
        con.close();
        sql.close();
    }

}
