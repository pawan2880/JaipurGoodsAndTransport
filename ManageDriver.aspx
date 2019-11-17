<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageDriver.aspx.cs" Inherits="ManageDriver" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <!-- Id Proof Image -->
    <div class="modal fade" id="idproof" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:Image ID="primg" runat="server" Width="100%" CssClass="img-fluid" />
                </div>
            </div>
        </div>
    </div>
    <%-- Truck Details --%>
    <!-- Modal -->
    <div class="modal fade" id="truckdata" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Truck Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:TextBox ID="driverId" runat="server" ClientIDMode="Static" style="display: none;"></asp:TextBox>
                    <asp:Panel ID="Panel1" runat="server" ClientIDMode="Static"></asp:Panel>
                    <div style="margin-top: 1.5rem;">
                        <label for="truckname">Choose Truck Name</label>
                        <asp:DropDownList ID="utruck" runat="server" CssClass="form-control">
                            <asp:ListItem disabled Selected>--Choose Truck--</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="* Kindly Choose Truck Name" ControlToValidate="utruck" Display="Dynamic" ValidationGroup="update" InitialValue="--Choose Truck--"></asp:RequiredFieldValidator>
                    <br/>
                    <asp:Button ID="truckupdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="truckupdate_Click" ValidationGroup="update" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="AddDriver" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Enter Driver Details</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="name" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="name">Name</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Kindly Enter Driver Name" ControlToValidate="name" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="email" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="email">Email Id</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Kindly Enter Email Id" ControlToValidate="email" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="* Kindly Enter Valid Email Id" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$" ControlToValidate="email" ValidationGroup="truck" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="contact" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="contact">Contact Number</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Kindly Enter Contact Number" ControlToValidate="contact" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="* Kindly Enter Valid Contact Number" ValidationExpression="^[6789][0-9]{9}$" ControlToValidate="contact" ValidationGroup="register" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <input id="dob" type="text" class="form-control" runat="server" readonly="readonly"/>
                               <%-- <asp:TextBox ID="dob" runat="server" CssClass="form-control" ClientIDMode="Static" Enabled="false"></asp:TextBox>--%>
                                <label for="dob">Date Of Birth</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Kindly Enter Date Of Birth" ControlToValidate="dob" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div style="margin-top: 1.5rem;">
                                <label for="truckname">Choose Truck Name</label>
                                <asp:DropDownList ID="truckname" runat="server" CssClass="form-control">
                                    <asp:ListItem disabled Selected>--Choose Truck--</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Kindly Choose Truck Name" ControlToValidate="truckname" Display="Dynamic" ValidationGroup="truck" InitialValue="--Choose Truck--"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <textarea id="address" cols="20" rows="1" runat="server" class="form-control form-control-sm md-textarea"></textarea>
                                <label for="address">Address</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="* Kindly Enter Address" ControlToValidate="address" ValidationGroup="truck" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="location" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="location">City</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="* Kindly Enter Location" ControlToValidate="location" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="password" type="password" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="password">Password</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Kindly Enter Password" ControlToValidate="password" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>

                        <div class="col-md-6" style="margin-top: 1.5rem;">
                            <asp:Label ID="Label1" runat="server" Text="Your Profile Picture"></asp:Label>
                            <br />
                            <asp:Image ID="noimg" runat="server" ImageUrl="assets/img/avatar.jpg" CssClass="avtar" ClientIDMode="Static" />
                            <asp:FileUpload ID="image" runat="server" onchange="preview_image();" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="* Kindly Select Image" ControlToValidate="image" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6" style="margin-top: 1.5rem;">
                            <asp:Label ID="Label2" runat="server" Text="Your Id Proof"></asp:Label>
                            <br />
                            <asp:Image ID="pimage" runat="server" ImageUrl="assets/img/avatar.jpg" CssClass="avtar" ClientIDMode="Static" />
                            <asp:FileUpload ID="proofimage" runat="server" onchange="proof();" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Kindly Upload Proof" ControlToValidate="proofimage" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <asp:Button ID="Submit" ValidationGroup="truck" runat="server" Text="Submit" CssClass="btn btn-info" OnClick="Submit_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid maincontent">
        <div class="innercontent pt-2 pb-5">
            <asp:Label ID="Label3" runat="server" Text="Manage Driver Details"></asp:Label>
            <hr/>
            <br/>
            <div class="text-right">
                <asp:Button ID="Button1" runat="server" Text="Add" data-toggle="modal" data-target="#AddDriver" type="button" OnClientClick="return false;" CssClass="btn btn-info" />
            </div>
            <asp:Panel ID="Panel2" runat="server" CssClass="text-center">
                <h5 style="color: gray;">No Result Found..!!</h5>
            </asp:Panel>
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="did" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" CellPadding="4" ForeColor="#333333" GridLines="Horizontal" Style="width: 100%" EmptyDataText="No data available." AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" OnRowDeleting="GridView1_RowDeleting" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        
                        <asp:BoundField HeaderText="Did" DataField="did" HeaderStyle-CssClass="display" ItemStyle-CssClass="display" />
                        <asp:TemplateField HeaderText="Picture">
                        <ItemTemplate>
                            <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("eid") %>' CssClass="img-fluid" style="width: 100px;
    height: 100px; border-radius: 50px;"/>
                        </ItemTemplate>
                    </asp:TemplateField>
                        <asp:BoundField HeaderText="Name" DataField="name" />
                        <asp:BoundField HeaderText="Email" DataField="email" />
                        <asp:BoundField HeaderText="Contact" DataField="contact" />
                        <asp:BoundField HeaderText="Date Of Birth" DataField="dob" />
                        <asp:BoundField HeaderText="Status" DataField="status" HeaderStyle-CssClass="display" ItemStyle-CssClass="display" />
                        <asp:BoundField HeaderText="Address" DataField="address" />
                        <asp:BoundField HeaderText="City" DataField="city" />
                        <asp:BoundField HeaderText="Truck Details" DataField="tname" HtmlEncode="false" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" />
                        <asp:BoundField HeaderText="Proof" DataField="proof" HeaderStyle-CssClass="display" ItemStyle-CssClass="display" />
                    </Columns>
                    <EditRowStyle BackColor="#e8e8e3" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" CssClass="tablepadding" />
                    <PagerStyle BackColor="#284775" ForeColor="White" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" CssClass="tablepadding" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    <Columns>
                        <asp:CommandField HeaderText="Id Proof" ShowSelectButton="true" SelectText="View" ItemStyle-ForeColor="blue" ItemStyle-CssClass="link" />
                        <asp:CommandField ButtonType="Image" CancelImageUrl="assets/img/cancel.png" EditImageUrl="assets/img/icons8-edit-26.png" ShowEditButton="True" UpdateImageUrl="assets/img/update.png" ItemStyle-CssClass="s" />
                        <asp:CommandField ButtonType="Image" DeleteImageUrl="assets/img/icons8-trash-26.png" ShowDeleteButton="True" />
                        <%--                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="disable" runat="server" CommandArgument='<%# Eval("tid") %>' CommandName="disable">
                                    <i class="fa fa-minus-circle fa-2x"></i>
                                </asp:LinkButton>
                                 <asp:LinkButton ID="enable" runat="server" CommandArgument='<%# Eval("tid") %>' CommandName="enable">
                                    <i class="fa fa-arrow-circle-down fa-2x"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

