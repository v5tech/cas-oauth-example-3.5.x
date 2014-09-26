package org.jasig.cas.web.flow;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.jasig.cas.ticket.TicketException;
import org.jasig.cas.web.support.WebUtils;
import org.springframework.binding.message.MessageBuilder;
import org.springframework.binding.message.MessageContext;
import org.springframework.webflow.action.AbstractAction;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;

public class CaptchaValidateAction extends AbstractAction {
     
	private static final String CAPTCHA_REQUIRED_MSG = "required.captcha";//验证码必填
    private static final String CAPTCHA_ERROR_MSG = "error.captcha";//验证码不正确
    
    @Override
    protected Event doExecute(RequestContext context) throws Exception {
    	
    	final HttpServletRequest request = WebUtils.getHttpServletRequest(context);  
        
    	HttpSession session = request.getSession();  
        String authcode = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
        session.removeAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
        
        String submitAuthcode =request.getParameter("captcha");  
        String showCaptchaField = request.getParameter("showCaptcha");
        
        if(StringUtils.isNotBlank(showCaptchaField)){
        	if(!org.springframework.util.StringUtils.hasText(submitAuthcode) || !org.springframework.util.StringUtils.hasText(authcode)){  
                populateErrorsInstance(new NullAuthCaptchaAuthenticationException(CAPTCHA_REQUIRED_MSG),context.getMessageContext());  
                return error();    
            }  
            if(submitAuthcode.equals(authcode)){    
                return success();  
            }  
            populateErrorsInstance(new BadAuthCaptchaAuthenticationException(CAPTCHA_ERROR_MSG),context.getMessageContext());  
        }
        return error();
        
    }
    
    
    private void populateErrorsInstance(final TicketException e, final MessageContext messageContext) {

        try {
            messageContext.addMessage(new MessageBuilder().error().code(e.getCode()).defaultText(e.getCode()).build());
        } catch (final Exception fe) {
            logger.error(fe.getMessage(), fe);
        }
    }
     
    
}
