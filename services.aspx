<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="services.aspx.cs" Inherits="services" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="homemain">
        <img src="assets/img/main.jpg" style="height: 600px; width: 100%">
    </div>
    <div class ="container about" style="background-color: white;padding: 2%;padding-top:3%">
        <div class="row">
            <div class="col-md-2">
                <h5>Services</h5>
                <table class="table">
                    <tr><td>Transportation</td></tr>
                    <tr><td>Road Transport</td></tr>
                    <tr><td>Fully Truck Overloaded</td></tr>
                </table>
            </div>
            <div class="col-md-10">
                <h5 class="text-center">Services</h5>
                <hr style="width: 20%;margin-top: 0.5rem;border-top: 5px solid #3F51B5;border-radius: 5px;"/>
                <p style="text-align: justify;color: gray;">Jaipur goods and transport is a leading provider of specialized services in integrated multi-mode solutions for the transportation of bulk and container cargo. Jaipur Golden provides a single window for businesses that seek seamless transportation, warehousing, supply chain management and trucking.</p>
                <br/>
                <div class="container">
                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-3 shadow-lg p-4 mb-5 bg-white rounded text-center" style="color: gray;">
                        <i class="fa fa-truck" style="font-size:36px;"></i>
                        <br/> <br/>
                        Tranportation
                    </div>
                    <div class="col-md-1"></div> 
                   <div class="col-md-3 shadow-lg p-4 mb-5 bg-white rounded text-center" style="color: gray;">
                        <i class="fa fa-truck" style="font-size:36px;"></i>
                        <br/> <br/>
                        Road Transport
                    </div>
                    <div class="col-md-1"></div>
                    <div class="col-md-3 shadow-lg p-4 mb-5 bg-white rounded text-center" style="color: gray;">
                        <i class="fa fa-truck" style="font-size:36px;"></i>
                        <br/> <br/>
                        Fully Truck Overloaded
                    </div>
                </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

