type Product record {|
    string pid;
    string name;
    decimal price;
    int stock;
    string category;
|};

type ProductStock record {|
    string productId;
    int stock;
|};

type ProductOrder record {|
    string 'order;
    string product;
    int amount;
|};

type Supplier record {|
    string supplierId;
    int staff;
    int eta;
    float price;
|};

type AllocationRequest record {|
    string orderId;
    string productId;
    int quantity;    
|};

type SupplierOrder record {|
    string supplierId;
    string productId;
    int quantity;
|};

enum ALLOCATION_STATUS {ALLOCATED, OUT_OF_STOCK, INVALID_PRODUCT};

type AllocationResponse record {|
    string orderId;
    ALLOCATION_STATUS status;    
|};

type BalanceCheckRequest record {|
    string transactionId;
    string cardNumber;
    float amount;
|};

type BalanceCheckResponse record {|
    string transactionId;
    string status;
    string reason;
|};

type Customer record {|
    string customerId;
    string address;
    string status;
|};

type Shipment record {|
    string orderId;
    string address;
|};

type ShipmentResponse record {|
    string orderId;
    string status;
|};
