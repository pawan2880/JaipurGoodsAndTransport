using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangePassword : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["truck"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uid"] == null)
        {
            Response.Redirect("index.aspx", false);
        }
        else
        {
            if (!IsPostBack)
            {
                try
                {

                }
                catch (Exception ex)
                {
                    throw (ex);
                }
            }
        }
    }
    protected void cpassword_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string password = cpassword.Text;
            string newpass = npassword.Text;
            string cpass = copassword.Text;
            SqlCommand cmd = new SqlCommand("select * from [User] where Uid = '" + Session["uid"].ToString() + "'", con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                if (password == dr["Password"].ToString())
                {
                    cpasserror.Visible = false;
                }
                else
                {
                    cpasserror.Visible = true;
                }
            }
            if (password != "" && newpass != "" && cpass != "" && cpasserror.Visible != true && copasserror.Visible != true)
            {
                Submit.Visible = true;
            }
            else
            {
                Submit.Visible = false;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "swal", "textbox();", true);
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        try
        {
            string password = cpassword.Text;
            string newpass = npassword.Text;
            string cpass = copassword.Text;
            SqlCommand cmd = new SqlCommand("Update [User] set Password = '" + cpass + "' where Uid = '" + Session["Uid"].ToString() + "'", con);
            con.Open();
            int count = cmd.ExecuteNonQuery();
            if (count > 0)
            {
                Session["cpass"] = "true";
                Response.Redirect("Logout.aspx", false);
            }
            con.Close();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void copassword_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string password = cpassword.Text;
            string newpass = npassword.Text;
            string cpass = copassword.Text;
            if (newpass == cpass)
            {
                copasserror.Visible = false;
            }
            else
            {
                copasserror.Visible = true;
            }

            if (password != "" && newpass != "" && cpass != "" && cpasserror.Visible != true && copasserror.Visible != true)
            {
                Submit.Visible = true;
            }
            else
            {
                Submit.Visible = false;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "swal", "textbox();", true);
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}