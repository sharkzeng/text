//
//  MerchantService.swift
//  DMASDK
//
//  Created by Zhangxz& on 2019/3/26.
//  Copyright © 2019 Zhangxz&. All rights reserved.
//

import UIKit
import Alamofire
import BigInt

enum AsssetLevel:Int{
    case shop = 1
    case market
}
enum ShelfType:Int{
    case on_sale = 1
    case off_sale
}
enum ShelfStatus:Int{
    case pending = 0
    case success
    case failed
    
}
typealias MerchantServiceFinal = (String) -> ()

public class MerchantService: NSObject {
    public var url = EthService().url
    public func deploy(privateKey:String,gasPrice:String,gasLimit:String,name:String,symbol:String,metadata:String,token20:String) -> Result {
        let eth = EthService()
        eth.url = url
        let address = eth.exportAddressFromPrivateKey(privateKey: privateKey)
        let balance = eth.balance(address: address)
        switch balance {
        case .success(let resp):
            let b = resp["balance"] as!String
            if Double(b)! > 0{
                let asset = AssetManagement()
                
                let assetResult = asset.setupDeploy(privateKey: privateKey, name: name, symbol: symbol, metadata: metadata, isburn: true, gasLimit: gasLimit, gasPrice: gasPrice)
                switch assetResult{
                    
                case .success(let value):
                    let assetAddress = value["address"] as!String
                    let platform = PlatformContract()
                    let platformResult = platform.setupDeploy(privateKey: privateKey, token721: assetAddress, token20: token20, platformAddress: platformWallet, firstExpenses: firstExpenses, secondExpenses: secondExpenses, gasLimit: gasLimit, gasPrice: gasPrice)
                    switch platformResult{
                    case .success(let value):
                        let platformAddress = value["address"] as!String
                        return Result.success(value: ["platformAddress":platformAddress,"assetAddress":assetAddress])
                    case .failure(let error):
                        return Result.failure(error: error)
                    }
                case .failure(let error):
                    
                    return Result.failure(error: error)
                }
            }else
            {
                return Result.failure(error: "余额不足")
            }
        case.failure(let error):
            return Result.failure(error: error)
        }
    }
    public func deployStorage(privateKey:String,gasPrice:String,gasLimit:String,chainType:String,name:String,symbol:String,metadata:String,token20:String,success:@escaping MerchantServiceFinal,Failed:@escaping MerchantServiceFinal) -> Void {
        let deployResult = self.deploy(privateKey: privateKey, gasPrice: gasPrice, gasLimit: gasLimit, name: name, symbol: symbol, metadata: metadata, token20: token20)
        switch deployResult {
        case .success(let value):
            let assetAddress = value["assetAddress"]
            let platformAddress = value["platformAddress"]
            let eth = EthWallet()
            
            let param = ["gasPrice":BigUInt(gasPrice)!,
                         "gasLimit":BigUInt(gasLimit)!,
                         "owner":eth.exportAddressFromPrivateKey(privateKey: privateKey)!,
                         "name":name,
                         "address":assetAddress!,
                         "platformAddress":platformAddress!,
                         "symbol":symbol,
                         "metaData":metadata,
                         "canBurn":true,
                         "chainType":chainType,
                         "nodeUrl":assetManagementUrl!]
            
            Alamofire.request(URL(string: merchainDeploy)!, method: .post, parameters: param , encoding: URLEncoding.default).responseString { (resp) in
                if resp.result.isSuccess
                {
                    success(resp.result.value!)
                }
            }
        case .failure(let error):
            Failed("失败")
        }
    }
    
    public func mintWithArray(privateKey:String,assetAddress:String,to:String,array:Array<Any>,metaData:String,isTransfer:Bool,isBurn:Bool,gasLimit:String,gasPrice:String) -> Result {
        let asset = AssetManagement()
        let result = asset.mintWithArray(privateKey: privateKey, contractAddress: assetAddress, to: to, array: array, uri: metaData, isTransfer: isTransfer, isBurn: isBurn, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
    public func mintWithArrayStorage(privateKey:String,assetAddress:String,platformAddress:String,chainType:String,to:String,tokenIds:Array<String>,metaData:String,isTransfer:Bool,isBurn:Bool,notifyUrl:String,gasLimit:String,gasPrice:String,success:@escaping MerchantServiceFinal,Failed:@escaping MerchantServiceFinal) -> Void {
        let mintResult = self.mintWithArray(privateKey: privateKey, assetAddress: assetAddress, to: to, array: tokenIds, metaData: metaData, isTransfer: isTransfer, isBurn: isBurn, gasLimit: gasLimit, gasPrice: gasPrice)
        var targetString:String? = ""
        for i in tokenIds{
            targetString?.append(String(i)+",")
        }
        
        switch mintResult {
        case .success(let value):
            let param = ["owner":to,
                         "contractAddress":assetAddress,
                         "platformAddress":platformAddress,
                         "assetLevel":1,
                         "metaData":metaData,
                         "canTrans":isTransfer,
                         "canBurn":isBurn,
                         "mintTxId":value["hash"]!,
                         "nodeUrl":assetManagementUrl!,
                         "chainType":chainType,
                         "notifyUrl":notifyUrl,
                         "tokenIds":targetString!
            ]
            
            Alamofire.request(URL(string: merchainMint)!, method: .post, parameters: param , encoding: URLEncoding.default).responseString { (resp) in
                if resp.result.isSuccess
                {
                    success(resp.result.value!)
                }
            }
            break
        case .failure( _):
            Failed("失败")
            break
        }
    }
    public func onSales(contractAddress:String,platformAddress:String,privateKey:String,gasLimit:String,gasPrice:String,owner:String,tokenIds:Array<Any>,price:String) -> Result {
        let asset = AssetManagement()
        //
        let assetresult = asset.approveWithArray(privateKey: privateKey, contractAddress: contractAddress, approved: platformAddress, tokenArr: tokenIds, gasLimit: gasLimit, gasPrice: gasPrice)
        switch assetresult {
            
        case .success(let value):
            let assetHash = value["hash"] as!String
            let platfrom = PlatformContract()
            let platformResult = platfrom.saveApproveWithArray(privateKey: privateKey, contractAddress: platformAddress, owner: owner, tokenArr: tokenIds, value:price, gasLimit: gasLimit, gasPrice: gasPrice)
            switch platformResult
            {
            case .success(let value):
                let platfromHash = value["hash"] as!String
                return Result.success(value: ["assetHash":assetHash,"platfromHash":platfromHash])
            case .failure(let error):
                return Result.failure(error: error)
            }
        case .failure(let error):
            return Result.failure(error: error)
            
        }
        
    }
    public  func onSalesStorage(contractAddress:String,platformAddress:String,privateKey:String,gasLimit:String,chainType:String,notifyUrl:String,gasPrice:String,owner:String,tokenIds:Array<String>,price:String,success:@escaping MerchantServiceFinal,Failed:@escaping MerchantServiceFinal) -> Void {
        let onSaleResult = self.onSales(contractAddress: contractAddress, platformAddress: platformAddress, privateKey: privateKey, gasLimit: gasLimit, gasPrice: gasPrice, owner: owner, tokenIds: tokenIds, price: price)
        switch onSaleResult {
        case .success(let value):
            let assetHash = value["assetHash"]
            let platfromHash = value["platfromHash"]
            var targetString:String? = ""
            for i in tokenIds{
                targetString?.append(i+",")
            }
            let param = ["owner":owner,
                         "contractAddress":contractAddress,
                         "platformAddress":platformAddress,
                         "type":1,
                         "status":0,
                         "price":price,
                         "serialNo":isBurn,
                         "approveTxId":assetHash!,
                         "saveApproveTxId":platfromHash!,
                         "nodeUrl":assetManagementUrl!,
                         "chainType":chainType,
                         "notifyUrl":notifyUrl,
                         "tokenIds":targetString!
            ]
            
            Alamofire.request(URL(string: merchainSale)!, method: .post, parameters: param, encoding: URLEncoding.default).responseString { (resp) in
                if resp.result.isSuccess
                {
                    success(resp.result.value!)
                }
            }
            break
        case .failure(let error):
            Failed("失败")
            break
        }
        
    }
    public func offSales(privateKey:String,platAddress:String,tokenArr:Array<Any>,gasLimit:String,gasPrice:String) -> Result {
        let result = PlatformContract()
        return result.revokeApprovesWithArray(privateKey: privateKey, contractAddress: platAddress, tokenArr: tokenArr, gasLimit: gasLimit, gasPrice: gasPrice)
    }
    public  func offSalesStorage(contractAddress:String,privateKey:String,platAddress:String,tokenArr:Array<String>,notifyUrl:String,chainType:String,gasLimit:String,gasPrice:String,success:@escaping MerchantServiceFinal,Failed:@escaping MerchantServiceFinal) -> Void {
        let offsaleResult = self.offSales(privateKey: privateKey, platAddress: platAddress, tokenArr: tokenArr, gasLimit: gasLimit, gasPrice: gasPrice)
        let eth = EthWallet()
        
        switch offsaleResult {
        case .success(let value):
            var targetString:String? = ""
            for i in tokenArr{
                targetString?.append(i+",")
            }
            let param = [
                "contractAddress":contractAddress,
                "platformAddress":platAddress,
                "type":2,
                "status":0,
                "owner":eth.exportAddressFromPrivateKey(privateKey: privateKey)!,
                "revokeTxId":value["hash"]!,
                "nodeUrl":assetManagementUrl!,
                "notifyUrl":notifyUrl,
                "tokenIds":targetString!,
                "chainType":chainType
            ]
            Alamofire.request(URL(string: merchainSale)!, method: .post, parameters: param , encoding: URLEncoding.default).responseString { (resp) in
                if resp.result.isSuccess
                {
                    success(resp.result.value!)
                }            }
            break
        case .failure(let error):
            Failed("失败")
            break
        }
    }
    public  func createOrder(platAddress:String,token20Address:String,privateKey:String,gasPrice:String,gasLimit:String,tokenIds:Array<Any>,sumPrice:String,owner:String) -> Result {
        let tokencontact = TokenContract()
        let tokencontactResult = tokencontact.approve(privateKey: privateKey, contractAddress: token20Address, spender: platAddress, value: sumPrice, gasLimit: gasLimit, gasPrice: gasPrice)
        switch tokencontactResult {
            
        case .success(let value):
            let tokenHash = value["hash"] as!String
            let platform = PlatformContract()
            let platformResult = platform.transferWithArray(privateKey: privateKey, contractAddress: platAddress, owner: owner, tokenArr: tokenIds, value: sumPrice, gasLimit: gasLimit, gasPrice: gasPrice)
            switch platformResult{
                
            case .success(let value):
                let platformHash = value["hash"] as!String
                return Result.success(value: ["tokenHash":tokenHash,"platformHash":platformHash])
                
            case .failure(let error):
                return Result.failure(error: error)
            }
            
        case .failure(let error):
            return Result.failure(error: error)
        }
    }
    public  func createOrderStorage(contractAddress:String,platAddress:String,token20Address:String,privateKey:String,gasPrice:String,gasLimit:String,tokenIds:Array<String>,sumPrice:String,owner:String,chainType:String,notifyUrl:String,remark:String,name:String,orderNo:String,success:@escaping MerchantServiceFinal,Failed:@escaping MerchantServiceFinal) -> Void {
        let createOrderResult = self.createOrder(platAddress: platAddress, token20Address: token20Address, privateKey: privateKey, gasPrice: gasPrice, gasLimit: gasLimit, tokenIds: tokenIds, sumPrice: sumPrice, owner: owner)
        switch createOrderResult {
        case .success(let value):
            var targetString:String? = ""
            for i in tokenIds{
                targetString?.append(i+",")
            }
            let eth = EthWallet()
            
            let param = [
                "quantity":tokenIds.count,
                "remark":remark,
                "name":name,
                "orderNo":name,
                "price":sumPrice,
                "contractAddress":contractAddress,
                "platformAddress":platAddress,
                "owner":owner,
                "toOwner":eth.exportAddressFromPrivateKey(privateKey: privateKey)!,
                "transTxId":value["platformHash"]!,
                "approveTxId":value["tokenHash"]!,
                "tokenIds":targetString!,
                "notifyUrl":notifyUrl,
                "nodeUrl":assetManagementUrl!,
                "chainType":chainType
            ]
            
            Alamofire.request(URL(string: merchaincreateorderInfo)!, method: .post, parameters: param, encoding: URLEncoding.default).responseString { (resp) in
                if resp.result.isSuccess
                {
                    success(resp.result.value!)
                }
                
            }
            break
        case .failure(let error):
            Failed("失败")
            break
        }
        
    }
    public  func getApproveInfo(contractAddress:String,tokenId:String) -> Result {
        let platform = PlatformContract()
        return platform.getApproveinfo(contractAddress: contractAddress, tokenId: tokenId)
    }
    public  func ownerOf(contractAddress:String,tokenId:String) -> Result {
        let asset = AssetManagementService()
        let result = asset.ownerOf(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
    public  func tokenIds(contractAddress:String,owner:String) -> Result {
        let asset = AssetManagement()
        let result = asset.tokenIds(contractAddress: contractAddress, owner: owner)
        return result
    }
    
    public func orderInfo(orderNo:String,success:@escaping MerchantServiceFinal) -> Void {
        let param = [
            "orderNo":orderNo,
            ]
        
        Alamofire.request(URL(string: merchaingetorderInfo)!, method: .post, parameters: param as Dictionary<String,String>, encoding: URLEncoding.default).responseString { (resp) in
            if resp.result.isSuccess
            {
                success(resp.result.value!)
            }        }
    }
    public func orderInfoDetails(orderNo:String,success:@escaping MerchantServiceFinal) -> Void {
        let param = [
            "orderNo":orderNo,
            ]
        Alamofire.request(URL(string: merchaingetorderInfoDetails)!, method: .post, parameters: param as Dictionary<String,String>, encoding: URLEncoding.default).responseString { (resp) in
            if resp.result.isSuccess
            {
                success(resp.result.value!)
            }        }
    }
    public func orderInfoList(owner:String,toOwner:String,success:@escaping MerchantServiceFinal) -> Void {
        var var_empty_dic:Dictionary<String, String> = [:]
        
        //        var param:Dictionary<String, String>?
        if !owner.isEmpty{
            var_empty_dic = ["owner":owner]
        }
        if !toOwner.isEmpty {
            var_empty_dic = ["toOwner":toOwner]
            
        }
        Alamofire.request(URL(string: merchaingetorderInfoList)!, method: .post, parameters: var_empty_dic , encoding: URLEncoding.default).responseString { (resp) in
            if resp.result.isSuccess
            {
                success(resp.result.value!)
            }        }
    }
    public func myContract(owner:String,success:@escaping MerchantServiceFinal) -> Void {
        let param = [
            "owner":owner,
            ]
        Alamofire.request(URL(string: merchaingetmyContract)!, method: .post, parameters: param as Dictionary<String,String>, encoding: URLEncoding.default).responseString { (resp) in
            if resp.result.isSuccess
            {
                success(resp.result.value!)
            }        }
    }
    public  func shelfRecords(contractAddress:String,owner:String,shelfType:Int,success:@escaping MerchantServiceFinal) -> Void {
        let param = [
            "owner":owner,
            "contractAddress":contractAddress,
            "shelfType":String(shelfType),
            ]
        Alamofire.request(URL(string: merchaingetshelfRecords)!, method: .post, parameters: param , encoding: URLEncoding.default).responseString { (resp) in
            if resp.result.isSuccess
            {
                success(resp.result.value!)
            }        }
    }
    public func shelfRecordsDetails(contractAddress:String,owner:String,shelfType:Int,serialNo:String,success:@escaping MerchantServiceFinal) -> Void {
        let param = [
            "owner":owner,
            "contractAddress":contractAddress,
            "shelfType":shelfType,
            "serialNo":serialNo
            ] as [String : Any]
        Alamofire.request(URL(string: merchaingetshelfRecordsDetails)!, method: .post, parameters: param as! Dictionary<String,String>, encoding: URLEncoding.default).responseString { (resp) in
            if resp.result.isSuccess
            {
                success(resp.result.value!)
            }        }
    }
    public func shelfRecordsPendingDetails(contractAddress:String,owner:String,shelfType:Int,serialNo:String,success:@escaping MerchantServiceFinal) -> Void {
        let param = [
            "owner":owner,
            "contractAddress":contractAddress,
            "shelfType":shelfType,
            "serialNo":serialNo
            ] as [String : Any]
        Alamofire.request(URL(string: merchaingetshelfRecordsPendingDetails)!, method: .post, parameters: param as! Dictionary<String,String>, encoding: URLEncoding.default).responseString { (resp) in
            if resp.result.isSuccess
            {
                success(resp.result.value!)
            }
            
        }
    }
    
}
