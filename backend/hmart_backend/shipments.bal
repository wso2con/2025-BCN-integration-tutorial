import ballerina/http;
import ballerina/io;
service /shipments on new http:Listener(8093) {

    resource function post outbound(@http:Payload Shipment shipment) returns ShipmentResponse {
        io:println(string `Shipment processed. Order: ${shipment.orderId}, Address: ${shipment.address}`);
        return {orderId: shipment.orderId, status: "PROCESSED"};
    }
    
}
