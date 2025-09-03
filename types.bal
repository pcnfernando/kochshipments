// Shipment status enumeration
public enum ShipmentStatus {
    PENDING,
    PROCESSING,
    IN_TRANSIT,
    OUT_FOR_DELIVERY,
    DELIVERED,
    CANCELLED,
    RETURNED
}

// Comprehensive shipment record type
public type Shipment record {|
    string shipmentId;
    string orderId;
    string customerId;
    string customerName;
    string origin;
    string destination;
    ShipmentStatus status;
    string createdDate;
    string? estimatedDeliveryDate;
    string? actualDeliveryDate;
    decimal totalWeight;
    string carrier;
    string trackingNumber;
|};

public type ShipmentNotFound record {|
    string message;
    string shipmentId;
|};