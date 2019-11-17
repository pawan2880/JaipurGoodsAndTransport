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
using System.Xml;

public partial class Bookings : System.Web.UI.Page
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
                    SqlDataAdapter cmd = new SqlDataAdapter("select t.Tid, t.Material from Truck t inner join Driver d on t.Tid = d.Tid and t.Status = 'Enabled'", con);
                    DataSet ds1 = new DataSet();
                    cmd.Fill(ds1);
                    int count1 = ds1.Tables[0].Rows.Count;
                    if (count1 > 0)
                    {
                        for (int i = 0; i < count1; i++)
                        {
                            goods.Items.Add(new ListItem(ds1.Tables[0].Rows[i][1].ToString(), ds1.Tables[0].Rows[i][0].ToString()));
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
    public static string jsonData(string source, string destination)
    {
        try
        {
            string data = "";
            XmlDocument doc = new XmlDocument();
            doc.Load("https://maps.googleapis.com/maps/api/directions/xml?origin=" + source + "&destination=" + destination + "&key=AIzaSyBs6ifdtEVD4B2hn0yNtezAvIr0GQJsxRI");
            int count = 1;
            string boolean = "true";
            XmlNode status = doc.SelectSingleNode("//DirectionsResponse/status");
            if (status.InnerText == "ZERO_RESULTS")
            {
                boolean = "false";
                data = "0";
            }
            else
            {
                XmlNodeList element = doc.SelectNodes("//DirectionsResponse/geocoded_waypoint");
                foreach (XmlNode xn in element)
                {
                    if (xn["geocoder_status"].InnerText == "ZERO_RESULTS")
                    {
                        boolean = "false";
                        if (count == 1)
                        {
                            data = "1";
                            break;
                        }
                        else if (count == 2)
                        {
                            data = "2";
                        }
                    }
                    count++;
                }
            }
            if (boolean == "true")
            {
                XmlNode duration = doc.SelectSingleNode("//DirectionsResponse/route/leg/duration/text");
                XmlNode distance = doc.SelectSingleNode("//DirectionsResponse/route/leg/distance/text");
                XmlNode slat = doc.SelectSingleNode("//DirectionsResponse/route/leg/start_location/lat");
                XmlNode slng = doc.SelectSingleNode("//DirectionsResponse/route/leg/start_location/lng");
                XmlNode elat = doc.SelectSingleNode("//DirectionsResponse/route/leg/end_location/lat");
                XmlNode elng = doc.SelectSingleNode("//DirectionsResponse/route/leg/end_location/lng");
                XmlNode saddress = doc.SelectSingleNode("//DirectionsResponse/route/leg/start_address");
                XmlNode eaddress = doc.SelectSingleNode("//DirectionsResponse/route/leg/end_address");
                data += "[{";
                data += "\"duration\" :" + "\"" + duration.InnerText + "\",";
                data += "\"distance\" :" + "\"" + distance.InnerText + "\",";
                data += "\"slat\" :" + "\"" + slat.InnerText + "\",";
                data += "\"slng\" :" + "\"" + slng.InnerText + "\",";
                data += "\"elat\" :" + "\"" + elat.InnerText + "\",";
                data += "\"elng\" :" + "\"" + elng.InnerText + "\",";
                data += "\"saddress\" :" + "\"" + saddress.InnerText + "\",";
                data += "\"eaddress\" :" + "\"" + eaddress.InnerText + "\"";
                data += "}]";
            }
            return data;
        }
        catch (Exception ex)
        {
            throw (ex);
        } 
    }

    [WebMethod]
    public static string selecttruck(string noticetime, string date, string time, string goods, string weight)
    {
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["truck"].ConnectionString);
            string picupdate = date + " " + time;
            string enddate = "";
            string rdurationday = "";
            string rdurationhour = "";
            string rdurationmin = "";
            string rduration = "";
            string timeperiod = noticetime;
            string[] arr = timeperiod.Split(' ');
            string str = "";
            DateTime dt = Convert.ToDateTime(picupdate);
            DateTime edtt = Convert.ToDateTime(picupdate);
            //Calculate End Date
            for (int i = 0; i < arr.Length; i++)
            {
                double day = 0.0;
                if (arr[i] == "day" || arr[i] == "days")
                {
                    day = Convert.ToDouble(arr[i - 1]) * 2;
                    edtt = edtt.AddDays(day);
                    rdurationday += day + " days";
                }
                if (arr[i] == "hours" || arr[i] == "hour")
                {
                    day = Convert.ToDouble(arr[i - 1]) * 2;
                    edtt = edtt.AddHours(day);
                    rdurationhour += day + " hours";
                }
                if (arr[i] == "mins" || arr[i] == "min")
                {
                    day = Convert.ToDouble(arr[i - 1]) * 2;
                    edtt = edtt.AddMinutes(day);
                    rdurationmin += day + " mins";
                }
            }
            rduration = rdurationday + " " + rdurationhour + " " + rdurationmin;
            string edatetimee = edtt.Hour + ":" + edtt.Minute;
            string[] ar = edatetimee.Split(':');
            string etime = "";
            if (ar[0].Length == 1)
            {
                etime += "0" + ar[0];
            }
            else
            {
                etime += ar[0];
            }
            if (ar[1].Length == 1)
            {
                etime += ":0" + ar[1];
            }
            else
            {
                etime += ":" + ar[1];
            }
            enddate = edtt.Year + "/" + edtt.Month + "/" + edtt.Day + " " + etime;

            string result = "no";
            string final = "";
            //Select Truck Weight from database
            SqlDataAdapter da = new SqlDataAdapter("select * from Truck where Tid = '" + goods + "'", con);
            DataSet ts = new DataSet();
            da.Fill(ts);
            int tscount = ts.Tables[0].Rows.Count;
            if (tscount > 0)
            {
                string tweight = ts.Tables[0].Rows[0][6].ToString();
                string[] tarr = tweight.Split(' ');
                tweight = tarr[0].ToString();
                if (Convert.ToInt32(weight) <= Convert.ToInt32(tweight))
                {
                    SqlDataAdapter cmd = new SqlDataAdapter("select * from Trips where status not in ('Finished', 'Cancelled') and Cid = '" + goods + "'", con);
                    DataSet ds = new DataSet();
                    cmd.Fill(ds);
                    int count = ds.Tables[0].Rows.Count;
                    if (count > 0)
                    {
                        for (int i = 0; i < count; i++)
                        {
                            string sdatetime = ds.Tables[0].Rows[i][10].ToString();
                            string edatetime = ds.Tables[0].Rows[i][11].ToString();
                            DateTime sdt = Convert.ToDateTime(picupdate);
                            DateTime edt = Convert.ToDateTime(enddate);
                            DateTime dt1 = Convert.ToDateTime(sdatetime);
                            DateTime dt2 = Convert.ToDateTime(edatetime);
                            //Compare Start Date with DB Start date
                            int value = DateTime.Compare(sdt, dt1);
                            //If sdt>dt1
                            if (value > 0)
                            {
                                //Compare Start Date with DB End date
                                int value1 = DateTime.Compare(sdt, dt2);
                                //if sdt>dt2
                                if (value1 > 0)
                                {
                                }
                                //sdt<dt2
                                else if (value1 < 0)
                                {
                                    result = "yes";
                                    break;
                                }
                                //sdt=dt2
                                else
                                {
                                    result = "yes";
                                    break;
                                }
                            }
                            //sdt<dt1
                            else if (value < 0)
                            {
                                //Compare End Date with DB Start date
                                int value4 = DateTime.Compare(edt, dt1);
                                //edt>dt1
                                if (value4 > 0)
                                {
                                    result = "yes";
                                    break;
                                }
                                //edt<dt1
                                else if (value4 < 0)
                                {
                                }
                                //edt=dt1
                                else
                                {
                                    result = "yes";
                                    break;
                                }
                            }
                            //sdt=dt1
                            else
                            {

                                result = "yes";
                                break;
                            }
                            //Compare End Date with DB Start date
                            int value2 = DateTime.Compare(edt, dt1);
                            //edt>dt1
                            if (value2 > 0)
                            {
                                //Compare End Date with DB end date
                                int value3 = DateTime.Compare(edt, dt2);
                                //edt>dt2
                                if (value3 > 0)
                                {
                                }
                                //edt<dt2
                                else if (value3 < 0)
                                {
                                    result = "yes";
                                    break;
                                }
                                //edt=dt2
                                else
                                {
                                    result = "yes";
                                    break;
                                }
                            }
                            //edt<dt1
                            else if (value2 < 0)
                            {
                            }
                            //edt=dt1
                            else
                            {
                                result = "yes";
                                break;
                            }
                        }
                    }
                    else
                    {
                        result = "empty";
                    }
                }
                else
                {
                    result = "Weight is allowed up to " + tweight + " Kgs";
                }
                string image = String.Format(@"data:image/jpeg;base64,{0}", ts.Tables[0].Rows[0][1].ToString());
                final += "[{";
                final += "\"image\" :" + "\"" + image + "\",";
                final += "\"name\" :" + "\"" + ts.Tables[0].Rows[0][2].ToString() + "\",";
                final += "\"modelno\" :" + "\"" + ts.Tables[0].Rows[0][3].ToString() + "\",";
                final += "\"type\" :" + "\"" + ts.Tables[0].Rows[0][4].ToString() + "\",";
                final += "\"cost\" :" + "\"" + ts.Tables[0].Rows[0][10].ToString() + "\",";
                final += "\"picupdate\" :" + "\"" + picupdate + "\",";
                final += "\"enddate\" :" + "\"" + enddate + "\",";
                final += "\"material\" :" + "\"" + ts.Tables[0].Rows[0][9].ToString() + "\",";
                final += "\"rduration\" :" + "\"" + rduration + "\",";
                final += "\"result\" :" + "\"" + result + "\"";
                final += "}]";
            }
            return final;
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }

    protected void Booked_Click(object sender, EventArgs e)
    {
        try
        {
            string uid = Session["uid"].ToString();
            string did = "";
            string cid = tid.Text;
            string source = sourceadd.Text;
            string dest = destinationadd.Text;
            string slatlng = slat.Text + ", " + slng.Text;
            string dlatlng = elat.Text + ", " + elng.Text;
            string status = "Booked";
            string price = tprice.Text;
            string sdatetime = picupdate.Text;
            string edatetime = enddate.Text;
            string weight = tweight.Text;
            string Material = material.Text;
            SqlCommand cmd = new SqlCommand("select * from Driver where Tid = '" + cid + "'", con);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                did = dr["Did"].ToString();
            }
            con.Close();

            cmd = new SqlCommand("insert into Trips Values (@uid, @did, @cid, @source, @dest, @slatlng, @dlatlng, @status, @price, @sdatetime, @edatetime, @weight, @Material)", con);
            con.Open();
            cmd.Parameters.AddWithValue("@uid", uid);
            cmd.Parameters.AddWithValue("@did", did);
            cmd.Parameters.AddWithValue("@cid", cid);
            cmd.Parameters.AddWithValue("@source", source);
            cmd.Parameters.AddWithValue("@dest", dest);
            cmd.Parameters.AddWithValue("@slatlng", slatlng);
            cmd.Parameters.AddWithValue("@dlatlng", dlatlng);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@price", price);
            cmd.Parameters.AddWithValue("@sdatetime", sdatetime);
            cmd.Parameters.AddWithValue("@edatetime", edatetime);
            cmd.Parameters.AddWithValue("@weight", weight);
            cmd.Parameters.AddWithValue("@Material", Material);
            int count = cmd.ExecuteNonQuery();
            if (count > 0)
            {
                con.Close();
                string title = "New Booking - " + sdatetime;
                string message = "Pickup - " + source;
                cmd = new SqlCommand("insert into noti Values (@did, @cid, @title, @message)", con);
                con.Open();
                cmd.Parameters.AddWithValue("@did", did);
                cmd.Parameters.AddWithValue("@cid", cid);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@message", message);
                count = cmd.ExecuteNonQuery();
                if (count > 0)
                {
                    Response.Redirect("UserBooking.aspx", false);
                }
                con.Close();
            }
        }
        catch (Exception ex)
        {
            throw (ex);
        }
    }
}