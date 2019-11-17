$(document).ready(function () {
    var url = window.location.pathname;
var filename = url.substring(url.lastIndexOf('/')+1);
$('li a[href^="' + filename + '"]').addClass('active');

    var year = new Date();
    year = year.getFullYear();
    $("#year").text(year);

    $(".assign").click(function () {
        $("#driverId").val(this.id);
        PageMethods.viewtruck(this.id, onSucess, onError);
        function onSucess(result) {
            $("#Panel1").html('');
            $("#Panel1").append(result);
            $("#truckdata").modal('show');
        }
        function onError(result) {
            alert('Cannot process your request at the moment, please try later.');
        }
        
        
    });

    var date = $("#ctl00_ContentPlaceHolder1_dob");
    var d = new Date();
    var dt = new Date();
    d.setFullYear(d.getFullYear() - 18);
    dt.setFullYear(dt.getFullYear() - 100);
    if (date != null) {
        $("#ctl00_ContentPlaceHolder1_dob").datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: dt.getFullYear() + ':' + d.getFullYear(),
            dateFormat: "yy/mm/dd",
            defaultDate: d.getFullYear() + '/01/01'
        });
    }
    date = $("#ctl00_ContentPlaceHolder1_pdate");
    if (date != null) {
        $("#ctl00_ContentPlaceHolder1_pdate").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: new Date(),
            dateFormat: "yy/mm/dd",
        });
    }
    $('#ctl00_ContentPlaceHolder1_time').timepicker({
        timeFormat: 'HH:mm',
        interval: 60,
        dynamic: false,
        dropdown: true,
        scrollbar: true,
    });
});

function textbox() {
    $('input[type=text], input[type=password], input[type=email], input[type=url], input[type=tel], input[type=number], input[type=search], input[type=date], input[type=time], textarea').each(function (element, i) {
        if ((element.value !== undefined && element.value.length > 0) || $(this).attr('placeholder') !== null) {
            $(this).siblings('label').addClass('active');
        }
        else {
            $(this).siblings('label').removeClass('active');
        }
    });
}

function preview_image() {
    var total_file = document.getElementById("image").files.length;
    var extensionerror = 0;
    var ext = $("#image")[0].files[0].name;
        ext = ext.replace(/^.*\./, '');
        if (ext.toLowerCase() == "jpg" || ext.toLowerCase() == "png" || ext.toLowerCase() == "jpeg") {
            
        }
        else {
            extensionerror = 1;
        }
    if (extensionerror == 1) {
        document.getElementById("image").value = "";
        alert("You have choosed wrong extension..!!");
    }
    else {
        $("#noimg").attr("src", URL.createObjectURL(event.target.files[0]));
    }
}

function proof() {
    var total_file = document.getElementById("proofimage").files.length;
    var extensionerror = 0;
    var ext = $("#proofimage")[0].files[0].name;
    ext = ext.replace(/^.*\./, '');
    if (ext.toLowerCase() == "jpg" || ext.toLowerCase() == "png" || ext.toLowerCase() == "jpeg") {

    }
    else {
        extensionerror = 1;
    }
    if (extensionerror == 1) {
        document.getElementById("image").value = "";
        alert("You have choosed wrong extension..!!");
    }
    else {
        $("#pimage").attr("src", URL.createObjectURL(event.target.files[0]));
    }
}

function success() {
    swal({
        text: "Successfully Registered, Now you can login..!!",
        type: "success"
    }).then(function () {
        window.location = "index.aspx";
    });
}

function error() {
    swal({
        text: "You have already registered with this Email Id..!!",
        type: "success"
    }).then(function () {
        window.location = "index.aspx";
    });
}

function driverregerror() {
    swal({
        text: "You have already registered with this Email Id..!!",
        type: "success"
    }).then(function () {
        window.location = "ManageDriver.aspx";
    });
}

function loginerror() {
    swal({
        text: "You are not Authorized..!!",
        type: "success"
    }).then(function () {
        window.location = "index.aspx";
    });
}

function truckstatus() {
    swal({
        text: "Disabled Status..!!",
        icon: "success"
    }).then(function () {
        window.location = "ManageTruck.aspx";
    });
}

function truckstatusenable() {
    swal({
        text: "Enabled Status..!!",
        icon: "success"
    }).then(function () {
        window.location = "ManageTruck.aspx";
    });
}

function notupdated() {
    swal({
        text: "Already Booked This Truck..!!",
        icon: "warning"
    }).then(function () {
        window.location = "ManageTruck.aspx";
    });
}

function deletes() {
    swal({
        text: "Already Booked This Driver..!!",
        icon: "warning"
    }).then(function () {
        window.location = "ManageDriver.aspx";
    });
}

function showimg() {
    $("#idproof").modal('show');
}

function checkValidationGroup(valGrp) {
    var rtnVal = true;
    for (i = 0; i < Page_Validators.length; i++) {
        if (Page_Validators[i].validationGroup == valGrp) {
            ValidatorValidate(Page_Validators[i]);
            if (!Page_Validators[i].isvalid) {
                rtnVal = false;
            }
        }
    }
    return rtnVal;
}

function nexttobasic() {
    $("#first").css("pointer-events", "none");
    $("#first").css("opacity", "0.5");
        var source = $("#source").val();
        var destination = $("#destination").val();
        PageMethods.jsonData(source, destination, onSucess, onError);
        function onSucess(result) {
            if (result == "1") {
                $("#first").css("pointer-events", "initial");
                $("#first").css("opacity", "1.0");
                swal("Source Location is invalid");
            }
            else if (result == "0") {
                $("#first").css("pointer-events", "initial");
                $("#first").css("opacity", "1.0");
                swal("Sorry, we are currently not serving intra-country routes.");
            }
            else if (result == "2") {
                $("#first").css("pointer-events", "initial");
                $("#first").css("opacity", "1.0");
                swal("Destination Location is invalid");
            }
            else {
                var obj = $.parseJSON(result);
                //swal(obj[0].duration);
                $("#location").css("display", "none");
                $("#basic").css("display", "initial");
                $("#Image1").attr("src", "assets/img/2.png");
                $("#duringtime").val(obj[0].duration);
                $("#slat").val(obj[0].slat);
                $("#slng").val(obj[0].slng);
                $("#elat").val(obj[0].elat);
                $("#elng").val(obj[0].elng);
                $("#sourceadd").val(obj[0].saddress);
                $("#destinationadd").val(obj[0].eaddress);
                $("#km").text(obj[0].distance);
                $("#duration").text(obj[0].duration);

                var slat = $("#slat").val();
                var slon = $("#slng").val();
                var elat = $("#elat").val();
                var elon = $("#elng").val();
                individual_track1(elat, elon, slat, slon);
            }
            
        }
    function onError(result) {
        $("#first").css("pointer-events", "initial");
        $("#first").css("opacity", "1.0");
            alert('Cannot process your request at the moment, please try later.');
        }
    return false;
}

function backtolocation() {
    $("#first").css("pointer-events", "initial");
    $("#first").css("opacity", "1.0");
    $("#location").css("display", "initial");
    $("#basic").css("display", "none");
    $("#Image1").attr("src", "assets/img/1.png");
}

function nexttofare() {
    $("#second").css("pointer-events", "none");
    $("#second").css("opacity", "0.5");
    var date = $("#ctl00_ContentPlaceHolder1_pdate").val();
    var goods = $("#goods").val();
    $("#tid").val(goods);
        var weight = $("#weight").val();
        var noticetime = $("#duringtime").val();
    var time = $("#ctl00_ContentPlaceHolder1_time").val();
        PageMethods.selecttruck(noticetime, date, time, goods, weight, onSucess, onError);
    function onSucess(result) {
        var obj = $.parseJSON(result);
        if (obj[0].result == "empty" || obj[0].result == "no") {
                $("#basic").css("display", "none");
                $("#fare").css("display", "initial");
            $("#Image1").attr("src", "assets/img/3.png");
            $("#timage").attr("src", obj[0].image);
            $("#tname").text(obj[0].name);
            $("#tmodel").text("(" + obj[0].modelno + ")");
            $("#cost").text("(₹ " + obj[0].cost + " /- per KM)");
            $("#type").text("(" + obj[0].type + ")");
            $("#picupdate").val(obj[0].picupdate);
            $("#enddate").val(obj[0].enddate);
            $("#material").val(obj[0].material);
            $("#rduration").text(obj[0].rduration);
            $("#tweight").val(weight + " Kgs");
            var km = $("#km").text();
            var arr = km.split(" ");
            var filter = arr[0].replace(/,/g, '');
            var price = parseFloat(obj[0].cost) * (parseFloat(filter) + parseFloat(filter));
            $("#tprice").val(price);

            var slat = $("#slat").val();
            var slon = $("#slng").val();
            var elat = $("#elat").val();
            var elon = $("#elng").val();
            individual_track(elat, elon, slat, slon);
            }
        else if (obj[0].result == "yes") {
            $("#second").css("pointer-events", "initial");
            $("#second").css("opacity", "1.0");
                swal("Already Booked..!!");
            }
        else {
            $("#second").css("pointer-events", "initial");
            $("#second").css("opacity", "1.0");
            swal(obj[0].result);
            }
        }
    function onError(result) {
        $("#second").css("pointer-events", "initial");
        $("#second").css("opacity", "1.0");
            alert('Cannot process your request at the moment, please try later.');
        }
    return false;
}

function backtobasic() {
    $("#second").css("pointer-events", "initial");
    $("#second").css("opacity", "1.0");
    $("#basic").css("display", "initial");
    $("#fare").css("display", "none");
    $("#Image1").attr("src", "assets/img/2.png");
}

var map;
function LoadMAP() {
    var LatLng = new google.maps.LatLng(19.156276, 72.875931);
    var mapOptions = {
        center: LatLng,
        zoom: 4,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles: mapstyle()
    };
    map = new google.maps.Map(document.getElementById('map1'), mapOptions);
}
function tracking() {
    var start = $("#slatlong").val();
    var end = $("#elatlong").val();
    if (start != "" && end != "") {
        var arr = start.split(',');
        var arr1 = end.split(',');
        var poly;
        var map;
        var cmloc = new google.maps.LatLng($.trim(arr1[0]), $.trim(arr1[1]));
        var myOptions = {
            center: cmloc,
            zoom: 12,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            styles: mapstyle()
        };
        map = new google.maps.Map(document.getElementById('map'), myOptions);
        var polyOptions = {
            strokeColor: 'dark blue',
            strokeOpacity: 0.5,
            strokeWeight: 5
        }
        poly = new google.maps.Polyline(polyOptions);
        poly.setMap(map);
        var simg = 'http://maps.google.com/mapfiles/ms/icons/green-dot.png';
        var eimg = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png';
        var img = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
        var path = poly.getPath();
        var j = 0;
        path.push(new google.maps.LatLng($.trim(arr1[0]), $.trim(arr1[1])));
        var marker_end = new google.maps.Marker({
            position: new google.maps.LatLng($.trim(arr1[0]), $.trim(arr1[1])),
            title: 'Current Location',
            icon: simg,
            map: map
        });
    }
}
function map() {
    if (document.getElementById('map1') != null) {
        LoadMAP();
    }
    else if (document.getElementById('map') != null) {
        tracking();
    }
}
google.maps.event.addDomListener(window, 'load', map);

function individual_track(elat, elon, slat, slon) {
        var poly;
        var map;
        var cmloc = new google.maps.LatLng(elat, elon);
        var myOptions = {
            center: cmloc,
            zoom: 5,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            styles: mapstyle()
        };
        map = new google.maps.Map(document.getElementById('map3'), myOptions);
        var polyOptions = {
            strokeColor: 'dark blue',
            strokeOpacity: 0.5,
            strokeWeight: 5
        }
        poly = new google.maps.Polyline(polyOptions);
        poly.setMap(map);
        var simg = 'http://maps.google.com/mapfiles/ms/icons/green-dot.png';
        var eimg = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png';
        var img = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
        var path = poly.getPath();
        path.push(new google.maps.LatLng(slat, slon));
        var marker_start = new google.maps.Marker({
            position: new google.maps.LatLng(slat, slon),
            title: 'Start Point',
            icon: simg,
            map: map,
        });
        var j = 0;
        path.push(new google.maps.LatLng(elat, elon));
        var marker_end = new google.maps.Marker({
            position: new google.maps.LatLng(elat, elon),
            title: 'End Point',
            icon: img,
            map: map
        });
}
function individual_track1(elat, elon, slat, slon) {
    var poly;
    var map;
    var cmloc = new google.maps.LatLng(elat, elon);
    var myOptions = {
        center: cmloc,
        zoom: 5,
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        styles: mapstyle()
    };
    map = new google.maps.Map(document.getElementById('map2'), myOptions);
    var polyOptions = {
        strokeColor: 'dark blue',
        strokeOpacity: 0.5,
        strokeWeight: 5
    }
    poly = new google.maps.Polyline(polyOptions);
    poly.setMap(map);
    var simg = 'http://maps.google.com/mapfiles/ms/icons/green-dot.png';
    var eimg = 'http://maps.google.com/mapfiles/ms/icons/blue-dot.png';
    var img = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
    var path = poly.getPath();
    path.push(new google.maps.LatLng(slat, slon));
    var marker_start = new google.maps.Marker({
        position: new google.maps.LatLng(slat, slon),
        title: 'Start Point',
        icon: simg,
        map: map,
    });
    var j = 0;
    path.push(new google.maps.LatLng(elat, elon));
    var marker_end = new google.maps.Marker({
        position: new google.maps.LatLng(elat, elon),
        title: 'End Point',
        icon: img,
        map: map
    });
}

function mapstyle() {
    var style =
        [
            {
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#ebe3cd"
                    }
                ]
            },
            {
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#523735"
                    }
                ]
            },
            {
                "elementType": "labels.text.stroke",
                "stylers": [
                    {
                        "color": "#f5f1e6"
                    }
                ]
            },
            {
                "featureType": "administrative",
                "elementType": "geometry.stroke",
                "stylers": [
                    {
                        "color": "#c9b2a6"
                    }
                ]
            },
            {
                "featureType": "administrative.land_parcel",
                "elementType": "geometry.stroke",
                "stylers": [
                    {
                        "color": "#dcd2be"
                    }
                ]
            },
            {
                "featureType": "administrative.land_parcel",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#ae9e90"
                    }
                ]
            },
            {
                "featureType": "landscape.natural",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#dfd2ae"
                    }
                ]
            },
            {
                "featureType": "poi",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#dfd2ae"
                    }
                ]
            },
            {
                "featureType": "poi",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#93817c"
                    }
                ]
            },
            {
                "featureType": "poi.park",
                "elementType": "geometry.fill",
                "stylers": [
                    {
                        "color": "#a5b076"
                    }
                ]
            },
            {
                "featureType": "poi.park",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#447530"
                    }
                ]
            },
            {
                "featureType": "road",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#f5f1e6"
                    }
                ]
            },
            {
                "featureType": "road.arterial",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#fdfcf8"
                    }
                ]
            },
            {
                "featureType": "road.highway",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#f8c967"
                    }
                ]
            },
            {
                "featureType": "road.highway",
                "elementType": "geometry.stroke",
                "stylers": [
                    {
                        "color": "#e9bc62"
                    }
                ]
            },
            {
                "featureType": "road.highway.controlled_access",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#e98d58"
                    }
                ]
            },
            {
                "featureType": "road.highway.controlled_access",
                "elementType": "geometry.stroke",
                "stylers": [
                    {
                        "color": "#db8555"
                    }
                ]
            },
            {
                "featureType": "road.local",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#806b63"
                    }
                ]
            },
            {
                "featureType": "transit.line",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#dfd2ae"
                    }
                ]
            },
            {
                "featureType": "transit.line",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#8f7d77"
                    }
                ]
            },
            {
                "featureType": "transit.line",
                "elementType": "labels.text.stroke",
                "stylers": [
                    {
                        "color": "#ebe3cd"
                    }
                ]
            },
            {
                "featureType": "transit.station",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#dfd2ae"
                    }
                ]
            },
            {
                "featureType": "water",
                "elementType": "geometry.fill",
                "stylers": [
                    {
                        "color": "#b9d3c2"
                    }
                ]
            },
            {
                "featureType": "water",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#92998d"
                    }
                ]
            }
        ]
    return style;
}


// Fill data into delete Modal popup
function GetSelectedRow(me) {
    var data = document.getElementById("GridView1");

    var row = me.parentNode.parentNode;
    var rowIndex = row.rowIndex - 1;
    var ID = row.cells[0].innerText;
    //var type = row.cells[7].innerText;
    swal({
        title: "Are you sure?",
        text: "You won't be able to revert this!",
        icon: "warning",
        dangerMode: true,
        buttons: {
            cancel: {
                text: "Cancel",
                value: null,
                visible: true,
                className: "btn btn-danger",
                closeModal: true,
            },
            confirm: {
                text: "Yes, Cancelled it!",
                value: true,
                visible: true,
                className: "btn btn-success",
                closeModal: true
            }
        }
    })
        .then((willDelete) => {
            if (willDelete) {
                PageMethods.cancel(ID, onSucess, onError);
                function onSucess(result) {
                    window.location.href = 'UserBooking.aspx';
                }
                function onError(result) {
                    alert('Cannot process your request at the moment, please try later.');
                }
            }
        });
}