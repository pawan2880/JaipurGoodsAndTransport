using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tracking : System.Web.UI.Page
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
                    string trackidurl = Request.QueryString["id"];
                    if(trackidurl != null)
                    {
                        string slocation = "", did = "", elocation = "";
                        Panel1.Style.Add("display", "none");
                        Panel2.Style.Add("display", "initial");
                        SqlDataAdapter da = new SqlDataAdapter("select * from Trips where Tid = '" + trackidurl + "'", con);
                        DataSet ds = new DataSet();
                        da.Fill(ds);
                        if(ds.Tables[0].Rows.Count > 0)
                        {
                            Panel3.Visible = false;
                            slocation = ds.Tables[0].Rows[0][6].ToString();
                            did = ds.Tables[0].Rows[0][2].ToString();
                            SqlCommand cmd = new SqlCommand("select * from Driver where Did = '" + did + "'", con);
                            con.Open();
                            SqlDataReader dr = cmd.ExecuteReader();
                            if(dr.HasRows)
                            {
                                dr.Read();
                                elocation = dr["CurLoc"].ToString();
                            }
                            con.Close();
                        }
                        else
                        {
                            Panel3.Visible = true;
                        }
                        slatlong.Text = slocation;
                        elatlong.Text = elocation;
                    }
                    else
                    {
                        slatlong.Text = "";
                        elatlong.Text = "";
                        Panel1.Style.Add("display", "initial");
                        Panel2.Style.Add("display", "none");
                        string trackid = "", Tid = "", timg = "", tname = "", model = "", type = "", status = "", material = "", weight = "", date = "", destination="", source="";
                        string str = "";
                        SqlDataAdapter cmd = new SqlDataAdapter("select * from Trips where Uid = '" + Session["uid"] + "' and status not in ('Cancelled', 'Finished') order by (cast (SDatetime as Date)) desc", con);
                        DataSet ds = new DataSet();
                        cmd.Fill(ds);
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            Panel3.Visible = false;
                            str += "<label ID='Label1' runat='server' Text='On Going Trips'> On Going Trips</label><hr/><br/><div class='row'>";
                            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                            {
                                trackid = ds.Tables[0].Rows[i][0].ToString();
                                Tid = ds.Tables[0].Rows[i][3].ToString();
                                status = ds.Tables[0].Rows[i][8].ToString();
                                material = ds.Tables[0].Rows[i][13].ToString();
                                weight = ds.Tables[0].Rows[i][12].ToString();
                                date = ds.Tables[0].Rows[i][10].ToString();
                                source = ds.Tables[0].Rows[i][4].ToString();
                                destination = ds.Tables[0].Rows[i][5].ToString();
                                SqlCommand cmdd = new SqlCommand("select * from Truck where Tid = '" + Tid + "'", con);
                                con.Open();
                                SqlDataReader dr = cmdd.ExecuteReader();
                                if (dr.HasRows)
                                {
                                    dr.Read();
                                    timg = String.Format(@"data:image/jpeg;base64,{0}", dr["Image"]);
                                    tname = dr["Name"].ToString();
                                    model = "(" + dr["Modelno"].ToString() + ")";
                                    type = "(" + dr["Type"].ToString() + ")";
                                }
                                con.Close();
                                str += "<div class='col-md-6' style='border-right: 1px solid #dee2e6;'>" +
                                            "<div class='row'>" +
                                                "<div class='col-md-6'>" +
                                                    "<img  class='img-fluid' src='" + timg + "' />" +
                                                "</div>" +
                                                "<div class='col-md-6'>" +
                                                    "<h5 id='tname'>" + tname + "</h5>" +
                                                    "<label style='color: gray; font-size: 15px; '>" + model + "</label><br/> " +
                                                    "<label style='color: gray; font-size: 15px;'>" + type + "</label><br/>" +
                                                "</div>" +
                                                "<div class='col-md-12 text-right'>" +
                                                    "<a class='btn btn-success' href='Tracking.aspx?id=" + trackid + "'>Track</a>" +
                                                "</div>" +
                                            "</div>" +
                                        "</div>";
                                str += "<div class='col-md-6'>" +
                                            "<div class='table-responsive'>" +
                                                "<table>" +
                                                    "<tr>" +
                                                        "<td><label style='color: gray;'>Status:</label></td>" +
                                                        "<td><label>" + status + "</label></td>" +
                                                    "</tr>" +
                                                    "<tr>" +
                                                        "<td><label style='color: gray;'>Source:</label></td>" +
                                                        "<td><label>" + source + "</label></td>" +
                                                    "</tr>" +
                                                    "<tr>" +
                                                        "<td><label style='color: gray;'>Destination:</label></td>" +
                                                        "<td><label>" + destination + "</label></td>" +
                                                    "</tr>" +
                                                    "<tr>" +
                                                        "<td><label style='color: gray;'>Material:</label></td>" +
                                                        "<td><label>" + material + "</label></td>" +
                                                    "</tr>" +
                                                    "<tr>" +
                                                        "<td><label style='color: gray;'>Weight:</label></td>" +
                                                        "<td><label>" + weight + "</label></td>" +
                                                    "</tr>" +
                                                    "<tr>" +
                                                        "<td><label style='color: gray;'>PickUp Date:</label></td>" +
                                                        "<td><label>" + date + "</label></td>" +
                                                    "</tr>" +
                                                "</table>" +
                                            "</div>" +
                                        "</div>";

                                str += "<div class='col-md-12'><hr/></div>";
                            }
                            str += "</div>";
                            Panel1.GroupingText = str;
                        }
                        else
                        {
                            Panel3.Visible = true;
                        }
                        
                    }
                }
                catch (Exception ex)
                {
                    throw (ex);
                }
            }
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Tracking.aspx", false);
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}