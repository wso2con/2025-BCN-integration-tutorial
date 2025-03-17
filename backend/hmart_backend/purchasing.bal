import ballerina/http;
import ballerina/io;
service /purchasing on new http:Listener(8096) {

    map<Supplier[]> suppliers = {
        "p1": [{supplierId: "s1", staff: 12, eta: 10, price: 180}, {supplierId: "s2", staff: 60, eta: 60, price: 200}],
        "p2": [{supplierId: "s1", staff: 12, eta: 20, price: 86}]
    };
    
    resource function get suppliers/[string productId]() returns Supplier[]  {
        io:println("Loading suppliers for product: " + productId);
        if !self.suppliers.hasKey(productId) {
            io:println("No suppliers found for the product.");
            return [];
        }
        return self.suppliers.get(productId);
    }

    resource function post purchaseOrders(SupplierOrder sorder) returns json {
        io:println("Supplier order recieved for supplier: " + sorder.supplierId);
        return {supplier: sorder.supplierId, status: "Purchase order created."};
    }
}
