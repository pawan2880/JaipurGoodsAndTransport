<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ManageTruck.aspx.cs" Inherits="ManageTruck" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="modal fade" id="AddTruck" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <h4 class="modal-title w-100 font-weight-bold">Enter Truck Details</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body mx-3">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="name" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="name">Truck Name</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="* Kindly Enter Truck Name" ControlToValidate="name" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="modelno" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="modelno">Model number</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="* Kindly Enter Model Number" ControlToValidate="modelno" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="type" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="type">Type</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="* Kindly Enter Type" ControlToValidate="type" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="size" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="size">Size</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="* Kindly Enter Size" ControlToValidate="size" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="maxwt" runat="server" CssClass="form-control" min="200" type="number"></asp:TextBox>
                                <label for="maxwt">Maximum Weight</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="* Kindly Enter Maximum Weight" ControlToValidate="maxwt" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="speed" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="speed">Speed</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="* Kindly Enter Speed" ControlToValidate="speed" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="material" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="material">Material</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="* Kindly Enter Material" ControlToValidate="material" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="location" runat="server" CssClass="form-control"></asp:TextBox>
                                <label for="location">Location</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="* Kindly Enter Location" ControlToValidate="location" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <asp:Image ID="noimg" runat="server" ImageUrl="assets/img/avatar.jpg" CssClass="avtar" ClientIDMode="Static" />
                            <asp:FileUpload ID="image" runat="server" onchange="preview_image();" ClientIDMode="Static" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="* Kindly Select Image" ControlToValidate="image" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
                        </div>
                        <div class="col-md-6">
                            <div class="md-form mb-0">
                                <asp:TextBox ID="cost" runat="server" CssClass="form-control" type="number" min="0"></asp:TextBox>
                                <label for="cost">Cost(Per KM)</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="* Kindly Enter Cost" ControlToValidate="cost" Display="Dynamic" ValidationGroup="truck"></asp:RequiredFieldValidator>
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
            <asp:Label ID="Label1" runat="server" Text="Manage Truck Details"></asp:Label>
            <hr/>
            <br/>
            <div class="text-right">
                <asp:Button ID="Button1" runat="server" Text="Add" data-toggle="modal" data-target="#AddTruck" type="button" OnClientClick="return false;" CssClass="btn btn-info" />
            </div>
            <asp:Panel ID="Panel2" runat="server" CssClass="text-center">
                <h5 style="color: gray;">No Result Found..!!</h5>
            </asp:Panel>
            <div class="table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="tid" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit"  OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating" CellPadding="4" ForeColor="#333333" GridLines="Horizontal" Style="width: 100%" EmptyDataText="No data available." AllowPaging="True" AllowSorting="True" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField HeaderText="Tid" DataField="tid" HeaderStyle-CssClass="display" ItemStyle-CssClass="display" />
                        <asp:BoundField HeaderText="Name" DataField="name" />
                        <asp:BoundField HeaderText="Model Number" DataField="mno" />
                        <asp:BoundField HeaderText="Type" DataField="type" />
                        <asp:BoundField HeaderText="Size" DataField="size" />
                        <asp:BoundField HeaderText="Max Wt" DataField="maxwt" />
                        <asp:BoundField HeaderText="Speed" DataField="speed" />
                        <asp:BoundField HeaderText="Material" DataField="material" />
                        <asp:BoundField HeaderText="Location" DataField="location" />
                         <asp:BoundField HeaderText="Cost" DataField="cost" />
                        <asp:BoundField HeaderText="Status" DataField="status" HeaderStyle-CssClass="display" ItemStyle-CssClass="display"/>
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
                        <asp:CommandField ButtonType="Image" CancelImageUrl="assets/img/cancel.png" EditImageUrl="assets/img/icons8-edit-26.png" ShowEditButton="True" UpdateImageUrl="assets/img/update.png" ItemStyle-CssClass="s" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="disable" runat="server" CommandArgument='<%# Eval("tid") %>' CommandName="disable">
                                    <i class="fa fa-minus-circle fa-2x"></i>
                                </asp:LinkButton>
                                 <asp:LinkButton ID="enable" runat="server" CommandArgument='<%# Eval("tid") %>' CommandName="enable">
                                    <i class="fa fa-arrow-circle-down fa-2x"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

