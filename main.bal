import ballerina/http;

// Mock shipment data with comprehensive fields
map<Shipment> mockShipments = {
    "SH001": {
        shipmentId: "SH001",
        orderId: "ORD001",
        customerId: "CUST001",
        customerName: "John Smith",
        origin: "New York, NY",
        destination: "Los Angeles, CA",
        status: IN_TRANSIT,
        createdDate: "2024-01-10",
        estimatedDeliveryDate: "2024-01-15",
        actualDeliveryDate: (),
        totalWeight: 2.5,
        carrier: "Express Logistics",
        trackingNumber: "TRK123456789"
    },
    "SH002": {
        shipmentId: "SH002",
        orderId: "ORD002",
        customerId: "CUST002",
        customerName: "Sarah Johnson",
        origin: "Chicago, IL",
        destination: "Miami, FL",
        status: DELIVERED,
        createdDate: "2024-01-08",
        estimatedDeliveryDate: "2024-01-10",
        actualDeliveryDate: "2024-01-10",
        totalWeight: 1.8,
        carrier: "Fast Ship Co",
        trackingNumber: "TRK987654321"
    },
    "SH003": {
        shipmentId: "SH003",
        orderId: "ORD003",
        customerId: "CUST003",
        customerName: "Michael Brown",
        origin: "Seattle, WA",
        destination: "Boston, MA",
        status: PROCESSING,
        createdDate: "2024-01-12",
        estimatedDeliveryDate: "2024-01-20",
        actualDeliveryDate: (),
        totalWeight: 3.2,
        carrier: "Reliable Transport",
        trackingNumber: "TRK456789123"
    },
    "SH004": {
        shipmentId: "SH004",
        orderId: "ORD004",
        customerId: "CUST004",
        customerName: "Emily Davis",
        origin: "Denver, CO",
        destination: "Atlanta, GA",
        status: OUT_FOR_DELIVERY,
        createdDate: "2024-01-11",
        estimatedDeliveryDate: "2024-01-14",
        actualDeliveryDate: (),
        totalWeight: 4.1,
        carrier: "Quick Delivery",
        trackingNumber: "TRK789123456"
    },
    "SH005": {
        shipmentId: "SH005",
        orderId: "ORD005",
        customerId: "CUST005",
        customerName: "Robert Wilson",
        origin: "Phoenix, AZ",
        destination: "Portland, OR",
        status: CANCELLED,
        createdDate: "2024-01-09",
        estimatedDeliveryDate: "2024-01-16",
        actualDeliveryDate: (),
        totalWeight: 1.2,
        carrier: "Standard Shipping",
        trackingNumber: "TRK321654987"
    }
};

// HTTP service for mock shipment API
service /api/v1 on new http:Listener(8081) {
    
    // Get shipment by ID
    resource function get shipments/[string shipmentId]() returns Shipment|ShipmentNotFound|http:NotFound {
        if mockShipments.hasKey(shipmentId) {
            Shipment shipment = mockShipments.get(shipmentId);
            return shipment;
        } else {
            ShipmentNotFound notFoundResponse = {
                message: "Shipment not found",
                shipmentId: shipmentId
            };
            return http:NOT_FOUND;
        }
    }
    
    // Get all shipments (bonus endpoint)
    resource function get shipments() returns Shipment[] {
        return mockShipments.toArray();
    }
    
    // Get shipments by customer ID
    resource function get shipments/customer/[string customerId]() returns Shipment[] {
        Shipment[] customerShipments = [];
        foreach Shipment shipment in mockShipments.toArray() {
            if shipment.customerId == customerId {
                customerShipments.push(shipment);
            }
        }
        return customerShipments;
    }
    
    // Get shipments by status
    resource function get shipments/status/[string status]() returns Shipment[] {
        Shipment[] statusShipments = [];
        foreach Shipment shipment in mockShipments.toArray() {
            if shipment.status.toString() == status.toUpperAscii() {
                statusShipments.push(shipment);
            }
        }
        return statusShipments;
    }
}

public function main() returns error? {
    // Service will start automatically when the module is run
}
