package org.jasig.cas.web.flow;

import org.springframework.webflow.action.AbstractAction;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;
 
public class CaptchaErrorCountAction extends AbstractAction {
    @Override
    protected Event doExecute(RequestContext context) throws Exception {
        int count;
        try {
            count = (Integer) context.getFlowScope().get("count");
        } catch (Exception e) {
            count = 0;
        }
        count++;
        context.getFlowScope().put("count", count);
        return success();
    }
}