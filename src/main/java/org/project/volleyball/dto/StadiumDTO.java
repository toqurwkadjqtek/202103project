package org.project.volleyball.dto;

public class StadiumDTO {
	private String scode;
	private String sname;
	private Double slat;
	private Double slong;
	
	public StadiumDTO() {}
	public StadiumDTO(String scode, String sname, Double slat, Double slong) {
		this.scode = scode;
		this.sname = sname;
		this.slat = slat;
		this.slong = slong;
	}
	
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public Double getSlat() {
		return slat;
	}
	public void setSlat(Double slat) {
		this.slat = slat;
	}
	public Double getSlong() {
		return slong;
	}
	public void setSlong(Double slong) {
		this.slong = slong;
	}
	
	@Override
	public String toString() {
		return "StadiumDTO [scode=" + scode + ", sname=" + sname + ", slat=" + slat + ", slong=" + slong + "]";
	}

}
