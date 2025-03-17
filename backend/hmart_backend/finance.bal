import ballerina/http;
import ballerina/io;
service /finance on new http:Listener(8094) {
    resource function post invoices(InvoiceRequest invoiceRequest) returns json|error {
        io:println("Created invoice for customer: " + invoiceRequest.customerId);
        return {invoiceId: "K67", status: "created"};
    }
}
