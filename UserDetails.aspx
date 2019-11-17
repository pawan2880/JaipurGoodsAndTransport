<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UserDetails.aspx.cs" Inherits="UserDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container" style="margin-top: 6%;">
        <div class="innercontent pt-2 pb-5">

            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="card testimonial-card">
                        <div class="card-up indigo lighten-1"></div>
                        <div class="avatar mx-auto white">
                            <asp:Image ID="userimage" runat="server" CssClass="rounded-circle"/>
                        </div>
                        <div class="card-body">
                            <h4 class="card-title  text-center" id="uname" runat="server"></h4>
                            <hr>
                            <div class="table-responsive">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text="Contact Number: "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="contact" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><br/></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text="Email Id: "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="email" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><br/></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text="Age: "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="age" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><br/></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" Text="Address: "></asp:Label>
                                        </td>
                                        <td>
                                           <asp:Label ID="address" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><br/></td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>
        </div>
    </div>
</asp:Content>

