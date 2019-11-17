using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TruckDetails : System.Web.UI.Page
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
                    string str = "";
                    if (dr.HasRows)
                    {
                        str += "<div class='row'>";
                        while(dr.Read())
                        {
                            string image = String.Format(@"data:image/jpeg;base64,{0}", dr["Image"]);
                            string name = dr["Name"].ToString();
                            string weight = dr["Maxweight"].ToString();
                            string id = dr["Tid"].ToString();
                            str += "<div class='col-md-3 zoom mt-5'><a href = 'AboutTruck.aspx?id=" + id + "'><div class='card card-cascade narrower'>" +
                                        "<div class='view view-cascade overlay'>" +
                                            "<img class='card-img-top' src='" + image + "' alt='Card image cap' style='height: 200px;' class='img-fluid'>" +
                                            "<div class='mask rgba-white-slight'></div>" +
                                        "</div>" +
                                        "<div class='card-body card-body-cascade text-center'>" +
                                            "<h5 class='font-weight-bold card-title'>" + name + "</h5>" +
                                            "<p class='card-text'>" + weight + "</p>" +
                                        "</div>" +
                                    "</div></a></div>";
                        }
                        str += "</div>";
                        Panel1.GroupingText = str;
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