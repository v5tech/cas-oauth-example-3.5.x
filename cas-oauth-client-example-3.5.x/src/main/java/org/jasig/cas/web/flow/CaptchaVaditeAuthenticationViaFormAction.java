package org.jasig.cas.web.flow;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jasig.cas.authentication.principal.Credentials;
import org.jasig.cas.authentication.principal.UsernamePasswordCaptchaCredentials;
import org.jasig.cas.ticket.TicketException;
import org.jasig.cas.web.flow.AuthenticationViaFormAction;
import org.jasig.cas.web.support.WebUtils;
import org.springframework.binding.message.MessageBuilder;
import org.springframework.binding.message.MessageContext;
import org.springframework.util.StringUtils;
import org.springframework.webflow.execution.RequestContext;
  
/**
 * 验证码校验
 * @author welcome
 *
 */
public class CaptchaVaditeAuthenticationViaFormAction extends AuthenticationViaFormAction{
    
    private static final String CAPTCHA_REQUIRED_MSG = "required.captcha";//验证码必填
    private static final String CAPTCHA_ERROR_MSG = "error.captcha";//验证码不正确
    
    
    public final String validatorCaptcha(final RequestContext context, final Credentials credentials, final MessageContext messageContext) throws Exception {
    	final HttpServletRequest request = WebUtils.getHttpServletRequest(context);  
        HttpSession session = request.getSession();  
        String authcode = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
        session.removeAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
        UsernamePasswordCaptchaCredentials upc = (UsernamePasswordCaptchaCredentials)credentials;  
        String submitAuthcode =upc.getCaptcha();  
        if(!StringUtils.hasText(submitAuthcode) || !StringUtils.hasText(authcode)){  
            populateErrorsInstance(new NullAuthCaptchaAuthenticationException(CAPTCHA_REQUIRED_MSG),messageContext);  
            return "error";    
        }  
        if(submitAuthcode.equals(authcode)){    
            return "success";  
        }  
        populateErrorsInstance(new BadAuthCaptchaAuthenticationException(CAPTCHA_ERROR_MSG),messageContext);  
        return "error";
    }
    
    
    private void populateErrorsInstance(final TicketException e, final MessageContext messageContext) {

        try {
            messageContext.addMessage(new MessageBuilder().error().code(e.getCode()).defaultText(e.getCode()).build());
        } catch (final Exception fe) {
            logger.error(fe.getMessage(), fe);
        }
    }
}
