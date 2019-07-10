package com.secrbac.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.secrbac.dao.AuthDAO;
import com.secrbac.dao.DataDAO;
import com.secrbac.dao.UserDAO;
import com.secrbac.daoimpl.AuthDAOImpl;
import com.secrbac.daoimpl.DataDAOImpl;
import com.secrbac.daoimpl.UserDAOImpl;
import com.secrbac.pojo.User;

public class DataServlet extends HttpServlet {

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
			DataDAO dao = new DataDAOImpl();
			AuthDAO authDao = new AuthDAOImpl();
			UserDAO userDao = new UserDAOImpl();
			User user = (User) req.getSession().getAttribute("user");
			String type = req.getParameter("type");
			if (type.equals("write")) {
				String desc = req.getParameter("desc");
				String[] key_arr = req.getParameterValues("key");
				String[] value_arr = req.getParameterValues("value");
				dao.write_data(user.getEmail(), desc, key_arr, value_arr);
				resp.sendRedirect("write_data.jsp?msg=Data Written Successfully");
			} else if (type.equals("getmydata")) {
				req.setAttribute("data", dao.getData(user.getEmail()));
				req.getRequestDispatcher("mydata.jsp").forward(req, resp);
			} else if (type.equals("delete")) {
				String data_id = req.getParameter("data_id");
				dao.delete_data(data_id);
				resp.sendRedirect("data?type=getmydata");
			} else if (type.equals("update_get")) {
				req.setAttribute("data", dao.getDataByID(req.getParameter("data_id"), user.getEmail()));
				req.getRequestDispatcher("mydata_update.jsp").forward(req, resp);
			} else if (type.equals("update")) {
				String desc = req.getParameter("desc");
				String[] key_arr = req.getParameterValues("key");
				String[] value_arr = req.getParameterValues("value");
				String data_id = req.getParameter("data_id");
				dao.update_data(data_id, user.getEmail(), desc, key_arr, value_arr);
				resp.sendRedirect("data?type=getmydata");
			} else if (type.equals("authrule_get")) {
				String data_id = req.getParameter("data_id");
				req.setAttribute("data_id", data_id);
				req.setAttribute("desc", req.getParameter("desc"));
				req.setAttribute("rules", dao.getAuthRule(data_id));
				req.setAttribute("all_auth_rules", authDao.getAll(user.getEmail()));
				req.getRequestDispatcher("mydata_auth_rules.jsp").forward(req, resp);
			} else if (type.equals("authrule_apply")) {
				String data_id = req.getParameter("data_id");
				String rule_id = req.getParameter("rule_id");
				String desc = req.getParameter("desc");
				dao.applyAuthRule(data_id, rule_id);
				resp.sendRedirect("data?type=authrule_get&data_id=" + data_id + "&desc=" + desc);
			} else if (type.equals("mapusers_get")) {
				String data_id = req.getParameter("data_id");
				String desc = req.getParameter("desc");
				List<String> availableusers = userDao.getAllRegisteredUsers();
				Map<String, String> mappedusers = dao.getMappedUsers(data_id);
				availableusers.removeAll(mappedusers.keySet());
				availableusers.remove(user.getEmail());
				req.setAttribute("rolenames", authDao.getRoleNames(dao.getRuleID(data_id)));
				req.setAttribute("availableusers", availableusers);
				req.setAttribute("users", mappedusers);
				req.setAttribute("data_id", data_id);
				req.setAttribute("desc", desc);
				req.getRequestDispatcher("mydata_users.jsp").forward(req, resp);
			} else if (type.equals("mapuser")) {
				String data_id = req.getParameter("data_id");
				String desc = req.getParameter("desc");
				String email = req.getParameter("email");
				String role_name = req.getParameter("role");
				dao.mapUser(data_id, email, role_name);
				resp.sendRedirect("data?type=mapusers_get&data_id=" + data_id + "&desc=" + desc);
			} else if (type.equals("mapusers_remove")) {
				String data_id = req.getParameter("data_id");
				String desc = req.getParameter("desc");
				String email = req.getParameter("email");
				dao.removeMappedUser(email, data_id);
				resp.sendRedirect("data?type=mapusers_get&data_id=" + data_id + "&desc=" + desc);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("error.jsp");
		}
	}

}
