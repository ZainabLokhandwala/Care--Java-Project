

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

 import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import zainab.DB;
 /**
 * Servlet to handle File upload request from Client
 * @author Javin Paul
 */
 public class FileUploadHandler extends HttpServlet {
   private final String UPLOAD_DIRECTORY = "/Users/Zainab/Desktop/CARE_zainab/ZainabCARE/web/res/images/userphotos";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(
                                         new DiskFileItemFactory()).parseRequest(request);
              
                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        String name = new File(item.getName()).getName();
                        item.write( new File(UPLOAD_DIRECTORY + File.separator + name));
                        //delete old photo
                        try{
                            String u_id = request.getSession().getAttribute("u_id").toString();
                            String q = "select img_url from users where img_url like '%.%' and u_id = " + u_id;
                            ResultSet rs=DB.getC().query(q);
                            if(rs.next()){
                                File deleteFile = new File(UPLOAD_DIRECTORY + rs.getString("u_photo")) ;
                                if( deleteFile.exists() ){
                                    deleteFile.delete() ;
                                }
                            }
                        }catch(Exception ex){

                        }
                        //update database
                        try{
                            String u_id = request.getSession().getAttribute("u_id").toString();
                            String q = "update users set img_url='" + name + "' where u_id = " + u_id;
                            DB.getC().nonquery(q);
                        }catch(Exception ex){

                        }
                    }
                }
           
               //File uploaded successfully
               request.setAttribute("message", "Image Uploaded Successfully");

            } catch (Exception ex) {
               request.setAttribute("message", "Image Upload Failed due to " + ex);
            }          
         
        }else{
            request.setAttribute("message", "Sorry this Servlet only handles file upload request");
        }
    
            //request.getRequestDispatcher("/profile.jsp").forward(request, response);
            response.sendRedirect("upload.jsp");
    }
  
}
