package thuc.ute.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/image")
public class DownloadImageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String fileName = req.getParameter("fname");

        if (fileName == null || fileName.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        String uploadPath =
                getServletContext().getRealPath("/assets/uploads");

        File file = new File(
                uploadPath + File.separator + fileName
        );

        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mimeType =
                getServletContext().getMimeType(file.getName());

        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }

        resp.setContentType(mimeType);

        try (FileInputStream input =
                     new FileInputStream(file)) {

            input.transferTo(resp.getOutputStream());
        }
    }
}
