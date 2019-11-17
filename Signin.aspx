<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Signin.aspx.cs" Inherits="Signin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="homemain" style="height: 600px;">
    </div>
    <div class ="container about text-center" style="background-color: white;padding: 2%;padding-top:3%">
        <a class="nav-link btn btn-info" href="#" data-toggle="modal" data-target="#modalForm">Admin Sign-in</a>
         <a class="nav-link btn btn-info" href="#" data-toggle="modal" data-target="#modalLRForm">User Sign-in</a>
    </div>
         <%-- Admin --%>
            <div class="modal fade" id="modalForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header text-center">
                            <h4 class="modal-title w-100 font-weight-bold">Admin Sign in</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body mx-3">
                            <div class="md-form mb-5">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <asp:TextBox ID="adminid" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="adminid">Admin Id</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="* Kindly Enter Id" ControlToValidate="adminid" Display="Dynamic" ValidationGroup="admin"></asp:RequiredFieldValidator>
                            <div class="md-form mb-4">
                                <i class="fas fa-lock prefix grey-text"></i>
                                <asp:TextBox ID="adminpass" type="password" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="adminpass">Password</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="* Kindly Enter Password" ControlToValidate="adminpass" Display="Dynamic" ValidationGroup="admin"></asp:RequiredFieldValidator>
                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <asp:Button ID="adminLogin" ValidationGroup="admin" runat="server" Text="Sign In" CssClass="btn btn-info" OnClick="adminLogin_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <%-- User Forms --%>
            <div class="modal fade" id="modalLRForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog cascading-modal mt-5" role="document">
                    <div class="modal-content">
                        <div class="modal-c-tabs">
                            <ul class="nav nav-tabs md-tabs tabs-2 light-blue darken-3 loginType" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#panel7" role="tab"><i class="fas fa-user mr-1"></i>
                                        Login</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#panel8" role="tab"><i class="fas fa-user-plus mr-1"></i>
                                        Register</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <%-- Login --%>
                                <div class="tab-pane fade in show active" id="panel7" role="tabpanel">
                                    <div class="modal-body mb-1">
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-envelope prefix"></i>
                                            <asp:TextBox ID="lemail" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                            <label for="lemail">Email Id</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="* Kindly Enter Email Id" ControlToValidate="lemail" ValidationGroup="login" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="* Kindly Enter Valid Email Id" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" ControlToValidate="lemail" ValidationGroup="login" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-lock prefix"></i>
                                            <asp:TextBox ID="lpass" runat="server" CssClass="form-control form-control-sm" type="password"></asp:TextBox>
                                            <label for="lpass">Password</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="* Kindly Enter Password" ControlToValidate="lpass" ValidationGroup="login" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="text-center mt-2">
                                            <asp:Button ID="login" ValidationGroup="login" runat="server" Text="Sign In" CssClass="btn btn-info" OnClick="login_Click" />
                                            <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                                <%-- Registration --%>
                                <div class="tab-pane fade" id="panel8" role="tabpanel">
                                    <div class="modal-body">
                                        <div class="md-form form-sm mb-0 mt-0">
                                            <asp:Image ID="noimg" runat="server" ImageUrl="assets/img/avatar.jpg" CssClass="avtar" ClientIDMode="Static" />
                                            <asp:FileUpload ID="image" runat="server" onchange="preview_image();" ClientIDMode="Static" />
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Kindly Choose Image" ControlToValidate="image" ValidationGroup="register" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-user prefix"></i>
                                            <asp:TextBox ID="name" runat="server" class="form-control form-control-sm"></asp:TextBox>
                                            <label for="name">Name</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Kindly Enter Name" ControlToValidate="name" ValidationGroup="register" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-phone prefix"></i>
                                            <asp:TextBox ID="contact" runat="server" class="form-control form-control-sm"></asp:TextBox>
                                            <label for="contact">Contact</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Kindly Enter Contact Number" ControlToValidate="contact" ValidationGroup="register" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="* Kindly Enter Valid Contact Number" ValidationExpression="^[6789][0-9]{9}$" ControlToValidate="contact" ValidationGroup="register" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-envelope prefix"></i>
                                            <asp:TextBox ID="email" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                            <label for="email">Email</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Kindly Enter Email Id" ControlToValidate="email" ValidationGroup="register" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="* Kindly Enter Valid Email Id" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" ControlToValidate="email" ValidationGroup="register" Display="Dynamic"></asp:RegularExpressionValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-map-marked-alt prefix"></i>
                                            <asp:TextBox type="number" min="20" ID="age" runat="server" class="form-control form-control-sm"></asp:TextBox>
                                            <label for="age">Age</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="* Kindly Enter Age" ControlToValidate="age" ValidationGroup="register" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-pencil-alt prefix"></i>
                                            <textarea id="address" cols="20" rows="1" runat="server" class="form-control form-control-sm md-textarea"></textarea>
                                            <label for="address">Address</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Kindly Enter Address" ControlToValidate="address" ValidationGroup="register" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-map-marked-alt prefix"></i>
                                            <asp:TextBox ID="city" runat="server" class="form-control form-control-sm"></asp:TextBox>
                                            <label for="city">City</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Kindly Enter City" ControlToValidate="city" ValidationGroup="register" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="md-form form-sm mb-0">
                                            <i class="fas fa-lock prefix"></i>
                                            <asp:TextBox ID="password" runat="server" type="password" CssClass="form-control form-control-sm"></asp:TextBox>
                                            <label for="password">Password</label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Kindly Enter Password" ControlToValidate="password" ValidationGroup="register" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <div class="text-center form-sm mt-2">
                                            <asp:Button ID="signup" runat="server" Text="Sign Up" CssClass="btn btn-info" ValidationGroup="register" OnClick="signup_Click" />
                                            <button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
   
</asp:Content>

