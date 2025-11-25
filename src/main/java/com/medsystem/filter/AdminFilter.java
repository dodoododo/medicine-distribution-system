package com.medsystem.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.medsystem.model.bean.User;

@WebFilter(urlPatterns = "/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null && user.isAdmin()) {
                chain.doFilter(req, res);
                return;
            }
        }

        // Nếu không phải admin, redirect về login
        response.sendRedirect(request.getContextPath() + "/view/login.jsp");
    }
}
