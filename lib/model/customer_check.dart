class CustomerResponse {
  String status;
  String statusMessage;
  String customerName;
  String customerAddress;
  String customerPhone;
  String customerCode;

  CustomerResponse({
    required this.status,
    required this.statusMessage,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.customerCode,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) {
    return CustomerResponse(
      status: json['status'] ?? '',
      statusMessage: json['status_message'] ?? '',
      customerName: json['customer_name'] ?? '',
      customerAddress: json['customer_address'] ?? '',
      customerPhone: json['customer_phone'] ?? '',
      customerCode: json['customer_code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'status_message': statusMessage,
      'customer_name': customerName,
      'customer_address': customerAddress,
      'customer_phone': customerPhone,
      'customer_code': customerCode,
    };
  }
}
