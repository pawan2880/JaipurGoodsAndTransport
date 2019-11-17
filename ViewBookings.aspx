<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewBookings.aspx.cs" Inherits="ViewBookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container maincontent">
        <div class="innercontent pt-2 pb-5">
            <asp:Label ID="Label1" runat="server" Text="Booking Details"></asp:Label>
            <hr/>
            <br/>
            <asp:Panel ID="Panel2" runat="server" CssClass="text-center">
                <h5 style="color: gray;">No Result Found..!!</h5>
            </asp:Panel>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" Width="100%" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" EmptyDataText="No data available.">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:BoundField HeaderText="User Name" DataField="uid" />
                    <asp:BoundField HeaderText="Driver Name" DataField="did" />
                    <asp:BoundField HeaderText="Truck Name" DataField="cid" />
                    <asp:BoundField HeaderText="Source" DataField="source" />
                    <asp:BoundField HeaderText="Destination" DataField="dest" />
                    <asp:BoundField HeaderText="Status" DataField="status" />
                    <asp:BoundField HeaderText="Price" DataField="price" />
                    <asp:BoundField HeaderText="Start Date" DataField="sdate" />
                    <asp:BoundField HeaderText="End Date" DataField="edate" />
                    <asp:BoundField HeaderText="Weight" DataField="weight" />
                    <asp:BoundField HeaderText="Material" DataField="material" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>

