<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:directive.include file="includes/top.jsp" />

  <div class="box fl-panel" id="login">
			<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">
                  <form:errors path="*" id="msg" cssClass="errors" element="div" />
                <!-- <spring:message code="screen.welcome.welcome" /> -->
                    <h2><spring:message code="screen.welcome.instructions" /></h2>
                    <div class="row fl-controls-left">
                        <label for="username" class="fl-label"><spring:message code="screen.welcome.label.netid" /></label>
						<c:if test="${not empty sessionScope.openIdLocalId}">
						<strong>${sessionScope.openIdLocalId}</strong>
						<input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
						</c:if>

						<c:if test="${empty sessionScope.openIdLocalId}">
						<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
						<form:input cssClass="required" cssErrorClass="error" id="username" size="25" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" htmlEscape="true" />
						</c:if>
                    </div>
                    <div class="row fl-controls-left">
                        <label for="password" class="fl-label"><spring:message code="screen.welcome.label.password" /></label>
						<%--
						NOTE: Certain browsers will offer the option of caching passwords for a user.  There is a non-standard attribute,
						"autocomplete" that when set to "off" will tell certain browsers not to prompt to cache credentials.  For more
						information, see the following web page:
						http://www.geocities.com/technofundo/tech/web/ie_autocomplete.html
						--%>
						<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
						<form:password cssClass="required" cssErrorClass="error" id="password" size="25" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
                    </div>
                    
                    <!-- 验证码 -->
                    <c:if test="${not empty count && count >= 3}">
					<div class="row fl-controls-left">  
                      <label for="captcha" class="fl-label"><spring:message code="screen.welcome.label.captcha" /></label>  
                      <spring:message code="screen.welcome.label.captcha.accesskey" var="authcaptchaAccessKey" />  
                        <table>  
	                        <tr>  
	                        	<td>
	                        		<%--    
	                        		<form:input cssClass="required" cssErrorClass="error" id="captcha" size="10" tabindex="2" path="captcha"  accesskey="${authcaptchaAccessKey}" htmlEscape="true" autocomplete="off" />
	                        		--%>
	                        		<input name="captcha" type="text" id="captcha" size="10">  
	                        	</td>  
	                            <td align="left" valign="bottom" style="vertical-align: bottom;">  
	                          		<img alt="<spring:message code="required.captcha" />" onclick="this.src='captcha.jpg?'+Math.random()" width="93" height="30" src="captcha.jpg">  
	                    		</td>  
	                        </tr>  
                        </table>  
                        <input type="hidden" name="showCaptcha" value="true" />
                    </div>  
                    </c:if>
                    					                    
                    <!-- rememberMe -->
                    <div class="row check">
	                    <input type="checkbox" name="rememberMe" id="rememberMe" value="true" /> 
	                    <label for="rememberMe">自动登录</label>
                    </div>
                    
                    <div class="row check">
                        <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message code="screen.welcome.label.warn.accesskey" />" type="checkbox" />
                        <label for="warn"><spring:message code="screen.welcome.label.warn" /></label>
                    </div>
                    
                    <div class="row btn-row">
						<input type="hidden" name="lt" value="${loginTicket}" />
						<input type="hidden" name="execution" value="${flowExecutionKey}" />
						<input type="hidden" name="_eventId" value="submit" />
                        <input class="btn-submit" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="4" type="submit" />
                        <input class="btn-reset" name="reset" accesskey="c" value="<spring:message code="screen.welcome.button.clear" />" tabindex="5" type="reset" />
                    </div>
            </form:form>
          </div>
          <div id="sidebar">
			<div class="sidebar-content">
               <div id="list-languages" class="fl-panel">
	               <%final String queryString = request.getQueryString() == null ? "" : request.getQueryString().replaceAll("&locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]|^locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]", "");%>
					<c:set var='query' value='<%=queryString%>' />
	                   <c:set var="xquery" value="${fn:escapeXml(query)}" />
	                 <h3>语  言:</h3>
	                 <c:choose>
	                    <c:when test="${not empty requestScope['isMobile'] and not empty mobileCss}">
	                       <form method="get" action="login?${xquery}">
	                          <select name="locale">
	                              <option value="en">English</option>
	                              <option value="zh_CN">Chinese (Simplified)</option>
	                              <option value="zh_TW">Chinese (Traditional)</option>
	                          </select>
	                          <input type="submit" value="Switch">
	                       </form>
	                    </c:when>
	                    <c:otherwise>
	                       <c:set var="loginUrl" value="login?${xquery}${not empty xquery ? '&' : ''}locale=" />
						<ul>
							<li class="first"><a href="${loginUrl}en">English</a></li>
							<li><a href="${loginUrl}zh_CN">Chinese (Simplified)</a></li>
							<li><a href="${loginUrl}zh_TW">Chinese (Traditional)</a></li>
	                       </ul>
	                    </c:otherwise>
	                  </c:choose>
                </div>
			</div>
         </div>
<jsp:directive.include file="includes/bottom.jsp" />