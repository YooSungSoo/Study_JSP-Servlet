package dao;

public class CourseDAO {

	private int majorSeq;
	private int studentSeq;
	private int professorSeq;
	private int subjectSeq;
	private int courseCredit;
	private int courseCapacity;
	private int year;
	private int semester;
	
	public int getMajorSeq() {
		return majorSeq;
	}
	public void setMajorSeq(int majorSeq) {
		this.majorSeq = majorSeq;
	}
	public int getStudentSeq() {
		return studentSeq;
	}
	public void setStudentSeq(int studentSeq) {
		this.studentSeq = studentSeq;
	}
	public int getProfessorSeq() {
		return professorSeq;
	}
	public void setProfessorSeq(int professorSeq) {
		this.professorSeq = professorSeq;
	}
	public int getSubjectSeq() {
		return subjectSeq;
	}
	public void setSubjectSeq(int subjectSeq) {
		this.subjectSeq = subjectSeq;
	}
	public int getCourseCredit() {
		return courseCredit;
	}
	public void setCourseCredit(int courseCredit) {
		this.courseCredit = courseCredit;
	}
	public int getCourseCapacity() {
		return courseCapacity;
	}
	public void setCourseCapacity(int courseCapacity) {
		this.courseCapacity = courseCapacity;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getSemester() {
		return semester;
	}
	public void setSemester(int semester) {
		this.semester = semester;
	}
	
}