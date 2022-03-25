package com.ffunding.web.auth;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Repository;

import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.api.DefaultApi20;

@Repository
public class SnsValue implements SnsUrls {
	private String service;
	private String clientId;
	private String clientSecret;
	private String redirectUrl;
	private DefaultApi20 api20Instance;
	private String profileUrl;
	
	private boolean isNaver;
	private boolean isGoogle;
	private boolean isKakao;
	
	public SnsValue() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SnsValue(String service, String clientId, String clienSecret, String redirectUrl) {
		this.service = service;
		this.clientId = clientId;
		this.clientSecret = clienSecret;
		this.redirectUrl = redirectUrl;
		
		this.isNaver = StringUtils.equalsIgnoreCase("naver", this.service);
		this.isGoogle = StringUtils.equalsIgnoreCase("google", this.service);
		this.isKakao = StringUtils.equalsIgnoreCase("kakao", this.service);
		
		if (isNaver) {
			// service가 naver일 때
			this.api20Instance = NaverAPI20.instance();
			this.profileUrl = NAVER_PROFILE_URL;
		} else if(isGoogle) {
			this.api20Instance = GoogleApi20.instance();
			this.profileUrl = GOOGLE_PROFILE_URL;
		} else {
			this.api20Instance = KakaoAPI20.instance();
			this.profileUrl = KAKAO_PROFILE_URL;
		}
		
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientSecret() {
		return clientSecret;
	}

	public void setClientSecret(String clientSecret) {
		this.clientSecret = clientSecret;
	}

	public String getRedirectUrl() {
		return redirectUrl;
	}

	public void setRedirectUrl(String redirectUrl) {
		this.redirectUrl = redirectUrl;
	}

	public DefaultApi20 getApi20Instance() {
		return api20Instance;
	}

	public void setApi20Instance(DefaultApi20 api20Instance) {
		this.api20Instance = api20Instance;
	}

	public String getProfileUrl() {
		return profileUrl;
	}

	public void setProfileUrl(String profileUrl) {
		this.profileUrl = profileUrl;
	}

	public boolean isNaver() {
		return isNaver;
	}

	public void setNaver(boolean isNaver) {
		this.isNaver = isNaver;
	}

	public boolean isGoogle() {
		return isGoogle;
	}

	public void setGoogle(boolean isGoogle) {
		this.isGoogle = isGoogle;
	}

	public boolean isKakao() {
		return isKakao;
	}

	public void setKakao(boolean isKakao) {
		this.isKakao = isKakao;
	}
	
}
