package com.techwin.security.domain;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class CustomUser extends User {

	private static final long serialVersionUID = -3833173852083168671L;
	
	/*
		1	EP_RETURNCODE	1:정상 , 0:error
		2	EP_LOGINID		로그인ID
		3	EP_COMPID		회사코드
		4	EP_SOCIALID		주민번호
		5	EP_DEPTID		부서코드
		6	EP_GRDID		직급코드
		7	EP_SECID		보안등급
		8	EP_GRPLST		가상그룹목록
		9	EP_PASSWORD		비밀번호 (사용하지않음)
		10	EP_MAILHOST		메일서버
		11	EP_SABUN		사번
		12	EP_LANG			사용언어 ex) K
		13	EP_LOCALE		언어정보 ex) ko_KR.EUC-KR 
		14	EP_USERDN		사용자DN
		15	EP_USERLEVEL	사용자등급
		16	EP_USERSTATUS	임직원상태
		17	EP_COMPTEL		회사전화번호
		18	EP_DM			DM서버정보
		19	EP_SORGID		총괄코드
		20	EP_BUSID		사업장코드
		21	EP_REGID		지역코드
		22	EP_MAIL			메일어드레스
		23	EP_USERID		Unique ID
		24	EP_PRIVLST		권한목록
		25	EP_STRHTTP		STRHTTP ????
		26	EP_DCOMP		원소속/파견소속 구분
		27	EP_USERLOCATION	사용자 지역
		28	EP_ICODE		인터넷 로그인 여부
		29	EP_ROLEID		역할 코드
		30	EP_SERVICECODE	서비스 코드
		31	EP_DCOMPCODE	원/파견소속 정보
		32	EP_TIMEZONE		TIMEZONE
		33	EP_EPFTP		Ftp 사용여부
		34	EP_LISTCOUNT	출력 목록수
		35	EP_WEBEDITOR	웹에디터 사용여부
		36	EP_RETURNURL	로그아웃URL
		37	EP_CHPWD		패스워드변경
		38	EP_SERVICELEVE	서비스별 권한
		39	EP_ATTACHSIZE	첨부파일크기
		40	EP_NATIVEYN		현채인여부
		41	EP_MAILRECPTCNT	메일수신처숫자
		42	EP_SUMMERTIMEYN	써머타임 여부
		43	EP_RELOGINYN	MIS 재로그인유무
		44	EP_OMINUSEYN	omin 사용여부
		45	EP_PASSWORDUSEYN	패스워드사용여부
		46	EP_LEVELAWARE	메신져 사용레벨
		47	EP_MESSAGECODE	값 없음
		48	EP_USERNAME		사용자명
		49	EP_COMPNAME		회사명
		50	EP_DEPTNAME		부서명
		51	EP_GRDNAME		직급명
		52	EP_SORGNAME		총괄명
		53	EP_BUSNAME		사업장명
		54	EP_REGNAME		지역명
		55	EP_USERNAME_EN	영문 사용자명
		56	EP_NICKNAME		닉네임
		57	EP_COMPNAME_EN	영문 회사명
		58	EP_DEPTNAME_EN	영문 부서명
		59	EP_GRDNAME_EN	영문 직급명
		60	EP_SORGNAME_EN	영문 총괄명
		61	EP_PREFERREDLANGUAGE	사용자기본언어
		62	EP_MCODE		메타프레임사용여부
		63	EP_SCREENSIZE	본문입력창크기
		64	EP_MOBILE		핸드폰 번호
		65	EP_BASE64YN		Base64인코딩여부
		66	EP_COMPRESSYN	압축여부
		67	EP_GLOBALPOSITION	거점분산정보
		68	EP_DOMAIN		접속도메인
		69	EP_LCDM			로컬저장함사용유무
		70	EP_LIGHTTRAYYN	LIGHT버젼 구분
		71	EP_LOGINIP		로그인 IP
		72	EP_LOGINTIMEFORMIS	로그인시간(GMT)
	 */
	
	private String returnCode;	//EP_RETURNCODE
	private String loginTimeFormIs;	//EP_LOGINTIMEFORMIS
	private String email;	//EP_MAIL
	private String userName;	//EP_USERNAME
	private String deptName;	//EP_DEPTNAME
	private String preferences;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities, String userName, String deptName, String preferences) {
		super(username, password, true, true, true, true, authorities);

		this.userName = userName;
		this.deptName = deptName;
		this.email = username;
		this.preferences = preferences;
	}

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities, String returnCode, String loginTimeFormIs, String email, 
			String userName, String deptName, String preferences) {
		super(username, password, true, true, true, true, authorities);
		
		this.returnCode = returnCode;
		this.loginTimeFormIs = loginTimeFormIs;
		this.email = email;
		this.userName = userName;
		this.deptName = deptName;
		this.preferences = preferences;
	}
	
	public CustomUser(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities, String returnCode, String loginTimeFormIs, String email, String userName, String deptName, String preferences) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		
		this.returnCode = returnCode;
		this.loginTimeFormIs = loginTimeFormIs;
		this.email = email;
		this.userName = userName;
		this.deptName = deptName;
		this.preferences = preferences;
	}

	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public String getLoginTimeFormIs() {
		return loginTimeFormIs;
	}

	public void setLoginTimeFormIs(String loginTimeFormIs) {
		this.loginTimeFormIs = loginTimeFormIs;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getPreferences() {
		return preferences;
	}

	public void setPreferences(String preferences) {
		this.preferences = preferences;
	}
}
