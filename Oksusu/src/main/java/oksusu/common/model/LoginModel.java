package oksusu.common.model;

public class LoginModel {
	private String userId;
	private String password;
	private String userName;
	private Boolean saveId;
	private String email;
	private String zip;
	private String address;
	private String phone;
	private String admin;
	private String cartCount;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Boolean getSaveId() {
		return saveId;
	}
	public void setSaveId(Boolean saveId) {
		this.saveId = saveId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAddress() {
		return address;
	}
	public void setAddess(String addr) {
		this.address = addr;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getCartCount() {
		return cartCount;
	}
	public void setCartCount(String cartCount) {
		this.cartCount = cartCount;
	}
}
