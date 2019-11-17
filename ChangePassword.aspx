<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server"></asp:ScriptManagerProxy>
    <div class="container" style="margin-top: 6%;">
        <div class="innercontent pt-2 pb-5">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="modal-dialog cascading-modal" role="document">
                        <div class="modal-content">
                            <div class="modal-header primary-color white-text">
                                <h4 class="title">
                                    <i class="fas fa-pencil-alt"></i>Change Password</h4>
                            </div>
                            <div class="modal-body">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cpassword" EventName="TextChanged" />
                                    </Triggers>
                                    <ContentTemplate>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-lock prefix"></i>
                                            <asp:TextBox ID="cpassword" runat="server" CssClass="form-control form-control-sm" OnTextChanged="cpassword_TextChanged" AutoPostBack="true" type="password"></asp:TextBox>
                                            <label for="cpassword">Current Password</label>
                                        </div>
                                        <asp:Label ID="cpasserror" runat="server" Text="* Current Password is Invalid" Visible="false" ForeColor="red"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Kindly Enter Current Password" ControlToValidate="cpassword" Display="Dynamic" ValidationGroup="password"></asp:RequiredFieldValidator>

                                        <div class="md-form form-sm">
                                            <i class="fas fa-lock prefix"></i>
                                            <asp:TextBox ID="npassword" runat="server" CssClass="form-control form-control-sm" type="password"></asp:TextBox>
                                            <label for="npassword">New Password</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Kindly Enter New Password" ControlToValidate="npassword" Display="Dynamic" ValidationGroup="password"></asp:RequiredFieldValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-tag prefix"></i>
                                            <asp:TextBox ID="copassword" runat="server" CssClass="form-control form-control-sm" type="password" OnTextChanged="copassword_TextChanged" AutoPostBack="true"></asp:TextBox>
                                            <label for="copassword">Confirm Password</label>
                                        </div>
                                        <asp:Label ID="copasserror" runat="server" Text="* New and Confirm are different" Visible="false" ForeColor="red"></asp:Label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Kindly Enter Confirmed Password" ControlToValidate="copassword" Display="Dynamic" ValidationGroup="password"></asp:RequiredFieldValidator>
                                        <div class="text-center mt-4 mb-2">
                                    <asp:Button ID="Submit" runat="server" Text="Submit" CssClass="btn btn-primary waves-effect waves-light" ValidationGroup="password" OnClick="Submit_Click" Visible="False" />
                                </div>
                                    </ContentTemplate>

                                </asp:UpdatePanel>
                                
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                </div>
            </div>
        </div>
    </div>
</asp:Content>

