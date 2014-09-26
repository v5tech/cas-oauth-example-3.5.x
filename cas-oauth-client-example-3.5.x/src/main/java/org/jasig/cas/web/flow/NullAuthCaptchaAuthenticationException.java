package org.jasig.cas.web.flow;

import org.jasig.cas.ticket.TicketException;

/**
 * 验证码为空
 * @author welcome
 *
 */
public class NullAuthCaptchaAuthenticationException extends TicketException {

	private static final long serialVersionUID = 7459623503661898890L;

	public NullAuthCaptchaAuthenticationException(String code) {
		super(code);
	}
	
	public NullAuthCaptchaAuthenticationException(String code,
			Throwable throwable) {
		super(code, throwable);
	}

}
