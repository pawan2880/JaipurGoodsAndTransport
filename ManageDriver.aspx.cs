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

public partial class ManageDriver : System.Web.UI.Page
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
                    gvbind();
                    SqlDataAdapter cmd = new SqlDataAdapter("select Tid,Name from Truck where Status = 'Enabled'", con);
                    DataSet ds1 = new DataSet();
                    cmd.Fill(ds1);
                    int count1 = ds1.Tables[0].Rows.Count;
                    if (count1 > 0)
                    {
                        for(int i=0; i<count1; i++)
                        {
                            SqlDataAdapter da = new SqlDataAdapter("select Tid from Driver where Tid = '" + ds1.Tables[0].Rows[i][0].ToString() + "'", con);
                            DataSet ds = new DataSet();
                            da.Fill(ds);
                            int count = ds.Tables[0].Rows.Count;
                            if(count == 0)
                            {
                                truckname.Items.Add(new ListItem(ds1.Tables[0].Rows[i][1].ToString(), ds1.Tables[0].Rows[i][0].ToString()));
                                utruck.Items.Add(new ListItem(ds1.Tables[0].Rows[i][1].ToString(), ds1.Tables[0].Rows[i][0].ToString()));
                            }
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

    [WebMethod]
    public static string viewtruck(string id)
    {
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["truck"].ConnectionString);
            SqlDataAdapter da = new SqlDataAdapter("select Tid from Driver where Did = '"+id+"'", con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            string tid = ds.Tables[0].Rows[0][0].ToString();

            SqlCommand cmd = new SqlCommand("select * from Truck where Tid = '" + tid + "'", con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            string str = "";
            if (dr.HasRows)
            {
                dr.Read();
                string img = String.Format(@"data:image/jpeg;base64,{0}", dr["Image"]);
                str += "<div class='table-responsive'>" +
                            "<table style='width: 100%'>" +
                                "<tr><td colspan = '2'><img src='" + img.ToString() + " ' id = 'Image1' class='img-fluid'/></td></ tr ><tr><td colspan='2'><br/></td></tr>" +
                                "<tr><td style='color: gray;'>Truck Name:</td><td><label id = 'Label3' ClientIDMode = 'Static' style='margin-bottom: 0px;'>" + dr["Name"].ToString() + "</ label ></td></tr><tr><td colspan='2'><br/></td></tr>" +
                                "<tr><td style='color: gray;'>Model Number:</td><td><label ID = 'Label4' ClientIDMode = 'Static' style='margin-bottom: 0px;'>" + dr["Modelno"].ToString() + "</label></td></tr><tr><td colspan='2'><hr/></td></tr>" +
                            "</table>" +
                        "</div>";
            }
            con.Close();
            return str;
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
                System.IO.Stream fs = image.PostedFile.InputStream;
                System.IO.BinaryReader br = new System.IO.BinaryReader(fs);
                Byte[] bytes = br.ReadBytes((Int32)fs.Length);
                string profile = Convert.ToBase64String(bytes, 0, bytes.Length);
                fs = proofimage.PostedFile.InputStream;
                br = new System.IO.BinaryReader(fs);
                bytes = br.ReadBytes((Int32)fs.Length);
                string idproof = Convert.ToBase64String(bytes, 0, bytes.Length);

                string dname = name.Text;
                string demail = email.Text;
                string dcontact = contact.Text;
                string ddob = dob.Value;
                string dtruckname = truckname.Text;
                string daddress = address.InnerText;
                string dlocation = location.Text;
                string dpassword = password.Text;
                string did = "";
                string curloc = "0.0,0.0";
                SqlCommand cmd = new SqlCommand("select (coalesce(cast(Did as int), 0) + 1) as Did from Driver order by Did desc", con);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    did = dr["Did"].ToString();
                }
                else
                {
                    did = "101";
                }
                con.Close();
                cmd = new SqlCommand("select * from Driver where Email = '" + demail + "'", con);
                con.Open();
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    con.Close();
                    Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "driverregerror()", true);
                }
                else
                {
                    con.Close();
                    cmd = new SqlCommand("insert into Driver (Did, Name, Email, Contact, DOB, Image, Password, CurLoc, Address, City, Proof, Tid) values (@did, @dname, @demail, @dcontact, @ddob, @profile, @dpassword, @curloc, @daddress, @dlocation, @idproof, @dtruckname)", con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@did", did);
                    cmd.Parameters.AddWithValue("@dname", dname);
                    cmd.Parameters.AddWithValue("@demail", demail);
                    cmd.Parameters.AddWithValue("@dcontact", dcontact);
                    cmd.Parameters.AddWithValue("@ddob", ddob);
                    cmd.Parameters.AddWithValue("@profile", profile);
                    cmd.Parameters.AddWithValue("@dpassword", dpassword);
                    cmd.Parameters.AddWithValue("@curloc", curloc);
                    cmd.Parameters.AddWithValue("@daddress", daddress);
                    cmd.Parameters.AddWithValue("@dlocation", dlocation);
                    cmd.Parameters.AddWithValue("@idproof", idproof);
                    cmd.Parameters.AddWithValue("@dtruckname", dtruckname);
                    int count = cmd.ExecuteNonQuery();
                    if (count > 0)
                    {
                        Response.Redirect("ManageDriver.aspx", false);
                    }
                    con.Close();
                }
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
            DataTable dt = new DataTable();
            dt.Columns.Add("did");
            dt.Columns.Add("eid");
            dt.Columns.Add("name");
            dt.Columns.Add("email");
            dt.Columns.Add("contact");
            dt.Columns.Add("dob");
            dt.Columns.Add("status");
            dt.Columns.Add("address");
            dt.Columns.Add("city");
            dt.Columns.Add("tname");
            dt.Columns.Add("proof");

            SqlCommand cmd = new SqlCommand("select * from Driver order by Did DESC", con);
            SqlDataAdapter da1 = new SqlDataAdapter(cmd);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                Panel2.Visible = false;
                for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                {
                    string image = String.Format(@"data:image/jpeg;base64,{0}", ds1.Tables[0].Rows[j][5].ToString());
                    cmd = new SqlCommand("Select d.*, t.Name from Driver d inner join Truck t on d.Tid = t.Tid and Did = '" + ds1.Tables[0].Rows[j][0].ToString() + "' ", con);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string assign = "<u><a id='" + ds1.Tables[0].Rows[j][0].ToString() + "' class='assign text-primary'>" + ds.Tables[0].Rows[0][13].ToString() + "</a></u>";
                        dt.Rows.Add(ds.Tables[0].Rows[0][0].ToString(), image, ds.Tables[0].Rows[0][1].ToString(), ds.Tables[0].Rows[0][2].ToString(), ds.Tables[0].Rows[0][3].ToString(), ds.Tables[0].Rows[0][4].ToString(), ds.Tables[0].Rows[0][8].ToString(), ds.Tables[0].Rows[0][9].ToString(), ds.Tables[0].Rows[0][10].ToString(), assign, ds.Tables[0].Rows[0][11].ToString());
                    }
                    else
                    {
                        string assign = "<button id='" + ds1.Tables[0].Rows[j][0].ToString() + "' type='button' class='assign btn btn-warning' style='box-shadow: none;padding: .84rem 1.14rem;'>Assign</button>";
                        dt.Rows.Add(ds1.Tables[0].Rows[j][0].ToString(), image, ds1.Tables[0].Rows[j][1].ToString(), ds1.Tables[0].Rows[j][2].ToString(), ds1.Tables[0].Rows[j][3].ToString(), ds1.Tables[0].Rows[j][4].ToString(), ds1.Tables[0].Rows[j][8].ToString(), ds1.Tables[0].Rows[j][9].ToString(), ds1.Tables[0].Rows[j][10].ToString(), assign, ds1.Tables[0].Rows[j][11].ToString());
                    }
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
            this.GridView1.Columns[9].Visible = true;
            gvbind();
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
            this.GridView1.Columns[9].Visible = false;
            GridView1.EditIndex = e.NewEditIndex;
            gvbind();
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
            TextBox textName = (TextBox)row.Cells[2].Controls[0];
            TextBox email = (TextBox)row.Cells[3].Controls[0];
            TextBox contact = (TextBox)row.Cells[4].Controls[0];
            TextBox dob = (TextBox)row.Cells[5].Controls[0];
            TextBox address = (TextBox)row.Cells[7].Controls[0];
            TextBox city = (TextBox)row.Cells[8].Controls[0];
            GridView1.EditIndex = -1;
            if (textName.Text != "" && email.Text != "" && contact.Text != "" && dob.Text != "" && address.Text != "" && city.Text != "")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("update Driver set Name='" + textName.Text + "', Email='" + email.Text + "', Contact='" + contact.Text + "', DOB='" + dob.Text + "', Address='" + address.Text + "', City='" + city.Text + "' where DId = '" + userid + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();
                this.GridView1.Columns[9].Visible = true;
                gvbind();
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

    

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            string deleteData = "Yes";
            GridViewRow row = (GridViewRow)GridView1.Rows[e.RowIndex];
            Label lbldeleteid = (Label)row.FindControl("lblID");
            int mainid = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            SqlCommand cmd = new SqlCommand("select * from Trips where Did = '" + mainid + "'", con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                string status = dr["status"].ToString();
                if (status == "Booked" || status == "Started" || status == "Picked")
                {
                    deleteData = "No";
                }
            }
            con.Close();
            if (deleteData == "Yes")
            {
                con.Open();
                cmd = new SqlCommand("delete FROM Driver where Did='" + mainid + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "deletes();", true);
            }
            gvbind();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string proof = GridView1.SelectedRow.Cells[10].Text;
            primg.ImageUrl = String.Format(@"data:image/jpeg;base64,{0}", proof);
            Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "showimg();", true);
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void truckupdate_Click(object sender, EventArgs e)
    {
        try
        {
            string id = driverId.Text;
            string truckname = utruck.Text;
            SqlCommand cmd = new SqlCommand("update Driver set Tid = '" + truckname + "' where Did = '" + id + "'", con);
            con.Open();
            cmd.ExecuteNonQuery();
            Response.Redirect("ManageDriver.aspx", false);
            con.Close();
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}