package com.secrbac.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.secrbac.dao.AuthDAO;
import com.secrbac.daoimpl.AuthDAOImpl;
import com.secrbac.pojo.AuthBean;
import com.secrbac.pojo.User;
import com.secrbac.util.AppUtil;

public class AuthServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			String type = req.getParameter("type");
			AuthDAO dao = new AuthDAOImpl();
			User user = (User) req.getSession().getAttribute("user");
			String email = user.getEmail();
			if (type.equals("get")) {
				req.setAttribute("auths", dao.getAll(email));
				req.getRequestDispatcher("auth_rules_read.jsp").forward(req, resp);
			} else if (type.equals("add_rule")) {
				String rolenames[] = req.getParameterValues("rolename");
				String access[] = req.getParameterValues("access");
				String rule_id = AppUtil.generateRuleID();
				for (int i = 0; i < rolenames.length; i++) {
					AuthBean auth = new AuthBean();
					auth.setRule_id(rule_id);
					auth.setOwner_id(email);
					auth.setRole_name(rolenames[i]);
					if (access[i].equals("R")) {
						auth.setRead("Yes");
						auth.setDelete("No");
						auth.setUpdate("No");
					} else if (access[i].equals("RU")) {
						auth.setRead("Yes");
						auth.setDelete("No");
						auth.setUpdate("Yes");
					} else if (access[i].equals("RUD")) {
						auth.setRead("Yes");
						auth.setDelete("Yes");
						auth.setUpdate("Yes");
					} else {
						auth.setRead("No");
						auth.setDelete("No");
						auth.setUpdate("No");
					}
					dao.addRule(auth);
				}
				resp.sendRedirect("auth_rules.jsp?msg=Successfully Defined the New Set of Rules");
			} else if (type.equals("delete")) {
				String rule_id = req.getParameter("rule_id");
				dao.deleteRule(rule_id);
				resp.sendRedirect("auth?type=get");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("error.jsp");
		}
	}

}
