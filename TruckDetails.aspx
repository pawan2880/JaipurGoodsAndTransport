<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TruckDetails.aspx.cs" Inherits="TruckDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container" style="margin-top: 10%;">
        <div class="innercontent pt-2 pb-5">
            <center><h5 class="text-white"><span class="frist"> </span>Popular Truck Types<span class="second"> </span></h5></center>
            <asp:Panel ID="Panel1" runat="server"></asp:Panel>
        </div>
    </div>
</asp:Content>

