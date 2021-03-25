package org.project.volleyball.dto;

import org.springframework.web.multipart.MultipartFile;

public class MemberDTO {
	private String userid;
	private String nickname;
	private String passwd;
	private String zip;
	private String addr1;
	private String addr2;
	private MultipartFile imgfile;
	private String filename;
	private String admin;
	private String emailauth;
	private String simplejoin;
	private String regdate;
	
	public MemberDTO() {}
	public MemberDTO(String userid, String passwd, String nickname) {
		this.userid = userid;
		this.passwd = passwd;
		this.nickname = nickname;
	}
	public MemberDTO(String userid, String passwd, String nickname, String admin, String emailauth, String simplejoin) {
		this.userid = userid;
		this.passwd = passwd;
		this.nickname = nickname;
		this.admin = admin;
		this.emailauth = emailauth;
		this.simplejoin = simplejoin;
	}
	public MemberDTO(String userid, String passwd, String nickname, String zip, String addr1, String addr2,
			String filename, String admin, String emailauth, String simplejoin) {
		this.userid = userid;
		this.passwd = passwd;
		this.nickname = nickname;
		this.zip = zip;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.filename = filename;
		this.admin = admin;
		this.emailauth = emailauth;
		this.simplejoin = simplejoin;
	}
	public MemberDTO(String userid, String passwd, String nickname, String zip, String addr1, String addr2,
			String filename, String admin, String emailauth, String simplejoin, String regdate) {
		this.userid = userid;
		this.passwd = passwd;
		this.nickname = nickname;
		this.zip = zip;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.filename = filename;
		this.admin = admin;
		this.emailauth = emailauth;
		this.simplejoin = simplejoin;
		this.regdate = regdate;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public MultipartFile getImgfile() {
		return imgfile;
	}
	public void setImgfile(MultipartFile imgfile) {
		this.imgfile = imgfile;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getEmailauth() {
		return emailauth;
	}
	public void setEmailauth(String emailauth) {
		this.emailauth = emailauth;
	}
	public String getSimplejoin() {
		return simplejoin;
	}
	public void setSimplejoin(String simplejoin) {
		this.simplejoin = simplejoin;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "MemberDTO [userid=" + userid + ", passwd=" + passwd + ", nickname=" + nickname
				+ ", zip=" + zip + ", addr1=" + addr1 + ", addr2=" + addr2 + ", imgfile=" + imgfile + ", filename="
				+ filename + ", admin=" + admin + ", emailauth=" + emailauth + ", simplejoin=" + simplejoin
				+ ", regdate=" + regdate + "]";
	}
}
