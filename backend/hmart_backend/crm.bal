import ballerina/http;
import ballerina/io;
service /crm on new http:Listener(8092) {

    map<Customer> customers = {
        "c1": {customerId: "c1", address: "5, Park road, Brisbane, QLD 4000", status: "ACTIVE"},
        "c2": {customerId: "c2", address: "8, Lake street, Brisbane, QLD 4000", status: "BLOCKED"}
    };

    resource function get customers/[string customerId]() returns Customer|error {
        if !self.customers.hasKey(customerId) {
            return error("Customer not found.");
        }
        io:println("Cutomer data for: " + customerId);
        return self.customers.get(customerId);
    }

    resource function put blocked/[string customerId]() returns error? {
        if !self.customers.hasKey(customerId) {
            return error("Customer not found.");
        }
        Customer customer = self.customers.get(customerId);
        customer.status = "BLOCKED";
    }
}
