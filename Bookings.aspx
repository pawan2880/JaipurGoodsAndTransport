<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Bookings.aspx.cs" Inherits="Bookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
    <div class="container" style="margin-top: 6%;margin-bottom: 6%;">
        <div class="innercontent pt-2 pb-5 shadow-lg p-3 bg-white booking">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
                <ContentTemplate>
                    <div class="container">
                        <div class="row">
                            <div class="col-md-4">
                                <asp:Image ID="Image1" runat="server" ImageUrl="assets/img/1.png" Width="100%" CssClass="img-fluid" ClientIDMode="Static" />
                            </div>
                        </div>
                    </div>

                    <%-- Location Details --%>
                    <asp:Panel ID="location" runat="server" ClientIDMode="Static">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="input-group my-3 input-group-md">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-transparent" style="border-right: none;"><i class='fas fa-map-marker-alt' style='font-size: 24px; color: #8080809c;'></i></span>
                                        </div>
                                        <asp:TextBox ID="source" runat="server" Style="border-left: none; color: #8080809c;" placeholder="Source" CssClass="form-control" ClientIDMode="Static"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Kindly Enter Source " Display="Dynamic" ValidationGroup="location" ControlToValidate="source"></asp:RequiredFieldValidator>
                                    <div class="input-group my-3 input-group-md">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-transparent" style="border-right: none;"><i class='fas fa-map-marker-alt' style='font-size: 24px; color: #8080809c;'></i></span>
                                        </div>
                                        <asp:TextBox ID="destination" ClientIDMode="Static" runat="server" Style="border-left: none; color: #8080809c;" placeholder="Destination" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Kindly Enter Destination" Display="Dynamic" ValidationGroup="location" ControlToValidate="destination"></asp:RequiredFieldValidator>
                                    <br />
                                    <div class="text-right">
                                        <asp:Button ID="first" runat="server" Text="Next" OnClientClick="if(checkValidationGroup('location')) nexttobasic(); return false;" ValidationGroup="location" CssClass="btn btn-primary" ClientIDMode="Static" />
                                    </div>
                                </div>
                               <div class="col-md-8">
                                    <div id="map1" class="iframe-container" style="border-radius: 7px; height: 420px"></div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <%-- Basic Details --%>
                    <asp:Panel ID="basic" runat="server" Style="display: none;" ClientIDMode="Static">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-4">
                                    <asp:TextBox ID="duringtime" runat="server" ClientIDMode="Static" Style="display: none;"></asp:TextBox>
                                    <div class="input-group my-3 input-group-md">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-transparent" style="border-right: none;"><i class='fas fa-calendar' style='font-size: 24px; color: #8080809c;'></i></span>
                                        </div>
                                        <input id="pdate" type="text" class="form-control" runat="server" style="border-left: none; color: #8080809c;" readonly="readonly" placeholder="Select PickUp Date"/>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Kindly Choose PickUp Date" Display="Dynamic" ValidationGroup="basic" ControlToValidate="pdate"></asp:RequiredFieldValidator>
                                    <div class="input-group my-3 input-group-md">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-transparent" style="border-right: none;"><i class='fas fa-calendar' style='font-size: 24px; color: #8080809c;'></i></span>
                                        </div>
                                        <input id="time" type="text" class="form-control" runat="server" style="border-left: none; color: #8080809c;" readonly="readonly" placeholder="PickUp Time"/>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Kindly Choose PickUp Time" Display="Dynamic" ValidationGroup="basic" ControlToValidate="time"></asp:RequiredFieldValidator>
                                    <div class="input-group my-3 input-group-md">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-transparent" style="border-right: none;"><i class='fas fa-truck' style='font-size: 24px; color: #8080809c;'></i></span>
                                        </div>
                                        <asp:DropDownList ID="goods" runat="server" CssClass="form-control" ClientIDMode="Static" Style="border-left: none; color: #8080809c;">
                                            <asp:ListItem Selected disabled>--Goods Type--</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Kindly Choose Goods Type" Display="Dynamic" ValidationGroup="basic" ControlToValidate="goods" InitialValue="--Goods Type--"></asp:RequiredFieldValidator>
                                    <div class="input-group my-3 input-group-md">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-transparent" style="border-right: none;"><i class='fas fa-sort-amount-up' style='font-size: 24px; color: #8080809c;'></i></span>
                                        </div>
                                        <asp:TextBox ID="weight" runat="server" Style="border-left: none; color: #8080809c;" placeholder="Total Weight(In KG)" CssClass="form-control" ClientIDMode="Static" type="number"></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Kindly Enter Weight" Display="Dynamic" ValidationGroup="basic" ControlToValidate="weight"></asp:RequiredFieldValidator>
                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="* Minimum Weight should be 100 Kgs" Display="Dynamic" ValidationGroup="basic" ControlToValidate="weight" MinimumValue="100" MaximumValue="10000" Type="Integer"></asp:RangeValidator>
                                    <div class="text-right">
                                        <asp:Button ID="second" runat="server" Text="Next" OnClientClick="if(checkValidationGroup('basic')) nexttofare(); return false;" ValidationGroup="basic" CssClass="btn btn-primary" ClientIDMode="Static" />
                                        <asp:Button ID="ltoBack" runat="server" Text="Back" OnClientClick="backtolocation(); return false;" CssClass="btn btn-warning" />
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div id="map2" class="iframe-container" style="border-radius: 7px; height: 420px"></div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <%-- Total Fare --%>
                    <asp:Panel ID="fare" runat="server" Style="display: none;" ClientIDMode="Static">
                        <asp:TextBox ID="tid" runat="server" Enabled="false" style="border: none;  background-color: transparent;display: none;" ClientIDMode="Static"></asp:TextBox>
                        <asp:TextBox ID="slat" runat="server" ClientIDMode="Static" Style="display: none;"></asp:TextBox>
                        <asp:TextBox ID="slng" runat="server" ClientIDMode="Static" Style="display: none;"></asp:TextBox>
                        <asp:TextBox ID="elat" runat="server" ClientIDMode="Static" Style="display: none;"></asp:TextBox>
                        <asp:TextBox ID="elng" runat="server" ClientIDMode="Static" Style="display: none;"></asp:TextBox>
                        <div class="container my-3">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <asp:Image ID="timage" runat="server" ClientIDMode="Static" CssClass="img-fluid"/>
                                        </div>
                                        <div class="col-md-6">
                                            <h3 id="tname"></h3>
                                            <asp:Label ID="tmodel" runat="server" Text="Label" ClientIDMode="Static" style="color: gray;"></asp:Label>
                                            <br/>
                                            <asp:Label ID="type" runat="server" Text="Label" ClientIDMode="Static" style="color: gray;"></asp:Label>
                                            <br/>
                                            <asp:Label ID="cost" runat="server" Text="Label" ClientIDMode="Static" style="color: gray;"></asp:Label>
                                        </div>
                                        <div class="col-md-12">
                                            
                                            <br/>
                                        </div>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table">
                                            <tr>
                                                <td>
                                                    <span style="color: gray;">Material: </span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="material" runat="server" Enabled="false" style="border: none;  background-color: transparent;" ClientIDMode="Static"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                  <span style="color: gray;">  Weight: </span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tweight" runat="server" Enabled="false" style="border: none;  background-color: transparent;" ClientIDMode="Static"></asp:TextBox>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td>
                                                  <span style="color: gray;">  Source: </span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="sourceadd" runat="server" Enabled="false" style="border: none;  background-color: transparent;" ClientIDMode="Static"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                  <span style="color: gray;">  Destination: </span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="destinationadd" runat="server" Enabled="false" style="border: none;  background-color: transparent;" ClientIDMode="Static"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                   <span style="color: gray;"> Total KM: </span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="km" runat="server" Text="Label" ClientIDMode="Static"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                  <span style="color: gray;">  Duration: </span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="duration" runat="server" Text="Label" ClientIDMode="Static"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                  <span style="color: gray;"> Round Trip Duration: </span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="rduration" runat="server" Text="Label" ClientIDMode="Static"></asp:Label>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td>
                                                   <span style="color: gray;"> Pickup Date: </span>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="picupdate" runat="server" Enabled="false" style="border: none;  background-color: transparent;" ClientIDMode="Static"></asp:TextBox>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td>
                                                   <span style="color: gray;"> End Date: </span>
                                                </td>
                                                <td>
                                                     <asp:TextBox ID="enddate" runat="server" Enabled="false" style="border: none;  background-color: transparent;" ClientIDMode="Static"></asp:TextBox>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td>
                                                  <span style="color: gray;">  Total Price: </span>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label1" runat="server" Text="₹ " ClientIDMode="Static"></asp:Label>
                                                    <asp:TextBox ID="tprice" runat="server" Enabled="false" style="border: none;  background-color: transparent;" ClientIDMode="Static"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="text-right">
                                        <asp:Button ID="Booked" runat="server" Text="Booked" CssClass="btn btn-primary" OnClick="Booked_Click"/>
                                         <asp:Button ID="btoback" runat="server" Text="Back" OnClientClick="backtobasic(); return false;" CssClass="btn btn-warning" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div id="map3" class="iframe-container" style="border-radius: 7px; height: 420px"></div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

</asp:Content>

