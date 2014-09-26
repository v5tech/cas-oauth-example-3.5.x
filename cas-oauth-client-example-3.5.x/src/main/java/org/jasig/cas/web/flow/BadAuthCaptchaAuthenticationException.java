package org.jasig.cas.web.flow;

import org.jasig.cas.ticket.TicketException;

/**
 * 验证码不正确
 * @author welcome
 *
 */
public class BadAuthCaptchaAuthenticationException extends TicketException {

	private static final long serialVersionUID = 4866453624183510847L;

	public BadAuthCaptchaAuthenticationException(String code) {
		super(code);
	}
	
	public BadAuthCaptchaAuthenticationException(String code,
			Throwable throwable) {
		super(code, throwable);
	}

}
