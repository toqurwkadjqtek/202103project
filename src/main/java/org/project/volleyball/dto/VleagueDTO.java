package org.project.volleyball.dto;

public class VleagueDTO {
	private String season;
	private int vnum;
	private String vdate;
	private String vhour;
	private String vmin;
	private String gubun;
	private String home;
	private String homename;
	private int homescore;
	private int awayscore;
	private String away;
	private String awayname;
	private String scode;
	private String broad;
	private String round;
	private String sort;
	
	public VleagueDTO() {}
	public VleagueDTO(String season, int vnum, String vdate, String vhour, String vmin, String gubun, String home,
			int homescore, int awayscore, String away, String scode, String broad, String round, String sort) {
		this.season = season;
		this.vnum = vnum;
		this.vdate = vdate;
		this.vhour = vhour;
		this.vmin = vmin;
		this.gubun = gubun;
		this.home = home;
		this.homescore = homescore;
		this.awayscore = awayscore;
		this.away = away;
		this.scode = scode;
		this.broad = broad;
		this.round = round;
		this.sort = sort;
	}

	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	public int getVnum() {
		return vnum;
	}
	public void setVnum(int vnum) {
		this.vnum = vnum;
	}
	public String getVdate() {
		return vdate;
	}
	public void setVdate(String vdate) {
		this.vdate = vdate;
	}
	public String getVhour() {
		return vhour;
	}
	public void setVhour(String vhour) {
		this.vhour = vhour;
	}
	public String getVmin() {
		return vmin;
	}
	public void setVmin(String vmin) {
		this.vmin = vmin;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getHome() {
		return home;
	}
	public void setHome(String home) {
		this.home = home;
	}
	public int getHomescore() {
		return homescore;
	}
	public void setHomescore(int homescore) {
		this.homescore = homescore;
	}
	public int getAwayscore() {
		return awayscore;
	}
	public void setAwayscore(int awayscore) {
		this.awayscore = awayscore;
	}
	public String getAway() {
		return away;
	}
	public void setAway(String away) {
		this.away = away;
	}
	public String getScode() {
		return scode;
	}
	public void setScode(String scode) {
		this.scode = scode;
	}
	public String getBroad() {
		return broad;
	}
	public void setBroad(String broad) {
		this.broad = broad;
	}
	public String getRound() {
		return round;
	}
	public void setRound(String round) {
		this.round = round;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getHomename() {
		return homename;
	}
	public void setHomename(String homename) {
		this.homename = homename;
	}
	public String getAwayname() {
		return awayname;
	}
	public void setAwayname(String awayname) {
		this.awayname = awayname;
	}
	@Override
	public String toString() {
		return "VleagueDTO [season=" + season + ", vnum=" + vnum + ", vdate=" + vdate + ", vhour=" + vhour + ", vmin="
				+ vmin + ", gubun=" + gubun + ", home=" + home + ", homename=" + homename + ", homescore=" + homescore
				+ ", awayscore=" + awayscore + ", away=" + away + ", awayname=" + awayname + ", scode=" + scode
				+ ", broad=" + broad + ", round=" + round + ", sort=" + sort + "]";
	}
	
}
