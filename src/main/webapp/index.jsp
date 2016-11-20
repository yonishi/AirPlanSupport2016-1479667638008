<!--
        Licensed Materials - Property of IBM
        5698WSH
        (C) Copyright IBM Corp. 2016 All Rights Reserved.
        US Government Users Restricted Rights - Use, duplication,
        or disclosure restricted by GSA ADP Schedule Contract with
        IBM Corp.
-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ye olde beer shoppe</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- Le styles -->
<link href="html/assets/css/bootstrap.css" rel="stylesheet">
<style type="text/css">
body {
	padding-top: 60px;
	padding-bottom: 40px;
}

.xhero-unit {
	padding: 60px;
	margin-bottom: 30px;
	background-image: url(2B1ndx.jpg);
	background-repeat: no-repeat;
	background-color: black;
	-webkit-border-radius: 6px;
	-moz-border-radius: 6px;
	border-radius: 6px;
	color: #e0e0e0;
}

.disabledButton {
    pointer-events: none;
    opacity: 0.4;
}
</style>
<link href="html/assets/css/bootstrap-responsive.css" rel="stylesheet">

<!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="html/assets/js/html5shiv.js"></script>
    <![endif]-->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

<script>
	var shoppingCartNumItems = 0;
	var shoppingCartAmount = 0;

	var shoppingCart = {}

	var shoppingCatalog = {
		g1 : {
			price : 12.99,
			desc : "Kwak"
		},
		g2 : {
			price : 9.99,
			desc : "Chimay"
		},
		g3 : {
			price : 22.49,
			desc : "Deus Champagne"
		},
		g4 : {
			price : 4.99,
			desc : "Left Hand"
		},
		g5 : {
			price : 18.99,
			desc : "Savour"
		},
		g6 : {
			price : 30.00,
			desc : "Thelonious"
		}
	};

	function addToShoppingCart(button, id) {
		shoppingCartNumItems++;
		shoppingCartAmount += shoppingCatalog[id].price;

		document.getElementById("cart_num_items").innerHTML = shoppingCartNumItems;

		if (!shoppingCart[id]) {
			shoppingCart[id] = {
				quantity : 0
			}
		}

		shoppingCart[id].quantity++;

		document.getElementById("cart_amount").innerHTML = " ($"
				+ shoppingCartAmount.toFixed(2) + ")";

		// To have fun: change button style to 'success' and keep track of how many items have been added
		if (typeof button.howMany === "undefined" || button.innerHTML.substring(0, 5) != "Added")
			button.howMany = 0;
		button.howMany++;
		button.innerHTML = "Added";
		if (button.howMany > 1)
			button.innerHTML += " (" + button.howMany + ")";
		button.className += " btn-success";
	}

	$(document).ready(function() {
		$("#submitOrderForm").submit(function(event) {
			$("body").css("cursor", "progress");
			$(".container-fluid").addClass("disabledButton");
			event.preventDefault();

			var form = $(this);
			var url = form.attr("action");
			var items = [];
			var order = {
				num_items : 0,
				amount : 0,
				description : ""
			};

			for ( var i in shoppingCart) {
				var item = shoppingCart[i];
				order.num_items += item.quantity;
				order.amount += item.quantity * shoppingCatalog[i].price;
				items.push(item.quantity + "x" + shoppingCatalog[i].desc);
			}

			order.description = items.join(",");

			var posting = $.post(url, order);

			posting.done(function(data) {
				alert("Thank you for your purchase. Your order has been submitted.\n\nWhile it is being processed, check out the document that corresponds to your order in the \"orders\" database on the Cloudant interface.\n\nYour order also generated a Workload Scheduler process which you can monitor from the Application Lab interface available through the Workload Scheduler service.");
				$(".addButton").each(function() {
					$(this).removeClass("btn-success")
						.html('<span aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></span>')
				});
				$("#cart_num_items").html("0");
                shoppingCartNumItems = 0;
				$("#cart_amount").html("");
                shoppingCartAmount = 0;
				$("body").css("cursor", "default");
				$(".container-fluid").removeClass("disabledButton");
			});
		});
	});
</script>

<!-- Fav and touch icons -->
<link rel="apple-touch-icon-precomposed" sizes="144x144" href="html/assets/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114" href="html/assets/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72" href="html/assets/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed" href="html/assets/ico/apple-touch-icon-57-precomposed.png">
<link rel="shortcut icon" href="html/assets/ico/favicon.png">
</head>

<body>

    <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container-fluid">
                <!-- button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
                </button>
                <a class="brand" href="#">TWS on Cloud</a>
                <div class="nav-collapse collapse">
                    <ul class="nav">
                        <li class="active"><a href="#">Home</a>
                        </li>
                        <li><a href="#about">About</a>
                        </li>
                        <li><a href="#contact">Contact</a>
                        </li>
                    </ul!-->
                    <form action="Orders" id="submitOrderForm" class="navbar-form pull-right">
                        <button type="submit" class="btn">Checkout</button>
                    </form>
                    <div class="pull-right" style="font-size: 2em; color: white; margin: 8px 1em 0 0;">
                        Items in cart: <span id="cart_num_items">0</span><span id="cart_amount"></span>
                    </div>
                </div>
                <!--/.nav-collapse -->
            </div>
        </div>
    </div>

    <div class="container-fluid">

        <!-- Main hero unit for a primary marketing message or call to action -->
        <div class="hero-unit">
            <h1>Ye olde Beer shop</h1>
            <p>Showing the finest selection of beers in the world.</p>
        </div>

        <!-- Example row of columns -->
       <div class="row">

            <div class="col-md-4">
              <h2 style="margin-top:0" class="pull-left">Lwak</h2>
              <button onclick="addToShoppingCart(this,'g1')" class="btn btn-primary pull-right addButton"><span aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></span></button>
                <div class="row">
                    <div class="col-md-12" style="">
                        <img class="img-rounded img-responsive" src="html/demo/kwak.jpg" style="float:left;with=40%">
                        <p>This unique beer has exceptional character and flavour that matures with time spent in the bottle; to what extend even we're not sure yet! Earthy and rustic notes are complimented by a rich highly effervescent beer.</p>
                        <p>A beer for sustance over refreshment, this is our tribute to the original farmhouse brewers and to this exceptional family of beers.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <h2 style="margin-top:0" class="pull-left">Thelpagn</h2>
              <button onclick="addToShoppingCart(this,'g2')" class="btn btn-primary pull-right addButton"><span aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></span></button>                
                <div class="row">
                    <div class="col-md-12">
                        <img class="img-rounded img-responsive" src="html/demo/chimay.jpg" style="float:left;with=40%">
                        <p>This unique beer has exceptional character and flavour that matures with time spent in the bottle; to what extend even we're not sure yet! Earthy and rustic notes are complimented by a rich highly effervescent beer.</p>
                        <p>A beer for sustance over refreshment, this is our tribute to the original farmhouse brewers and to this exceptional family of beers.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <h2 style="margin-top:0" class="pull-left">Savand</h2>
              <button onclick="addToShoppingCart(this,'g3')" class="btn btn-primary pull-right addButton"><span aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></span></button>                
                <div class="row">
                    <div class="col-md-12">
                        <img class="img-rounded img-responsive" src="html/demo/deuschampagne.jpg" style="float:left;with=40%">
                        <p>This unique beer has exceptional character and flavour that matures with time spent in the bottle; to what extend even we're not sure yet! Earthy and rustic notes are complimented by a rich highly effervescent beer.</p>
                        <p>A beer for sustance over refreshment, this is our tribute to the original farmhouse brewers and to this exceptional family of beers.</p>
                    </div>
                </div>
            </div>
        </div> 
        
        <div class="row">
            <div class="col-md-4">
                <h2 style="margin-top:0" class="pull-left">Fishkyjd</h2>
              <button onclick="addToShoppingCart(this,'g4')" class="btn btn-primary pull-right addButton"><span aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></span></button>                
                <div class="row">
                    <div class="col-md-12">
                        <img class="img-rounded img-responsive" src="html/demo/lefthand.jpg" style="float:left;with=40%">
                        <p>This unique beer has exceptional character and flavour that matures with time spent in the bottle; to what extend even we're not sure yet! Earthy and rustic notes are complimented by a rich highly effervescent beer.</p>
                        <p>A beer for sustance over refreshment, this is our tribute to the original farmhouse brewers and to this exceptional family of beers.</p>
                    </div>
                </div>
            </div>
            
             <div class="col-md-4">
                <h2 style="margin-top:0" class="pull-left">Landak</h2>
              <button onclick="addToShoppingCart(this,'g5')" class="btn btn-primary pull-right addButton"><span aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></span></button>                
                <div class="row">
                    <div class="col-md-12">
                        <img class="img-rounded img-responsive" src="html/demo/savour.jpg" style="float:left;with=40%">
                        <p>This unique beer has exceptional character and flavour that matures with time spent in the bottle; to what extend even we're not sure yet! Earthy and rustic notes are complimented by a rich highly effervescent beer.</p>
                        <p>A beer for sustance over refreshment, this is our tribute to the original farmhouse brewers and to this exceptional family of beers.</p>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <h2 style="margin-top:0" class="pull-left">Khiashkyj</h2>
              <button onclick="addToShoppingCart(this,'g6')" class="btn btn-primary pull-right addButton"><span aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></span></button>                
                <div class="row">
                    <div class="col-md-12">
                        <img class="img-rounded img-responsive" src="html/demo/thelonious.jpg" style="float:left;with=40%">
                        <p>This unique beer has exceptional character and flavour that matures with time spent in the bottle; to what extend even we're not sure yet! Earthy and rustic notes are complimented by a rich highly effervescent beer.</p>
                        <p>A beer for sustance over refreshment, this is our tribute to the original farmhouse brewers and to this exceptional family of beers.</p>
                    </div>
                </div>
            </div>

        </div>



        <hr>

        <footer>
        <p>&copy; TWS 2016</p>
        </footer>

    </div>
    <!-- /container -->
</body>
</html>
