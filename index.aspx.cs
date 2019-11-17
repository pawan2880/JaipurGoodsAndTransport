using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class index : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["truck"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            if (Session["cpass"] != null)
            {
                Session["cpass"] = null;
                Page.ClientScript.RegisterStartupScript(GetType(), "msgtype", "swal('Updated Password, Kindly Login again..!!');", true);
            }
        }
    }

    
}