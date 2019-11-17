using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            try
            {
                Session["uid"] = null;
                Session["aid"] = null;
                Response.Redirect("index.aspx", false);
            }
            catch(Exception ex)
            {
                throw (ex);
            }
        }
    }
}