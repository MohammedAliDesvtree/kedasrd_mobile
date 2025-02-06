import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kedasrd/utils/images.dart';
import 'package:kedasrd/utils/themes.dart';

class DummyData {
  static List<dynamic> productList = [
    {
      "id": 1,
      "image": Images.nachitos,
      "price": 10,
      "title": "Nachitos Ricos",
      "qty": 1
    },
    {
      "id": 2,
      "image": Images.hamberger,
      "price": 8,
      "title": "Fruit Salad",
      "qty": 1
    },
    {
      "id": 3,
      "image": Images.restaurant,
      "price": 18,
      "title": "Grilled Salmon",
      "qty": 1
    },
    {
      "id": 4,
      "image": Images.pastelitos,
      "price": 12,
      "title": "Vegetable Stir-Fry",
      "qty": 1
    },
    {
      "id": 5,
      "image": Images.bolitas,
      "price": 9,
      "title": "Chicken Tacos",
      "qty": 1
    },
    {
      "id": 6,
      "image": Images.hamberger,
      "price": 12,
      "title": "Beef Burger",
      "qty": 1
    },
    {
      "id": 7,
      "image": Images.restaurant,
      "price": 7,
      "title": "Caesar Salad",
      "qty": 1
    },
    {
      "id": 8,
      "image": Images.nachitos,
      "price": 15,
      "title": "Sushi Platter",
      "qty": 1
    },
    {
      "id": 9,
      "image": Images.pastelitos,
      "price": 14,
      "title": "Pasta Carbonara",
      "qty": 1
    },
    {
      "id": 10,
      "image": Images.hamberger,
      "price": 11,
      "title": "Margherita Pizza",
      "qty": 1
    },
    {
      "id": 11,
      "image": Images.storeBG,
      "price": 20,
      "title": "Steak Frites",
      "qty": 1
    },
    {
      "id": 12,
      "image": Images.restaurant,
      "price": 16,
      "title": "Tofu Stir-Fry",
      "qty": 1
    },
    {
      "id": 13,
      "image": Images.bolitas,
      "price": 9,
      "title": "Shrimp Scampi",
      "qty": 1
    },
    {
      "id": 14,
      "image": Images.nachitos,
      "price": 13,
      "title": "Quinoa Salad",
      "qty": 1
    },
    {
      "id": 15,
      "image": Images.fastFood,
      "price": 22,
      "title": "BBQ Ribs",
      "qty": 1
    },
    {
      "id": 16,
      "image": Images.pastelitos,
      "price": 17,
      "title": "Lobster Roll",
      "qty": 1
    },
  ].obs;

  static List<dynamic> dashboardList = [
    {"image": Images.regular, "title": "Regular"},
    {"image": Images.restaurant, "title": "Restaurant"},
    {"image": Images.fastFood, "title": "Fast Food"},
    {"image": Images.superMarket, "title": "Super Market"},
    {"image": Images.onlineOrder, "title": "Online Store"},
  ];

  static List<dynamic> restaurantList = [
    {"image": Images.newOrder, "title": "New Order"},
    {"image": Images.activeOrder, "title": "Active Order"},
    {"image": Images.kitchen, "title": "Kitchen"},
  ];

  static List<dynamic> newOrderList = [
    {"image": Images.dineIn, "title": "Dine In"},
    {"image": Images.delivery, "title": "Delivery"},
    {"image": Images.pickUp, "title": "Pickup"},
  ];

  static List<dynamic> activeOrderList = [
    {"image": Images.dineIn, "title": "Dine In"},
    {"image": Images.delivery, "title": "Delivery"},
    {"image": Images.pickUp, "title": "Pickup"},
  ];

  static List<String> filterItems = [
    'All',
    'BEBIDAS-',
    'Beverages',
    'Beers',
    'Sides',
    'Juices',
    'Tickets',
    'ESPECIALES',
    'SALCHICHAS',
    'Snacks',
    'Dessert',
    'BURRITOS',
    'Meals',
    'HOTDOG/HAMB',
    'YAROA',
    'ALITAS',
    'PECHUGA',
    'Aqua',
    'Refrescos',
    'Adicionales',
    'Gustitos Ricos',
    'Mariscos',
    'Platos Fuertes',
    'Los Catadores',
    'Los Fuertes',
    'Services',
  ];

  static List<String> restaurantItems = [
    'New Order',
    'Active Order',
    'Kitchen'
  ];

  static List<dynamic> superMarketItems = [
    'Customer',
    'Item Name',
    'Select Currency'
  ];

  static List<dynamic> superMarketButtonItems = [
    {"title": 'Items', "color": Themes.kPrimaryColor},
    {"title": 'Customers', "color": const Color(0xFFFFB84D)},
    {"title": 'Orders', "color": Themes.kGreenColor},
    {"title": 'Save Order', "color": const Color(0xFFF18C52)},
    {"title": 'Discard Order', "color": const Color(0xFFFC7373)},
    {"title": 'Discount', "color": const Color(0xFFDB91F1)},
  ];

  static List<dynamic> superMarketCartDeskItems = [
    'Cash',
    'Card',
    'Partial',
    'Prepaid',
    'Receivable',
    'Transfer',
    'Uber Eats',
    'Pedidos Ya',
    'Glovo'
  ];

  static List<dynamic> tableTabs = [
    'Main Room',
    'Inside Room',
    'Outside Room',
    'Balcony Side',
    'Near Balcony'
  ];

  static List<dynamic> settingTabs = [
    'General',
    'Orders',
    'Kitchen',
    'Tables',
    'Printer',
    'Taxes',
  ];

  static List<dynamic> ordersItems = [
    {"icon": Images.draft, "title": "Draft"},
    {"icon": Images.orders, "title": "All Orders"},
    {"icon": Images.delete, "title": "Draft Orders Deleted"},
  ];

  static List<dynamic> posDrawerItems = [
    {"icon": Images.shifts, "title": "Shifts"},
    {"icon": Images.setting, "title": "Setting"},
    {"icon": Images.exit, "title": "Exit"},
    {"icon": Images.exit, "title": "Logout"},
  ];

  static List<dynamic> restaurantDrawerItems = [
    {"icon": Images.home, "title": "Home"},
    {"icon": Images.checkout, "title": "Active Order"},
    {"icon": Images.newOrderIc, "title": "New Order"},
    {"icon": Images.kitchenIc, "title": "Kitchen"},
    {"icon": Images.bar, "title": "Bar"},
    {"icon": Images.table, "title": "Table"},
    {"icon": Images.category, "title": "Categories"},
    {"icon": Images.list, "title": "Orders"},
    {"icon": Images.shifts, "title": "Shifts"},
    {"icon": Images.setting, "title": "Setting"},
    {"icon": Images.help, "title": "Help"},
    {"icon": Images.exit, "title": "Exit"},
    {"icon": Images.exit, "title": "Logout"},
  ];

  static List<dynamic> fastFoodDrawerItems = [
    {"icon": Images.checkout, "title": "Active Order"},
    {"icon": Images.newOrderIc, "title": "New Order"},
    {"icon": Images.kitchenIc, "title": "Kitchen"},
    {"icon": Images.category, "title": "Categories"},
    {"icon": Images.list, "title": "Orders"},
    {"icon": Images.shifts, "title": "Shifts"},
    {"icon": Images.setting, "title": "Setting"},
    {"icon": Images.help, "title": "Help"},
    {"icon": Images.exit, "title": "Exit"},
    {"icon": Images.exit, "title": "Logout"},
  ];

  static List<dynamic> superMarketDrawerItems = [
    {"icon": Images.newOrderIc, "title": "New Order"},
    {"icon": Images.shifts, "title": "Shifts"},
    {"icon": Images.setting, "title": "Setting"},
    {"icon": Images.items, "title": "Items"},
    {"icon": Images.customer, "title": "Customers"},
    {"icon": Images.list, "title": "Orders"},
    {"icon": Images.discard, "title": "Discard Order"},
    {"icon": Images.discount, "title": "Discount"},
    {"icon": Images.exit, "title": "Exit"},
    {"icon": Images.exit, "title": "Logout"},
  ];

  static List<dynamic> onlineStoreDrawerItems = [
    {"icon": Images.home, "title": "Home"},
    {"icon": Images.telephone, "title": "Contact"},
  ];

  // List of items in our dropdown menu
  static List<String> currencyItems = [
    "Dollars - USD (USD \$)",
    "New Manats - AZN (MaH)",
    "Convertible Marka - BAM (KM)",
    "Leke All (Lek)",
  ];

  static List<String> ncfItems = [
    "Factura Con Credito Fiscal B01",
  ];

  static List<String> bankAccountItems = [
    "2001 - Accounts payable",
    "2001 - Credit card",
    "100201 - Banco Popular DOP\$",
    "100202 - Banco Popular USD\$*0733",
  ];

  static List<String> walletBankAccountItems = [
    "2001 - Accounts payable",
  ];

  static List<String> templateItems = [
    "Template 80MM",
    "Template 58MM",
    "Template 58MM NL",
    "Template 80MM NL",
    "Template 80MM C",
    "Template 58MM C",
    "Template 80MM R",
    "Template 58MM R",
    "Template 80MM RL",
    "Template 58MM RL",
    "Template 80MM WL",
    "Template 58MM WL",
  ];

  static List<String> templateSelectionItems = [
    "Enable",
    "Disable",
  ];

  static List<String> agentsItems = [
    "Sirena",
  ];

  static List<String> orderFlowItems = [
    "Short",
    "Advance",
  ];

  static List<String> selectMsgItems = [
    "DESPEDIDA",
    "Despedida",
  ];

  static List<String> orderStatusItems = [
    "Keep After Printed",
    "Clean After Printed",
  ];

  static List<String> printerList = [
    "POS80 Printer",
    "TSC TE244",
    "POS-58-Series",
    "Microsoft Print to PDF",
    "EPSON TM-T82X Receipt (1)",
    "Fax",
    "XP-80C AOKIA",
    "OneNote (Desktop)",
    "NPIA6FAD8 (HP LaserJet MFP M227fdw)",
    "Microsoft XPS Document Writer",
    "HPB0227A55598A8 (HP Laser MFP 131 133 135-138)",
    "EPSON TM-T88IV Receipt",
    "EPSON L3250 Series",
    "Epson 80MM",
    "AnyDesk Printer",
    "Nitro PDF Creator",
    "2C-POS80-01-V7 Printer(3)",
    "XP-80C",
    "OneNote for Windows 10",
    "PRINTER COCINA (KITCHEN)",
    "Enviar a OneNote 16",
    "2C-POS80-01-V7 Printer Cashier",
    "XP-80",
    "Brother MFC-J1010DW Printer",
    "80mm Series Printer",
  ];

  static List<String> tipTaxList = [
    "Custom (0%)",
    "Propina de Ley (10%)",
    "ITBIS + (18%)",
    "ITBIS (18%)",
    "AFP (2.87%)",
    "SFS (3.04%)",
    "ITBIS 2 (18%)",
    "CDT (2%)",
    "ISC (10%)",
  ];

  static List<String> taxItems = [
    "Custom (0%)",
    "AFP (2.87%)",
    "ISC (10%)",
  ];

  static List<String> cardItems = [
    "Credit Card",
    "Debit Card",
  ];

  static List<String> typeItems = [
    "Cash",
    "Credit Card",
    "Debit Card",
    "Prepaid",
    "Receivable",
    "Transfer"
  ];

  static List<String> printerItems = ["Windows", "Web"];

  static List<String> orderOfShowingItems = ["Top", "Bottom"];

  static List<String> ordersFilters = ["Today", "Yesterday", "Last 7 Days"];

  static List<String> exportItems = ["Export PDF", "Export Excel"];

  static List<String> actionItems = ["Confirm By Whatsapp", "Send By Email"];

  static List<String> cartOptionsItems = ["Print Pre-Bill", "Clear Cart"];

  static List<String> cartSingleItems = [
    "Add Extra Items",
    "Add Notes",
    "Send to Kitchen",
    "Send to Bar",
    "Remove"
  ];

  static List<String> countryItems = [
    "India",
    "UAE",
    "USA",
    "Send to Bar",
    "Remove"
  ];

  static List<String> stateItems = [
    "Delhi",
    "Ahmedabad",
    "Surat",
    "Baroda",
    "Mumbai"
  ];

  static List<String> payItems = [
    'Cash',
    'Credit Card',
    'Transfer',
    'Partial Payment',
    'Prepaid Balance',
    'Receivable',
    'Uber Eats',
    'Pedidos Ya',
    'Glovo'
  ];

  static List<String> extraItems = [
    'Paneer',
    'Black Olives',
    'Red Peppers',
    'Mashroom',
    'Cheeze',
    "Vegitable",
    "Chicken"
  ];

  static List<String> formulaItems = ["No result found"];

  static List<String> tableModeItems = [
    "Only Table by Section",
    "All Tables",
  ];

  static List<dynamic> settingItems = [
    {"icon": Images.general, "title": "General"},
    {"icon": Images.orders, "title": "Orders"},
    {"icon": Images.kitchenIc, "title": "Kitchen"},
    {"icon": Images.chair, "title": "Tables"},
    {"icon": Images.printer, "title": "Printer"},
    {"icon": Images.taxes, "title": "Taxes"},
  ];
}
