package com.alibaba.druid.support.http;

import com.alibaba.druid.support.http.util.IPAddress;
import com.alibaba.druid.support.http.util.IPRange;
import com.alibaba.druid.support.logging.Log;
import com.alibaba.druid.support.logging.LogFactory;
import com.alibaba.druid.util.StringUtils;
import com.alibaba.druid.util.Utils;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public abstract class ResourceServlet extends HttpServlet
{
private static final long serialVersionUID = 3262449450456573520L;
private static final Log LOG = LogFactory.getLog(ResourceServlet.class);
  public static final String SESSION_USER_KEY = "druid-user";
  public static final String PARAM_NAME_USERNAME = "loginUsername";
  public static final String PARAM_NAME_PASSWORD = "loginPassword";
  public static final String PARAM_NAME_ALLOW = "allow";
  public static final String PARAM_NAME_DENY = "deny";
  public static final String PARAM_REMOTE_ADDR = "remoteAddress";
  protected String username = null;
  protected String password = null;

  protected List<IPRange> allowList = new ArrayList<IPRange>();
  protected List<IPRange> denyList = new ArrayList<IPRange>();
  protected final String resourcePath;
  protected String remoteAddressHeader = null;

  public ResourceServlet(String resourcePath) {
    this.resourcePath = resourcePath;
  }

  public void init() throws ServletException {
    initAuthEnv();
  }

  private void initAuthEnv() {
    String paramUserName = getInitParameter("loginUsername");
    if (!StringUtils.isEmpty(paramUserName)) {
      this.username = paramUserName;
    }

    String paramPassword = getInitParameter("loginPassword");
    if (!StringUtils.isEmpty(paramPassword)) {
      this.password = paramPassword;
    }

    String paramRemoteAddressHeader = getInitParameter("remoteAddress");
    if (!StringUtils.isEmpty(paramRemoteAddressHeader)) {
      this.remoteAddressHeader = paramRemoteAddressHeader;
    }
    try
    {
      String param = getInitParameter("allow");
      if ((param != null) && (param.trim().length() != 0)) {
        param = param.trim();
        String[] items = param.split(",");

        for (String item : items)
          if ((item != null) && (item.length() != 0))
          {
            IPRange ipRange = new IPRange(item);
            this.allowList.add(ipRange);
          }
      }
    } catch (Exception e) {
      String msg = "initParameter config error, allow : " + getInitParameter("allow");
      LOG.error(msg, e);
    }
    try
    {
      String param = getInitParameter("deny");
      if ((param != null) && (param.trim().length() != 0)) {
        param = param.trim();
        String[] items = param.split(",");

        for (String item : items)
          if ((item != null) && (item.length() != 0))
          {
            IPRange ipRange = new IPRange(item);
            this.denyList.add(ipRange);
          }
      }
    } catch (Exception e) {
      String msg = "initParameter config error, deny : " + getInitParameter("deny");
      LOG.error(msg, e);
    }
  }

  public boolean isPermittedRequest(String remoteAddress) {
    boolean ipV6 = (remoteAddress != null) && (remoteAddress.indexOf(':') != -1);
    
    System.out.println("当前访问ip为: " + remoteAddress);
    
    if (ipV6) {
    	
      return ("0:0:0:0:0:0:0:1".equals(remoteAddress)) || ((this.denyList.size() == 0) && (this.allowList.size() == 0));
    }

    IPAddress ipAddress = new IPAddress(remoteAddress);
    
    for (IPRange range : this.denyList) {
      if (range.isIPAddressInRange(ipAddress)) {
        return false;
      }
    }

    if (this.allowList.size() > 0) {
      for (IPRange range : this.allowList) {
        if (range.isIPAddressInRange(ipAddress)) {
          return true;
        }
      }

      return false;
    }

    return true;
  }

  protected String getFilePath(String fileName) {
    return this.resourcePath + fileName;
  }

  protected void returnResourceFile(String fileName, String uri, HttpServletResponse response)
    throws ServletException, IOException
  {
    String filePath = getFilePath(fileName);
    if (fileName.endsWith(".jpg")) {
      byte[] bytes = Utils.readByteArrayFromResource(filePath);
      if (bytes != null) {
        response.getOutputStream().write(bytes);
      }

      return;
    }

    String text = Utils.readFromResource(filePath);
    if (text == null) {
      response.sendRedirect(uri + "/index.html");
      return;
    }
    if (fileName.endsWith(".css"))
      response.setContentType("text/css;charset=utf-8");
    else if (fileName.endsWith(".js")) {
      response.setContentType("text/javascript;charset=utf-8");
    }
    response.getWriter().write(text);
  }

  public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String contextPath = request.getContextPath();
    String servletPath = request.getServletPath();
    String requestURI = request.getRequestURI();

    response.setCharacterEncoding("utf-8");

    if (contextPath == null) {
      contextPath = "";
    }
    String uri = contextPath + servletPath;
    String path = requestURI.substring(contextPath.length() + servletPath.length());

    if (!isPermittedRequest(request)) {
      path = "/nopermit.html";
      returnResourceFile(path, uri, response);
      return;
    }

    if ("/submitLogin".equals(path)) {
      String usernameParam = request.getParameter("loginUsername");
      String passwordParam = request.getParameter("loginPassword");
      if ((this.username.equals(usernameParam)) && (this.password.equals(passwordParam))) {
        request.getSession().setAttribute("druid-user", this.username);
        response.getWriter().print("success");
      } else {
        response.getWriter().print("error");
      }
      return;
    }

    if ((isRequireAuth()) && (!ContainsUser(request)) && (!"/login.html".equals(path)) && (!path.startsWith("/css")) && (!path.startsWith("/js")) && (!path.startsWith("/img")))
    {
      if ((contextPath.equals("")) || (contextPath.equals("/"))) {
        response.sendRedirect("/druid/login.html");
      }
      else if ("".equals(path))
        response.sendRedirect("druid/login.html");
      else {
        response.sendRedirect("login.html");
      }

      return;
    }

    if ("".equals(path)) {
      if ((contextPath.equals("")) || (contextPath.equals("/")))
        response.sendRedirect("/druid/index.html");
      else {
        response.sendRedirect("druid/index.html");
      }
      return;
    }

    if ("/".equals(path)) {
      response.sendRedirect("index.html");
      return;
    }

    if (path.contains(".json")) {
      String fullUrl = path;
      if ((request.getQueryString() != null) && (request.getQueryString().length() > 0)) {
        fullUrl = fullUrl + "?" + request.getQueryString();
      }
      response.getWriter().print(process(fullUrl));
      return;
    }

    returnResourceFile(path, uri, response);
  }

  public boolean ContainsUser(HttpServletRequest request) {
    HttpSession session = request.getSession(false);
    return (session != null) && (session.getAttribute("druid-user") != null);
  }

  public boolean isRequireAuth() {
    return this.username != null;
  }

  public boolean isPermittedRequest(HttpServletRequest request) {
    String remoteAddress = getRemoteAddress(request);
    return isPermittedRequest(remoteAddress);
  }

  protected String getRemoteAddress(HttpServletRequest request) {
    String remoteAddress = null;

    if (this.remoteAddressHeader != null) {
      remoteAddress = request.getHeader(this.remoteAddressHeader);
    }

    if (remoteAddress == null) {
      remoteAddress = request.getRemoteAddr();
    }

    return remoteAddress;
  }

  protected abstract String process(String paramString);
}