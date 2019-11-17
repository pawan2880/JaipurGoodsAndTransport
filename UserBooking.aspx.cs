using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserBooking : System.Web.UI.Page
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
                    DataTable dt = new DataTable();
                    dt.Columns.Add("tid");
                    dt.Columns.Add("did");
                    dt.Columns.Add("cid");
                    dt.Columns.Add("source");
                    dt.Columns.Add("dest");
                    dt.Columns.Add("status");
                    dt.Columns.Add("price");
                    dt.Columns.Add("sdate");
                    dt.Columns.Add("edate");
                    dt.Columns.Add("weight");
                    dt.Columns.Add("material");
                    SqlCommand cmd = new SqlCommand("select t.*, u.Name as uname, d.Name as dname, tu.Name as tname from Trips t inner join [User] u on t.Uid = u.Uid inner join Driver d on t.Did = d.Did inner join Truck tu on t.Cid = tu.Tid where t.Uid = '"+Session["uid"].ToString()+ "' and t.status ! = 'Cancelled' order by (cast (t.SDatetime as Date)) desc", con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        Panel2.Visible = false;
                        while (dr.Read())
                        {
                            dt.Rows.Add(dr["Tid"].ToString(), dr["dname"].ToString(), dr["tname"].ToString(), dr["source"].ToString(), dr["dest"].ToString(), dr["status"].ToString(), dr["price"].ToString(), dr["SDatetime"].ToString(), dr["EDatetime"].ToString(), dr["Weight"].ToString(), dr["Material"].ToString());
                        }
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                    else
                    {
                        Panel2.Visible = true;
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

    [WebMethod]
    public static void cancel(string id)
    {
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["truck"].ConnectionString);
            SqlCommand cmd = new SqlCommand("update Trips set status = 'Cancelled' where Tid = '" + id + "'", con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch(Exception ex)
        {
            throw (ex);
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btnUpdate = (LinkButton)e.Row.FindControl("btn");
                if ((e.Row.Cells[5].Text == "Booked"))
                {
                    btnUpdate.Style.Add("display", "initial");
                }
                else
                {
                    btnUpdate.Style.Add("display", "none");
                }
            }
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}