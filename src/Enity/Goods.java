package Enity;

public class Goods {
     
     public int getGdsid() {
		return gdsid;
	}
	public void setGdsid(int gdsid) {
		this.gdsid = gdsid;
	}
	public String getGdsname() {
		return gdsname;
	}
	public void setGdsname(String gdsname) {
		this.gdsname = gdsname;
	}
	public int getGdsprice() {
		return gdsprice;
	}
	public void setGdsprice(int gdsprice) {
		this.gdsprice = gdsprice;
	}
	public String getGdsimg() {
		return gdsimg;
	}
	public void setGdsimg(String gdsimg) {
		this.gdsimg = gdsimg;
	}
	public String getGdshost() {
		return gdshost;
	}
	public void setGdshost(String gdshost) {
		this.gdshost = gdshost;
	}
	public String getClsfcname() {
		return clsfcname;
	}
	public void setClsfcname(String clsfcname) {
		this.clsfcname = clsfcname;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getClsfcid() {
		return clsfcid;
	}
	public void setClsfcid(int clsfcid) {
		this.clsfcid = clsfcid;
	}
	public Goods(int gdsid,String gdsname,int gdsprice,String gdsimg,String gdshost,String clsfcname,boolean state){
		this.gdsid=gdsid;
		this.gdsname=gdsname;
		this.gdsprice=gdsprice;
		this.gdsimg=gdsimg;
		this.gdshost=gdshost;
		this.clsfcname=clsfcname;
		if(state==true){
			this.state="Î´Âô³ö";
		}else{
			this.state="ÒÑÂô³ö";
		}
	}
	public Goods(int gdsid,String gdsname,int gdsprice,String gdsimg,String gdshost){
		this.gdsid=gdsid;
		this.gdsname=gdsname;
		this.gdsprice=gdsprice;
		this.gdsimg=gdsimg;
		this.gdshost=gdshost;
	}
	
	private int gdsid;
	private String gdsname;
    private int gdsprice;
    private String gdsimg;
    private String gdshost;
    private String clsfcname;
    private int clsfcid;
	private String state;
	
     
}
