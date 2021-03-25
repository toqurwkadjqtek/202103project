package org.project.volleyball.dto;

public class TeamDTO {
	private String tcode;
	private String tname;
	private String mlogoname;
	private String slogoname;
	
	public TeamDTO() {}
	public TeamDTO(String tcode, String tname, String mlogoname, String slogoname) {
		this.tcode = tcode;
		this.tname = tname;
		this.mlogoname = mlogoname;
		this.slogoname = slogoname;
	}
	
	public String getTcode() {
		return tcode;
	}
	public void setTcode(String tcode) {
		this.tcode = tcode;
	}
	public String getTname() {
		return tname;
	}
	public void setTname(String tname) {
		this.tname = tname;
	}
	public String getMlogoname() {
		return mlogoname;
	}
	public void setMlogoname(String mlogoname) {
		this.mlogoname = mlogoname;
	}
	public String getSlogoname() {
		return slogoname;
	}
	public void setSlogoname(String slogoname) {
		this.slogoname = slogoname;
	}
	
	@Override
	public String toString() {
		return "TeamDTO [tcode=" + tcode + ", tname=" + tname + ", mlogoname=" + mlogoname + ", slogoname=" + slogoname
				+ "]";
	}
	
}
