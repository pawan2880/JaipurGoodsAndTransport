using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AboutTruck : System.Web.UI.Page
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
                    SqlCommand cmd = new SqlCommand("select * from Truck", con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        dr.Read();
                        string image = String.Format(@"data:image/jpeg;base64,{0}", dr["Image"]);
                        string name = dr["Name"].ToString();
                        string weight = dr["Maxweight"].ToString();
                        string id = dr["Tid"].ToString();
                        string model = dr["Modelno"].ToString();
                        string ttype = dr["Type"].ToString();
                        string ssize = dr["Size"].ToString();
                        string sspeed = dr["Speed"].ToString();
                        string Location = dr["Location"].ToString();
                        string Material = dr["Material"].ToString();
                        string scost = dr["Cost"].ToString();
                        truckimage.ImageUrl = image;
                        string str = name;
                        tname.InnerText = str;
                        type.Text = "(" + ttype + ")";
                        mno.Text = model;
                        size.Text = ssize;
                        maxwt.Text = weight;
                        speed.Text = sspeed;
                        cost.Text = scost;
                        location.Text = Location;
                        material.Text = Material;
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