import ballerina/http;
import ballerina/io;

listener http:Listener inventoryListener = new (port = 8091);

service /inventory on inventoryListener {

    map<ProductStock> stocks = {};

    function init() {
        self.stocks["p1"] = {productId: "p1", stock: 10};
        self.stocks["p2"] = {productId: "p2", stock: 2};
        self.stocks["p3"] = {productId: "p3", stock: 50};
    }

    resource function get products/[string productId]() returns error|ProductStock {
        if !self.stocks.hasKey(productId) {
            return error("Product not found: " + productId);
        }
        ProductStock stock = self.stocks.get(productId);
        return stock;
    }

    resource function post reservation(@http:Payload ProductOrder porder) returns json {
        if !self.stocks.hasKey(porder.product) {
            io:println("Ordered: ", porder);
            return {orderId: porder.'order, status: "ordered"};
        }
        ProductStock currentStock = self.stocks.get(porder.product);
        int newStock = currentStock.stock - porder.amount;
        if newStock < 0 {
            io:println("Ordered: ", porder);
            return {orderId: porder.'order, status: "ordered"};
        }
        currentStock.stock = newStock;
        io:println("Reserved: ", porder);
        return {orderId: porder.'order, status: "success"};
    }

    resource function post allocations(@http:Payload AllocationRequest allocation) returns AllocationResponse {
        if !self.stocks.hasKey(allocation.productId) {
            io:println("Invalid product: " + allocation.productId);
            return {orderId: allocation.orderId, status: OUT_OF_STOCK};
        }

        ProductStock currentStock = self.stocks.get(allocation.productId);
        if currentStock.stock < allocation.quantity {
            io:println("Out of stock: " + allocation.productId);
            return {orderId: allocation.orderId, status: OUT_OF_STOCK};
        }

        currentStock.stock -= allocation.quantity;
        io:println("Product allocated: " + allocation.productId);
        return {orderId: allocation.orderId, status: ALLOCATED};
    }

    resource function post porders(@http:Payload ProductStock stock) {
        if self.stocks.hasKey(stock.productId) {
            ProductStock currentStock = self.stocks.get(stock.productId);
            currentStock.stock += stock.stock;
        } else {
            self.stocks[stock.productId] = stock;
        }
    }
}
