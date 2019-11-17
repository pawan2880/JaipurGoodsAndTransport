using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["truck"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            try
            {
                if (Session["uid"] != null)
                {
                    homecontent.Attributes.Add("class", "content banner");
                    user.Visible = true;
                    admin.Visible = false;
                    navbar.Visible = false;
                    SqlCommand cmd = new SqlCommand("select * from [User] where Uid = '" + Session["uid"] + "'", con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        Image1.ImageUrl = String.Format(@"data:image/jpeg;base64,{0}", dr["Image"]);
                    }
                    con.Close();
                }
                else if (Session["aid"] != null)
                {
                    homecontent.Attributes.Add("class", "content banner");
                    user.Visible = false;
                    admin.Visible = true;
                    navbar.Visible = false;
                }
                else
                {
                    homecontent.Attributes.Add("class", "content");
                    user.Visible = false;
                    admin.Visible = false;
                    navbar.Visible = true;
                }
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }
    }
}
