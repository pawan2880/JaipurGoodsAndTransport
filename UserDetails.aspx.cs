using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserDetails : System.Web.UI.Page
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
                    SqlCommand cmd = new SqlCommand("select * from [User] where Uid = '" + Session["uid"].ToString() + "'", con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if(dr.HasRows)
                    {
                        dr.Read();
                        userimage.ImageUrl = String.Format(@"data:image/jpeg;base64,{0}", dr["Image"]);
                        uname.InnerText = dr["Name"].ToString();
                        contact.Text = dr["Contact"].ToString();
                        email.Text = dr["Email"].ToString();
                        age.Text = dr["Age"].ToString();
                        address.Text = dr["Address"].ToString() + ", " + dr["City"].ToString();
                    }
                    con.Close();
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
            }
        }
    }
}