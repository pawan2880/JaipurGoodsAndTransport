<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Tracking.aspx.cs" Inherits="Tracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container maincontent">
        
        <div class="innercontent pt-2 pb-5">
            
            <asp:Panel ID="Panel3" runat="server" CssClass="text-center">
                <asp:Label ID="Label1" runat="server" Text="On Going Trips"></asp:Label>
                <hr />
                <br />
                <h5 style="color: gray;">No Result Found..!!</h5>
            </asp:Panel>
            <asp:Panel ID="Panel1" runat="server">
            </asp:Panel>
            <asp:Panel ID="Panel2" runat="server">
                 
                <asp:Label ID="Label2" runat="server" Text="Tracking Details"></asp:Label>
            <hr />
            <br />
                <asp:TextBox ID="slatlong" runat="server" ClientIDMode="Static" style="display: none;"></asp:TextBox>
                <asp:TextBox ID="elatlong" runat="server" ClientIDMode="Static" style="display: none;"></asp:TextBox>
                <div id ="map" class="iframe-container" style="border-radius: 7px; height: 420px">

                </div>
                <br/>
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click"><i class="fa fa-arrow-left"></i> Back</asp:LinkButton>
            </asp:Panel>
        </div>
    </div>
</asp:Content>

