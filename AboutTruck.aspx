<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AboutTruck.aspx.cs" Inherits="AboutTruck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container maincontent" style="margin-top: 10%;">
        <div class="innercontent pt-2 pb-5">
            <div class="row">
                <div class="col-md-4">
                    <asp:Image ID="truckimage" runat="server" CssClass="img-fluid" style="width: 400px; height:250px"/>
                </div>
                <div class="col-md-8">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <h5 id="tname" runat="server"></h5>
                                <asp:Label ID="type" runat="server" Text="Model No." style="color: gray;"></asp:Label>
                            </div>
                            <div class="col-md-6">
                                <asp:Label ID="Label1" runat="server" Text="Model No:" style="color: gray;"></asp:Label>
                                <asp:Label ID="mno" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-12">
                                <br/>
                                <div class="table-responsive">
                                    <table class="table table-bordered">
                                        <tr>
                                            <th>
                                                <asp:Label ID="Label2" runat="server" Text="Size" style="color: gray;"></asp:Label>
                                            </th>
                                            <th>
                                                <asp:Label ID="Label3" runat="server" Text="Maximum Weight" style="color: gray;"></asp:Label>
                                            </th>
                                             <th>
                                                <asp:Label ID="Label4" runat="server" Text="Speed" style="color: gray;"></asp:Label>
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="size" runat="server" Text="Size"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="maxwt" runat="server" Text="Maximum Weight"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="speed" runat="server" Text="Speed"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Label ID="Label5" runat="server" Text="₹"></asp:Label> <asp:Label ID="cost" runat="server" Text="Label" style="font-size: 32px;"></asp:Label>/- (Per KM)
                            </div>
                            <div class="col-md-4">
                                <asp:Label ID="Label7" runat="server" Text="Location:" style="color: gray;"></asp:Label>
                                <asp:Label ID="location" runat="server" Text="Label"></asp:Label>
                            </div>
                            <div class="col-md-4">
                                <asp:Label ID="Label9" runat="server" Text="Material:" style="color: gray;"></asp:Label>
                                <asp:Label ID="material" runat="server" Text="Label"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

