<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewUsers.aspx.cs" Inherits="ViewUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container maincontent">
        <div class="innercontent pt-2 pb-5">
            <asp:Label ID="Label1" runat="server" Text="Users Details"></asp:Label>
            <hr/>
            <br/>
            <asp:Panel ID="Panel2" runat="server" CssClass="text-center">
                <h5 style="color: gray;">No Result Found..!!</h5>
            </asp:Panel>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" Width="100%" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:TemplateField HeaderText="Picture">
                        <ItemTemplate>
                            <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("eid") %>' CssClass="img-fluid" style="width: 100px;
    height: 100px; border-radius: 50px;"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Name" DataField="name" />
                    <asp:BoundField HeaderText="Contact" DataField="contact" />
                    <asp:BoundField HeaderText="Email" DataField="email" />
                    <asp:BoundField HeaderText="Address" DataField="address" />
                    <asp:BoundField HeaderText="City" DataField="city" />
                    <asp:BoundField HeaderText="Age" DataField="age" />
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

