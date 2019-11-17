using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Signin : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["truck"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void signup_Click(object sender, EventArgs e)
    {
        try
        {
            System.IO.Stream fs = image.PostedFile.InputStream;
            System.IO.BinaryReader br = new System.IO.BinaryReader(fs);
            Byte[] bytes = br.ReadBytes((Int32)fs.Length);
            string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
            string regname = name.Text;
            string regcontact = contact.Text;
            string regemail = email.Text;
            string regaddress = address.InnerText;
            string regage = age.Text;
            string regcity = city.Text;
            string regpass = password.Text;
            string uid = "";
            SqlCommand cmd = new SqlCommand("select (coalesce(cast(Uid as int), 0) + 1) as Uid from [User] order by Uid desc", con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                uid = dr["Uid"].ToString();
            }
            else
            {
                uid = "101";
            }
            con.Close();
            cmd = new SqlCommand("select * from [User] where Email = '" + regemail + "'", con);
            con.Open();
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                con.Close();
                Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "error()", true);
            }
            else
            {
                con.Close();
                cmd = new SqlCommand("insert into [User] (Uid, Name, Image, Contact, Email, Address, City, Age, Password) Values (@uid, @name, @image, @contact, @email, @address, @city, @age, @pass)", con);
                con.Open();
                cmd.Parameters.AddWithValue("@uid", uid);
                cmd.Parameters.AddWithValue("@name", regname);
                cmd.Parameters.AddWithValue("@contact", regcontact);
                cmd.Parameters.AddWithValue("@email", regemail);
                cmd.Parameters.AddWithValue("@age", regage);
                cmd.Parameters.AddWithValue("@address", regaddress);
                cmd.Parameters.AddWithValue("@city", regcity);
                cmd.Parameters.AddWithValue("@pass", regpass);
                cmd.Parameters.AddWithValue("@image", base64String);
                int result = cmd.ExecuteNonQuery();
                if (result > 0)
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "success()", true);
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "swal('Some issues are here');", true);
                }
                con.Close();
            }
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void login_Click(object sender, EventArgs e)
    {
        try
        {
            string email = lemail.Text;
            string pass = lpass.Text;
            SqlCommand cmd = new SqlCommand("select * from [User] where Email = @email and Password = @pass", con);
            con.Open();
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@pass", pass);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                Session["uid"] = dr["Uid"].ToString();
                Response.Redirect("TruckDetails.aspx", false);
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "loginerror()", true);
            }
            con.Close();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void adminLogin_Click(object sender, EventArgs e)
    {
        try
        {
            string id = adminid.Text;
            string pass = adminpass.Text;
            SqlCommand cmd = new SqlCommand("select * from Admin where Id = @id and Password = @pass", con);
            con.Open();
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@pass", pass);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                Session["aid"] = "admin";
                Response.Redirect("ManageTruck.aspx", false);
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "loginerror()", true);
            }
            con.Close();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}