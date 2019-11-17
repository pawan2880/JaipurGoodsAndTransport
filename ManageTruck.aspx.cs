using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageTruck : System.Web.UI.Page
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
            if(!IsPostBack)
            {
                try
                {
                    gvbind();
                }
                catch(Exception ex)
                {
                    throw (ex);
                }
            }
        }
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        try
        {
            System.IO.Stream fs = image.PostedFile.InputStream;
            System.IO.BinaryReader br = new System.IO.BinaryReader(fs);
            Byte[] bytes = br.ReadBytes((Int32)fs.Length);
            string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
            string tname = name.Text;
            string tmodel = modelno.Text;
            string tsize = size.Text;
            string ttype = type.Text;
            string tmaxwt = maxwt.Text + " Kgs";
            string tspeed = speed.Text;
            string tmaterial = material.Text;
            string tlocation = location.Text;
            string tcost = cost.Text;
            string tid = "";
            SqlCommand cmd = new SqlCommand("select (coalesce(cast(Tid as int), 0) + 1) as Tid from Truck order by Tid desc", con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                tid = dr["Tid"].ToString();
            }
            else
            {
                tid = "1";
            }
            con.Close();
            cmd = new SqlCommand("insert into Truck (Tid, Image, Name, Modelno, Type, Size, Maxweight, Speed, Location, Material, Cost, Status) values (@tid, @base64String, @tname, @tmodel, @ttype, @tsize, @tmaxwt, @tspeed, @tlocation, @tmaterial, @tcost, @status)", con);
            con.Open();
            cmd.Parameters.AddWithValue("@tid", tid);
            cmd.Parameters.AddWithValue("@base64String", base64String);
            cmd.Parameters.AddWithValue("@tname", tname);
            cmd.Parameters.AddWithValue("@tmodel", tmodel);
            cmd.Parameters.AddWithValue("@ttype", ttype);
            cmd.Parameters.AddWithValue("@tsize", tsize);
            cmd.Parameters.AddWithValue("@tmaxwt", tmaxwt);
            cmd.Parameters.AddWithValue("@tspeed", tspeed);
            cmd.Parameters.AddWithValue("@tlocation", tlocation);
            cmd.Parameters.AddWithValue("@tmaterial", tmaterial);
            cmd.Parameters.AddWithValue("@tcost", tcost);
            cmd.Parameters.AddWithValue("@status", "Enabled");
            int count = cmd.ExecuteNonQuery();
            if (count > 0)
            {
                Response.Redirect("ManageTruck.aspx", false);
            }
            con.Close();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void gvbind()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Select * from Truck order by Tid Desc", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            DataTable dt = new DataTable();
            dt.Columns.Add("tid");
            dt.Columns.Add("name");
            dt.Columns.Add("mno");
            dt.Columns.Add("type");
            dt.Columns.Add("size");
            dt.Columns.Add("maxwt");
            dt.Columns.Add("speed");
            dt.Columns.Add("material");
            dt.Columns.Add("location");
            dt.Columns.Add("cost");
            dt.Columns.Add("status");
            if (ds.Tables[0].Rows.Count > 0)
            {
                Panel2.Visible = false;
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    dt.Rows.Add(ds.Tables[0].Rows[i][0].ToString(), ds.Tables[0].Rows[i][2].ToString(), ds.Tables[0].Rows[i][3].ToString(), ds.Tables[0].Rows[i][4].ToString(), ds.Tables[0].Rows[i][5].ToString(), ds.Tables[0].Rows[i][6].ToString(), ds.Tables[0].Rows[i][7].ToString(), ds.Tables[0].Rows[i][9].ToString(), ds.Tables[0].Rows[i][8].ToString(), ds.Tables[0].Rows[i][10].ToString(), ds.Tables[0].Rows[i][11].ToString());
                }
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

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GridView1.PageIndex = e.NewPageIndex;
            gvbind();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            GridView1.EditIndex = -1;
            gvbind();
            GridView1.Columns[12].Visible = true;
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            GridView1.EditIndex = e.NewEditIndex;
            gvbind();
            GridView1.Columns[12].Visible = false;
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int userid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
            Label lblID = (Label)row.FindControl("lblID");
            TextBox textName = (TextBox)row.Cells[1].Controls[0];
            TextBox model = (TextBox)row.Cells[2].Controls[0];
            TextBox type = (TextBox)row.Cells[3].Controls[0];
            TextBox size = (TextBox)row.Cells[4].Controls[0];
            TextBox maxwt = (TextBox)row.Cells[5].Controls[0];
            TextBox speed = (TextBox)row.Cells[6].Controls[0];
            TextBox material = (TextBox)row.Cells[7].Controls[0];
            TextBox location = (TextBox)row.Cells[8].Controls[0];
            TextBox cost = (TextBox)row.Cells[9].Controls[0];
            GridView1.EditIndex = -1;
            if(textName.Text != "" && model.Text != "" && type.Text != "" && size.Text != "" && maxwt.Text != "" && speed.Text != "" && material.Text != "" && location.Text != "")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update Truck set Name='" + textName.Text + "', Modelno='" + model.Text + "', Type='" + type.Text + "', Size='" + size.Text + "', Maxweight='" + maxwt.Text + "', Speed='" + speed.Text + "', Location='" + location.Text + "', Material='" + material.Text + "', Cost='" + cost.Text + "' where Tid='" + userid + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();
                gvbind();
                GridView1.Columns[12].Visible = true;
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "swal('All Fileds are required..!!')", true);
            }
        }
        catch (Exception ex)
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
                LinkButton Enable = (LinkButton)e.Row.FindControl("enable");
                LinkButton Disable = (LinkButton)e.Row.FindControl("disable");
                if ((e.Row.Cells[10].Text == "Enabled"))
                {
                    Enable.Style.Add("display", "none");
                    Disable.Style.Add("display", "initial");
                }
                else
                {
                    Enable.Style.Add("display", "initial");
                    Disable.Style.Add("display", "none");
                }
            }
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "enable")
            {
                SqlCommand cmd = new SqlCommand("update Truck set Status = 'Enabled' where Tid = '" + id + "'", con);
                con.Open();
                int result = cmd.ExecuteNonQuery();
                if (result > 0)
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "truckstatusenable();", true);
                }
                con.Close();
            }
            else if (e.CommandName == "disable")
            {
                string disableStatus = "Yes";
                SqlCommand cmd = new SqlCommand("select * from Trips where Cid = '" + id + "'", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    string status = dr["status"].ToString().Trim();
                    if (status == "Booked" || status == "Started" || status == "Picked")
                    {
                        disableStatus = "No";
                    }
                }
                con.Close();
                if (disableStatus == "Yes")
                {
                    cmd = new SqlCommand("update Truck set Status = 'Disabled' where Tid = '" + id + "'", con);
                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    if (result > 0)
                    {
                        con.Close();
                        cmd = new SqlCommand("update Driver set Tid = '' where Tid = '" + id + "'", con);
                        con.Open();
                        result = cmd.ExecuteNonQuery();
                        if (result > 0)
                        {

                        }
                        con.Close();
                    }
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "truckstatus();", true);
                }
                else
                {
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "notupdated();", true);
                }
            }
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}