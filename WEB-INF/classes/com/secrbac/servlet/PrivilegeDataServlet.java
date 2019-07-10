package com.secrbac.servlet;

import java.io.IOException;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.secrbac.dao.DataDAO;
import com.secrbac.dao.PrivilegeDataDAO;
import com.secrbac.daoimpl.DataDAOImpl;
import com.secrbac.daoimpl.PrivilegeDataDAOImpl;
import com.secrbac.mail.SendMail;
import com.secrbac.pojo.User;
import com.secrbac.reencryption.Decrypt;
import com.secrbac.reencryption.Encrypt;
import com.secrbac.reencryption.PKG;

public class PrivilegeDataServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String type = req.getParameter("type");
			User user = (User) req.getSession().getAttribute("user");
			PrivilegeDataDAO dao = new PrivilegeDataDAOImpl();
			DataDAO dataDAO = new DataDAOImpl();
			if (type.equals("get")) {
				req.setAttribute("data", dao.getPrivilegeData(user.getEmail()));
				req.getRequestDispatcher("privilege_data.jsp").forward(req, resp);
			} else if (type.equals("access")) {
				String data_id = req.getParameter("data_id");
				String desc = req.getParameter("desc");
				int access = dao.checkPrivilege(data_id, user.getEmail());
				req.setAttribute("access", access);
				req.setAttribute("data_id", data_id);
				req.setAttribute("desc", desc);
				req.setAttribute("details", dao.getDataDetails(data_id));
				req.getRequestDispatcher("privilege_data_access1.jsp").forward(req, resp);
			} else if (type.equals("access2")) {
				String id = req.getParameter("id");
				String data_id = req.getParameter("data_id");
				String desc = req.getParameter("desc");
				String access = req.getParameter("access");
				PKG pkg = new PKG();
				Map<String, String> keyvalue = dataDAO.getDetails(data_id);
				Map<String, String> keyvalue_enc = new HashMap<>();

				Iterator<String> it = keyvalue.keySet().iterator();
				while (it.hasNext()) {
					String key = it.next();
					String value = keyvalue.get(key);

					keyvalue_enc.put(Encrypt.encrypt(key, pkg.get_N(id), pkg.get_public_key(id)),
							Encrypt.encrypt(value, pkg.get_N(id), pkg.get_public_key(id)));
				}
				SendMail mail = new SendMail();
				List<String> to = new ArrayList<>();
				to.add(user.getEmail());
				mail.send(to, "Secret Key for Accessing the Privileged Data",
						"Dear " + user.getEmail()
								+ ", <br/><br/> Use the below key for accessing the privileged data<br/><br/>N = "
								+ pkg.get_N(id) + "<br/><br/><br/>Private key = " + pkg.get_private_key(id));
				req.setAttribute("keyvalue_enc", keyvalue_enc);
				req.setAttribute("data_id", data_id);
				req.setAttribute("access", access);
				req.setAttribute("desc", desc);
				req.getRequestDispatcher("privilege_data_access2.jsp").forward(req, resp);

			} else if (type.equals("access3")) {
				String n = req.getParameter("n");
				String secretkey = req.getParameter("secretkey");
				String data_id = req.getParameter("data_id");
				String desc = req.getParameter("desc");
				String access = req.getParameter("access");
				String key[] = req.getParameterValues("key");
				String val[] = req.getParameterValues("value");
				Map<String, String> keyvalue_map = new HashMap<>();
				for (int i = 0; i < key.length; i++) {
					keyvalue_map.put(Decrypt.decrypt(key[i], new BigInteger(n), new BigInteger(secretkey)),
							Decrypt.decrypt(val[i], new BigInteger(n), new BigInteger(secretkey)));
				}
				req.setAttribute("data_id", data_id);
				req.setAttribute("desc", desc);
				req.setAttribute("access", access);
				req.setAttribute("keyvalue_map", keyvalue_map);
				req.getRequestDispatcher("privilege_data_access3.jsp").forward(req, resp);
			} else if (type.equals("delete")) {
				String data_id = req.getParameter("data_id");
				dataDAO.delete_data(data_id);
				resp.sendRedirect("privilegeData?type=get");
			} else if (type.equals("update")) {
				String desc = req.getParameter("desc");
				String data_id = req.getParameter("data_id");
				String access = req.getParameter("access");
				String key[] = req.getParameterValues("key");
				String val[] = req.getParameterValues("value");
				String owner_id = dataDAO.getOwnerID(data_id);
				dataDAO.update_data(data_id, owner_id, desc, key, val);
				req.setAttribute("data_id", data_id);
				req.setAttribute("desc", desc);
				req.setAttribute("access", access);
				Map<String, String> keyvalue_map = dataDAO.getDetails(data_id);
				req.setAttribute("keyvalue_map", keyvalue_map);
				req.getRequestDispatcher("privilege_data_access3.jsp").forward(req, resp);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendRedirect("error.jsp");
		}
	}

}
