# DefaultAPI

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createReceipt**](DefaultAPI.md#createreceipt) | **POST** /receipts | 
[**getAllReceipts**](DefaultAPI.md#getallreceipts) | **GET** /receipts | 
[**getChat**](DefaultAPI.md#getchat) | **GET** /chat/{userId} | 
[**getReceiptById**](DefaultAPI.md#getreceiptbyid) | **GET** /receipts/{id} | 
[**sendMessage**](DefaultAPI.md#sendmessage) | **POST** /chat/{userId} | 


# **createReceipt**
```swift
    open class func createReceipt(receiptUrlDTO: ReceiptUrlDTO, completion: @escaping (_ data: CreateReceipt200Response?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import API

let receiptUrlDTO = ReceiptUrlDTO(url: "url_example") // ReceiptUrlDTO | 

// 
DefaultAPI.createReceipt(receiptUrlDTO: receiptUrlDTO) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **receiptUrlDTO** | [**ReceiptUrlDTO**](ReceiptUrlDTO.md) |  | 

### Return type

[**CreateReceipt200Response**](CreateReceipt200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllReceipts**
```swift
    open class func getAllReceipts(page: Int, limit: Int, completion: @escaping (_ data: GetAllReceiptsDefaultResponse?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import API

let page = 987 // Int |  (default to 1)
let limit = 987 // Int |  (default to 10)

// 
DefaultAPI.getAllReceipts(page: page, limit: limit) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **Int** |  | [default to 1]
 **limit** | **Int** |  | [default to 10]

### Return type

[**GetAllReceiptsDefaultResponse**](GetAllReceiptsDefaultResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChat**
```swift
    open class func getChat(userId: String, completion: @escaping (_ data: CreateReceipt200Response?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import API

let userId = "userId_example" // String | 

// 
DefaultAPI.getChat(userId: userId) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String** |  | 

### Return type

[**CreateReceipt200Response**](CreateReceipt200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReceiptById**
```swift
    open class func getReceiptById(id: String, completion: @escaping (_ data: ReceiptDTO?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import API

let id = "id_example" // String | 

// 
DefaultAPI.getReceiptById(id: id) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String** |  | 

### Return type

[**ReceiptDTO**](ReceiptDTO.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **sendMessage**
```swift
    open class func sendMessage(userId: String, chatMessageDto: ChatMessageDto, completion: @escaping (_ data: SendMessage200Response?, _ error: Error?) -> Void)
```



### Example
```swift
// The following code samples are still beta. For any issue, please report via http://github.com/OpenAPITools/openapi-generator/issues/new
import API

let userId = "userId_example" // String | 
let chatMessageDto = ChatMessageDto(message: "message_example") // ChatMessageDto | 

// 
DefaultAPI.sendMessage(userId: userId, chatMessageDto: chatMessageDto) { (response, error) in
    guard error == nil else {
        print(error)
        return
    }

    if (response) {
        dump(response)
    }
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userId** | **String** |  | 
 **chatMessageDto** | [**ChatMessageDto**](ChatMessageDto.md) |  | 

### Return type

[**SendMessage200Response**](SendMessage200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

