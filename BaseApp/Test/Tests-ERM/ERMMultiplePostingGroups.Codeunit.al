codeunit 134195 "ERM Multiple Posting Groups"
{
    Subtype = Test;
    TestPermissions = Disabled;

    trigger OnRun()
    begin
        // [FEATURE] [Posting Group]
    end;

    var
        LibraryERM: Codeunit "Library - ERM";
        LibrarySales: Codeunit "Library - Sales";
        LibraryPurchase: Codeunit "Library - Purchase";
        LibraryService: Codeunit "Library - Service";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
        LibraryRandom: Codeunit "Library - Random";
        LibraryUtility: Codeunit "Library - Utility";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
        Assert: Codeunit Assert;
        isInitialized: Boolean;
        BlockedTestFieldErr: Label 'Blocked must be equal to ''No''';
        TestFieldCodeErr: Label 'TestField';
        AccountCategory: Option ,Assets,Liabilities,Equity,Income,"Cost of Goods Sold",Expense;
        GenProdPostingGroupTestFieldErr: Label 'Gen. Prod. Posting Group must have a value in G/L Account: No.=%1. It cannot be zero or empty.';

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesOrderCustomerPostingGroupIsNotEditableIfFeatureDisabled()
    var
        SalesOrder: TestPage "Sales Order";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(false);

        SalesOrder.OpenNew();
        Assert.IsFalse(SalesOrder."Customer Posting Group".Editable, 'Customer Posting Group is editable in Sales Order page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesOrderCustomerPostingGroupIsEditableIfAllowedForCustomer()
    var
        Customer: Record Customer;
        SalesOrder: TestPage "Sales Order";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(true);

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        SalesOrder.OpenNew();
        SalesOrder."Sell-to Customer No.".SetValue(Customer."No.");
        Assert.IsTrue(SalesOrder."Customer Posting Group".Editable, 'Customer Posting Group is not editable in Sales Order page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesInvoiceCustomerPostingGroupIsNotEditableIfFeatureDisabled()
    var
        SalesInvoice: TestPage "Sales Invoice";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(false);

        SalesInvoice.OpenNew();
        Assert.IsFalse(SalesInvoice."Customer Posting Group".Editable, 'Customer Posting Group is editable in Sales Invoice page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesInvoiceCustomerPostingGroupIsEditableIfAllowedForCustomer()
    var
        Customer: Record Customer;
        SalesInvoice: TestPage "Sales Invoice";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(true);

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        SalesInvoice.OpenNew();
        SalesInvoice."Sell-to Customer No.".SetValue(Customer."No.");
        Assert.IsTrue(SalesInvoice."Customer Posting Group".Editable, 'Customer Posting Group is not editable in Sales Invoice page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesCreditMemoCustomerPostingGroupIsNotEditableIfFeatureDisabled()
    var
        SalesCreditMemo: TestPage "Sales Credit Memo";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(false);

        SalesCreditMemo.OpenNew();
        Assert.IsFalse(SalesCreditMemo."Customer Posting Group".Editable, 'Customer Posting Group is editable in Sales Credit Memo page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesCreditMemoCustomerPostingGroupIsEditableIfAllowedForCustomer()
    var
        Customer: Record Customer;
        SalesCreditMemo: TestPage "Sales Credit Memo";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(true);

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        SalesCreditMemo.OpenNew();
        SalesCreditMemo."Sell-to Customer No.".SetValue(Customer."No.");
        Assert.IsTrue(SalesCreditMemo."Customer Posting Group".Editable, 'Customer Posting Group is not editable in Sales Credit Memo page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesReturnOrderCustomerPostingGroupIsNotEditableIfFeatureDisabled()
    var
        SalesReturnOrder: TestPage "Sales Return Order";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(false);

        SalesReturnOrder.OpenNew();
        Assert.IsFalse(SalesReturnOrder."Customer Posting Group".Editable, 'Customer Posting Group is editable in Sales Return Order page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesReturnOrderCustomerPostingGroupIsEditableIfAllowedForCustomer()
    var
        Customer: Record Customer;
        SalesReturnOrder: TestPage "Sales Return Order";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(true);

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        SalesReturnOrder.OpenNew();
        SalesReturnOrder."Sell-to Customer No.".SetValue(Customer."No.");
        Assert.IsTrue(SalesReturnOrder."Customer Posting Group".Editable, 'Customer Posting Group is not editable in Sales Return Order page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseOrderVendorPostingGroupIsNotEditableIfFeatureDisabled()
    var
        PurchaseOrder: TestPage "Purchase Order";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(false);

        PurchaseOrder.OpenNew();
        Assert.IsFalse(PurchaseOrder."Vendor Posting Group".Editable, 'Vendor Posting Group is editable in Purchase Order page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseOrderVendorPostingGroupIsEditableIfAllowedForVendor()
    var
        Vendor: Record Vendor;
        PurchaseOrder: TestPage "Purchase Order";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(true);

        LibraryPurchase.CreateVendor(Vendor);
        Vendor.Validate("Allow Multiple Posting Groups", true);
        Vendor.Modify();

        PurchaseOrder.OpenNew();
        PurchaseOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        Assert.IsTrue(PurchaseOrder."Vendor Posting Group".Editable, 'Vendor Posting Group is not editable in Purchase Order page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseInvoiceVendorPostingGroupIsNotEditableIfFeatureDisabled()
    var
        PurchaseInvoice: TestPage "Purchase Invoice";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(false);

        PurchaseInvoice.OpenNew();
        Assert.IsFalse(PurchaseInvoice."Vendor Posting Group".Editable, 'Vendor Posting Group is editable in Purchase Invoice page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseInvoiceVendorPostingGroupIsEditableIfAllowedForVendor()
    var
        Vendor: Record vendor;
        PurchaseInvoice: TestPage "Purchase Invoice";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(true);

        LibraryPurchase.CreateVendor(Vendor);
        Vendor.Validate("Allow Multiple Posting Groups", true);
        Vendor.Modify();

        PurchaseInvoice.OpenNew();
        PurchaseInvoice."Buy-from Vendor No.".SetValue(Vendor."No.");
        Assert.IsTrue(PurchaseInvoice."Vendor Posting Group".Editable, 'Vendor Posting Group is not editable in Purchase Invoice page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseCreditMemoVendorPostingGroupIsNotEditableIfFeatureDisabled()
    var
        PurchaseCreditMemo: TestPage "Purchase Credit Memo";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(false);

        PurchaseCreditMemo.OpenNew();
        Assert.IsFalse(PurchaseCreditMemo."Vendor Posting Group".Editable, 'Vendor Posting Group is editable in Purchase Credit Memo page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseCreditMemoVendorPostingGroupIsEditableIfAllowedForVendor()
    var
        Vendor: Record Vendor;
        PurchaseCreditMemo: TestPage "Purchase Credit Memo";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(true);

        LibraryPurchase.CreateVendor(Vendor);
        Vendor.Validate("Allow Multiple Posting Groups", true);
        Vendor.Modify();

        PurchaseCreditMemo.OpenNew();
        PurchaseCreditMemo."Buy-from Vendor No.".SetValue(Vendor."No.");
        Assert.IsTrue(PurchaseCreditMemo."Vendor Posting Group".Editable, 'Vendor Posting Group is not editable in Purchase Credit Memo page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseReturnOrderCustomerPostingGroupIsNotEditableIfFeatureDisabled()
    var
        PurchaseReturnOrder: TestPage "Purchase Return Order";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(false);

        PurchaseReturnOrder.OpenNew();
        Assert.IsFalse(PurchaseReturnOrder."Vendor Posting Group".Editable, 'Customer Posting Group is editable in Purchase Return Order page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseReturnOrderCustomerPostingGroupIsEditableIfAllowedForVendor()
    var
        Vendor: Record Vendor;
        PurchaseReturnOrder: TestPage "Purchase Return Order";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(true);

        LibraryPurchase.CreateVendor(Vendor);
        Vendor.Validate("Allow Multiple Posting Groups", true);
        Vendor.Modify();

        PurchaseReturnOrder.OpenNew();
        PurchaseReturnOrder."Buy-from Vendor No.".SetValue(Vendor."No.");
        Assert.IsTrue(PurchaseReturnOrder."Vendor Posting Group".Editable, 'Vendor Posting Group is not editable in Purchase Return Order page');
    end;


    [Test]
    [Scope('OnPrem')]
    procedure CheckServiceInvoiceCustomerPostingGroupIsNotEditableIfFeatureDisabled()
    var
        ServiceInvoice: TestPage "Service Invoice";
    begin
        Initialize();

        SetServiceAllowMultiplePostingGroups(false);

        ServiceInvoice.OpenNew();
        Assert.IsFalse(ServiceInvoice."Customer Posting Group".Editable, 'Customer Posting Group is editable in Service Invoice page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckServiceInvoiceCustomerPostingGroupIsEditableIfAllowedForCustomer()
    var
        Customer: Record Customer;
        ServiceInvoice: TestPage "Service Invoice";
    begin
        Initialize();

        SetServiceAllowMultiplePostingGroups(true);
        LibraryService.SetupServiceMgtNoSeries();

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        ServiceInvoice.OpenNew();
        ServiceInvoice."Bill-to Customer No.".SetValue(Customer."No.");
        Assert.IsTrue(ServiceInvoice."Customer Posting Group".Editable, 'Customer Posting Group is not editable in Service Invoice page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckServiceCreditMemoCustomerPostingGroupIsNotEditableIfFeatureDisabled()
    var
        ServiceCreditMemo: TestPage "Service Credit Memo";
    begin
        Initialize();

        SetServiceAllowMultiplePostingGroups(false);

        ServiceCreditMemo.OpenNew();
        Assert.IsFalse(ServiceCreditMemo."Customer Posting Group".Editable, 'Customer Posting Group is editable in Service Credit Memo page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckServiceCreditMemoCustomerPostingGroupIsEditableIfAllowedForCustomer()
    var
        Customer: Record Customer;
        ServiceCreditMemo: TestPage "Service Credit Memo";
    begin
        Initialize();

        SetServiceAllowMultiplePostingGroups(true);
        LibraryService.SetupServiceMgtNoSeries();

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        ServiceCreditMemo.OpenNew();
        ServiceCreditMemo."Bill-to Customer No.".SetValue(Customer."No.");
        Assert.IsTrue(ServiceCreditMemo."Customer Posting Group".Editable, 'Customer Posting Group is not editable in Service Credit Memo page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckFinanceChargeMemoCustomerPostingGroupIsNotEditableIfFeatureDisabled()
    var
        FinanceChargeMemo: TestPage "Finance Charge Memo";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(false);

        FinanceChargeMemo.OpenNew();
        Assert.IsFalse(FinanceChargeMemo."Customer Posting Group".Editable, 'Customer Posting Group is editable in Finance Charge Memo page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckFinanceChargeMemoCustomerPostingGroupIsEditableIfAllowedForCustomer()
    var
        Customer: Record Customer;
        FinanceChargeMemo: TestPage "Finance Charge Memo";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(true);

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        FinanceChargeMemo.OpenNew();
        FinanceChargeMemo."Customer No.".SetValue(Customer."No.");
        Assert.IsTrue(FinanceChargeMemo."Customer Posting Group".Editable, 'Customer Posting Group is not editable in Finance Charge Memo page');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckChangePostingGroupInSalesInvoiceIfFeatureDisabled()
    var
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(false);

        // Create sales invoice, change customer posting group and post
        LibrarySales.CreateCustomer(Customer);
        LibrarySales.CreateSalesDocumentWithItem(SalesHeader, SalesLine, "Sales Document Type"::Invoice, Customer."No.", '', 1, '', 0D);
        LibrarySales.CreateCustomerPostingGroup(CustomerPostingGroup);
        SalesHeader.Validate("Customer Posting Group", CustomerPostingGroup.Code);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckChangePostingGroupInPurchaseInvoiceIfFeatureDisabled()
    var
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(false);

        // Create sales invoice, change customer posting group and post
        LibraryPurchase.CreateVendor(Vendor);
        LibraryPurchase.CreatePurchaseDocumentWithItem(PurchaseHeader, PurchaseLine, "Purchase Document Type"::Invoice, Vendor."No.", '', 1, '', 0D);
        LibraryPurchase.CreateVendorPostingGroup(VendorPostingGroup);
        PurchaseHeader.Validate("Vendor Posting Group", VendorPostingGroup.Code);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckSalesInvoiceIfAnotherCustomerPostingGroupCannotBeUsed()
    var
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(false);

        // Create sales invoice, change customer posting group and post
        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();
        LibrarySales.CreateSalesDocumentWithItem(SalesHeader, SalesLine, "Sales Document Type"::Invoice, Customer."No.", '', 1, '', 0D);
        LibrarySales.CreateCustomerPostingGroup(CustomerPostingGroup);

        // Verify another posting group cannot be assigned
        SalesHeader.Validate("Customer Posting Group", CustomerPostingGroup.Code);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPostSalesInvoiceWithAnotherCustomerPostingGroup()
    var
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        Initialize();

        SetSalesAllowMultiplePostingGroups(true);

        // Create sales invoice, change customer posting group and post
        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();
        LibrarySales.CreateSalesDocumentWithItem(SalesHeader, SalesLine, "Sales Document Type"::Invoice, Customer."No.", '', 1, '', 0D);
        LibrarySales.CreateCustomerPostingGroup(CustomerPostingGroup);
        LibrarySales.CreateAltCustomerPostingGroup(Customer."Customer Posting Group", CustomerPostingGroup.Code);
        SalesHeader.Validate("Customer Posting Group", CustomerPostingGroup.Code);
        SalesHeader.Modify();

        LibrarySales.PostSalesDocument(SalesHeader, true, true);

        // Check customer posting group code in posted records
        CustLedgerEntry.SetRange("Customer No.", Customer."No.");
        CustLedgerEntry.FindFirst();
        Assert.AreEqual(
            CustLedgerEntry."Customer Posting Group", CustomerPostingGroup.Code,
            'Customer Posting Group in Customer Ledger Entry is not correct.');

        SalesInvoiceHeader.SetRange("Sell-to Customer No.", Customer."No.");
        SalesInvoiceHeader.FindFirst();
        Assert.AreEqual(
            SalesInvoiceHeader."Customer Posting Group", CustomerPostingGroup.Code,
            'Customer Posting Group in Sales Invoice Header is not correct.');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure PostSalesInvoiceWithAlternativeCustomerPostingGroup()
    var
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        // Create Sales Invoice, Post and Verify Sales Invoice Header and Line.

        // Setup: Create Sales Invoice.
        Initialize();
        SetSalesAllowMultiplePostingGroups(true);

        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();
        LibrarySales.CreateSalesDocumentWithItem(SalesHeader, SalesLine, "Sales Document Type"::Invoice, Customer."No.", '', 1, '', 0D);

        LibrarySales.CreateCustomerPostingGroup(CustomerPostingGroup);
        LibrarySales.CreateAltCustomerPostingGroup(Customer."Customer Posting Group", CustomerPostingGroup.Code);
        SalesHeader.Validate("Customer Posting Group", CustomerPostingGroup.Code);
        SalesHeader.Modify();

        // Exercise: Post Sales Invoice.
        LibrarySales.PostSalesDocument(SalesHeader, true, true);
        SetSalesAllowMultiplePostingGroups(false);

        // Verify customer posting group in posted document and ledger entries
        VerifySalesInvoiceCustPostingGroup(GetSalesInvoiceHeaderNo(SalesHeader."No."), CustomerPostingGroup);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPurchaseInvoiceAnotherVendorPostingGroupCannotBeUsed()
    var
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(false);

        // Create sales invoice, change customer posting group
        LibraryPurchase.CreateVendor(Vendor);
        Vendor.Validate("Allow Multiple Posting Groups", true);
        Vendor.Modify();
        LibraryPurchase.CreatePurchaseDocumentWithItem(PurchaseHeader, PurchaseLine, "Purchase Document Type"::Invoice, Vendor."No.", '', 1, '', 0D);
        LibraryPurchase.CreateVendorPostingGroup(VendorPostingGroup);

        // Verify another posting group cannot be assigned
        PurchaseHeader.Validate("Vendor Posting Group", VendorPostingGroup.Code);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPostPurchaseInvoiceWithAnotherVendorPostingGroup()
    var
        Vendor: Record Vendor;
        VendorPostingGroup: Record "Vendor Posting Group";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        Initialize();

        SetPurchAllowMultiplePostingGroups(true);

        // Create sales invoice, change customer posting group and post
        LibraryPurchase.CreateVendor(Vendor);
        Vendor.Validate("Allow Multiple Posting Groups", true);
        Vendor.Modify();
        LibraryPurchase.CreatePurchaseDocumentWithItem(PurchaseHeader, PurchaseLine, "Purchase Document Type"::Invoice, Vendor."No.", '', 1, '', 0D);
        LibraryPurchase.CreateVendorPostingGroup(VendorPostingGroup);
        LibraryPurchase.CreateAltVendorPostingGroup(Vendor."Vendor Posting Group", VendorPostingGroup.Code);
        PurchaseHeader.Validate("Vendor Posting Group", VendorPostingGroup.Code);
        PurchaseHeader.Modify();

        LibraryPurchase.PostPurchaseDocument(PurchaseHeader, true, true);

        // Check vendor posting group code in posted records
        VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
        VendorLedgerEntry.FindFirst();
        Assert.AreEqual(
            VendorLedgerEntry."Vendor Posting Group", VendorPostingGroup.Code,
            'Vendor Posting Group in Vendor Ledger Entry is not correct.');

        PurchInvHeader.SetRange("Buy-from Vendor No.", Vendor."No.");
        PurchInvHeader.FindFirst();
        Assert.AreEqual(
            PurchInvHeader."Vendor Posting Group", VendorPostingGroup.Code,
            'Vendor Posting Group in Purchase Invoice Header is not correct.');
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPostServiceInvoiceIfAnotherCustomerPostingGroupCannotBeUsed()
    var
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
        ServiceHeader: Record "Service Header";
        ServiceItemLine: Record "Service Item Line";
    begin
        Initialize();

        SetServiceAllowMultiplePostingGroups(false);
        LibraryService.SetupServiceMgtNoSeries();

        // Create sales invoice, change customer posting group and post
        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        LibraryService.CreateServiceHeader(ServiceHeader, ServiceHeader."Document Type"::Order, Customer."No.");
        LibraryService.CreateServiceItemLine(ServiceItemLine, ServiceHeader, '');

        LibrarySales.CreateCustomerPostingGroup(CustomerPostingGroup);
        ServiceHeader.Validate("Customer Posting Group", CustomerPostingGroup.Code);
    end;

    [Test]
    [Scope('OnPrem')]
    procedure CheckPostServiceInvoiceWithAnotherCustomerPostingGroup()
    var
        Customer: Record Customer;
        CustomerPostingGroup: Record "Customer Posting Group";
        ServiceHeader: Record "Service Header";
        ServiceLine: Record "Service Line";
        ServiceItemLine: Record "Service Item Line";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        Initialize();

        SetServiceAllowMultiplePostingGroups(true);
        LibraryService.SetupServiceMgtNoSeries();

        // Create sales invoice, change customer posting group and post
        LibrarySales.CreateCustomer(Customer);
        Customer.Validate("Allow Multiple Posting Groups", true);
        Customer.Modify();

        LibraryService.CreateServiceHeader(ServiceHeader, ServiceHeader."Document Type"::Order, Customer."No.");
        LibraryService.CreateServiceItemLine(ServiceItemLine, ServiceHeader, '');
        LibraryService.CreateServiceLine(
          ServiceLine, ServiceHeader, ServiceLine.Type::Item, ServiceItemLine."Item No.");
        UpdateServiceLineWithRandomQtyAndPrice(ServiceLine, ServiceItemLine."Line No.");
        ServiceLine.Modify(true);

        LibrarySales.CreateCustomerPostingGroup(CustomerPostingGroup);
        LibrarySales.CreateAltCustomerPostingGroup(Customer."Customer Posting Group", CustomerPostingGroup.Code);
        ServiceHeader.Validate("Customer Posting Group", CustomerPostingGroup.Code);
        ServiceHeader.Modify();

        LibraryService.PostServiceOrder(ServiceHeader, true, false, true);

        // Check customer posting group code in posted records
        CustLedgerEntry.SetRange("Customer No.", Customer."No.");
        CustLedgerEntry.FindFirst();

        ServiceInvoiceHeader.SetRange("Customer No.", Customer."No.");
        ServiceInvoiceHeader.FindFirst();
    end;

    local procedure Initialize()
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::"ERM Multiple Posting Groups");

        // Lazy Setup.
        LibrarySetupStorage.Restore();
        if isInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::"ERM Multiple Posting Groups");

        LibrarySetupStorage.Save(DATABASE::"General Ledger Setup");
        LibrarySetupStorage.Save(DATABASE::"Sales & Receivables Setup");
        LibrarySetupStorage.Save(DATABASE::"Purchases & Payables Setup");
        LibrarySetupStorage.Save(DATABASE::"Service Mgt. Setup");
        isInitialized := true;
        Commit();

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::"ERM Multiple Posting Groups");
    end;

    local procedure SetSalesAllowMultiplePostingGroups(AllowMultiplePostingGroups: Boolean)
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get();
        SalesReceivablesSetup."Allow Multiple Posting Groups" := AllowMultiplePostingGroups;
        SalesReceivablesSetup."Check Multiple Posting Groups" := "Posting Group Change Method"::"Alternative Groups";
        SalesReceivablesSetup.Modify();
    end;

    local procedure SetServiceAllowMultiplePostingGroups(AllowMultiplePostingGroups: Boolean)
    var
        ServiceMgtSetup: Record "Service Mgt. Setup";
    begin
        ServiceMgtSetup.Get();
        ServiceMgtSetup."Allow Multiple Posting Groups" := AllowMultiplePostingGroups;
        ServiceMgtSetup."Check Multiple Posting Groups" := "Posting Group Change Method"::"Alternative Groups";
        ServiceMgtSetup.Modify();
    end;

    local procedure SetPurchAllowMultiplePostingGroups(AllowMultiplePostingGroups: Boolean)
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
    begin
        PurchasesPayablesSetup.Get();
        PurchasesPayablesSetup."Allow Multiple Posting Groups" := AllowMultiplePostingGroups;
        PurchasesPayablesSetup."Check Multiple Posting Groups" := "Posting Group Change Method"::"Alternative Groups";
        PurchasesPayablesSetup.Modify();
    end;

    local procedure UpdateServiceLineWithRandomQtyAndPrice(var ServiceLine: Record "Service Line"; ServiceItemLineNo: Integer)
    begin
        UpdateServiceLine(
          ServiceLine, ServiceItemLineNo,
          LibraryRandom.RandIntInRange(10, 20), LibraryRandom.RandDecInRange(1000, 2000, 2));
    end;

    local procedure UpdateServiceLine(var ServiceLine: Record "Service Line"; ServiceItemLineNo: Integer; Quantity: Decimal; UnitPrice: Decimal)
    begin
        ServiceLine.Validate("Service Item Line No.", ServiceItemLineNo);
        ServiceLine.Validate(Quantity, Quantity);
        ServiceLine.Validate("Unit Price", UnitPrice);
        ServiceLine.Modify(true);
    end;

    local procedure VerifySalesInvoiceCustPostingGroup(DocumentNo: Code[20]; CustomerPostingGroup: Record "Customer Posting Group")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        GLEntry: Record "G/L Entry";
    begin
        SalesInvoiceHeader.Get(DocumentNo);
        SalesInvoiceHeader.TestField("Customer Posting Group", CustomerPostingGroup.Code);
        SalesInvoiceHeader.CalcFields("Amount Including VAT");

        CustLedgerEntry.SetRange("Customer No.", SalesInvoiceHeader."Bill-to Customer No.");
        CustLedgerEntry.SetRange("Document No.", DocumentNo);
        CustLedgerEntry.SetRange("Posting Date", SalesInvoiceHeader."Posting Date");
        CustLedgerEntry.FindFirst();
        CustLedgerEntry.TestField("Customer Posting Group", CustomerPostingGroup.Code);

        GLEntry.SetRange("Document No.", DocumentNo);
        GLEntry.SetRange("Posting Date", SalesInvoiceHeader."Posting Date");
        GLEntry.SetRange("G/L Account No.", CustomerPostingGroup."Receivables Account");
        GLEntry.FindFirst();
        GLEntry.TestField(Amount, SalesInvoiceHeader."Amount Including VAT");
    end;

    local procedure GetSalesInvoiceHeaderNo(DocumentNo: Code[20]): Code[20]
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.SetRange("Pre-Assigned No.", DocumentNo);
        SalesInvoiceHeader.FindFirst();
        exit(SalesInvoiceHeader."No.");
    end;
}

