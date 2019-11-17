using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewUsers : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["truck"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["aid"] == null)
        {
            Response.Redirect("index.aspx", false);
        }
        else
        {
            if (!IsPostBack)
            {
                try
                {
                    DataTable dt = new DataTable();
                    dt.Columns.Add("eid");
                    dt.Columns.Add("name");
                    dt.Columns.Add("contact");
                    dt.Columns.Add("email");
                    dt.Columns.Add("address");
                    dt.Columns.Add("city");
                    dt.Columns.Add("age");
                    SqlCommand cmd = new SqlCommand("select * from [User] order by Uid Desc", con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        Panel2.Visible = false;
                        while (dr.Read())
                        {
                            string image = String.Format(@"data:image/jpeg;base64,{0}", dr["Image"]);
                            dt.Rows.Add(image, dr["Name"].ToString(), dr["Contact"].ToString(), dr["Email"].ToString(), dr["Address"].ToString(), dr["City"].ToString(), dr["Age"].ToString());
                        }
                        con.Close();
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                    else
                    {
                        Panel2.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
            }
        }
    }
}