//
//  AssetManagementService.swift
//  DMASDK
//
//  Created by Zhangxz& on 2019/3/25.
//  Copyright © 2019 Zhangxz&. All rights reserved.
//

import UIKit

public class AssetManagementService: NSObject {
    private let asset = AssetManagement()
   public func setupDeploy(privateKey:String,name:String,symbol:String,metadata:String,isburn:Bool,gasLimit:String,gasPrice:String) -> Result {
        let  result = asset.setupDeploy(privateKey: privateKey, name: name, symbol: symbol, metadata: metadata, isburn: isburn, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func approve(privateKey:String,contractAddress:String,approved:String,tokenId:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.approve(privateKey: privateKey, contractAddress: contractAddress, approved: approved, tokenId: tokenId, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func approveMulti(privateKey:String,contractAddress:String,approved:String,tokenId:String,count:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.approveMulti(privateKey: privateKey, contractAddress: contractAddress, approved: approved, tokenId: tokenId, count: count, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func approveWithArray(privateKey:String,contractAddress:String,approved:String,tokenArr:Array<Any>,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.approveWithArray(privateKey: privateKey, contractAddress: contractAddress, approved: approved, tokenArr: tokenArr, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func burn(privateKey:String,contractAddress:String,owner:String,tokenId:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.burn(privateKey: privateKey, contractAddress: contractAddress, owner: owner, tokenId: tokenId, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func kill(privateKey:String,contractAddress:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.kill(privateKey: privateKey, contractAddress: contractAddress, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
 public   func mint(privateKey:String,contractAddress:String,to:String,tokenId:String,uri:String,isTransfer:Bool,isBurn:Bool,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.mint(privateKey: privateKey, contractAddress: contractAddress, to: to, tokenId: tokenId, uri: uri, isTransfer: isTransfer, isBurn: isBurn, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
 public   func mintMulti(privateKey:String,contractAddress:String,to:String,tokenId:String,count:String,uri:String,isTransfer:Bool,isBurn:Bool,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.mintMulti(privateKey: privateKey, contractAddress: contractAddress, to: to, tokenId: tokenId, count: count, uri: uri, isTransfer: isTransfer, isBurn: isBurn, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func mintWithArray(privateKey:String,contractAddress:String,to:String,array:Array<Any>,uri:String,isTransfer:Bool,isBurn:Bool,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.mintWithArray(privateKey: privateKey, contractAddress: contractAddress, to: to, array: array, uri: uri, isTransfer: isTransfer, isBurn: isBurn, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func removeApproveWithArray(privateKey:String,contractAddress:String,array:Array<Any>,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.removeApproveWithArray(privateKey: privateKey, contractAddress: contractAddress, array: array, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func removeMultiApprove(privateKey:String,contractAddress:String,tokenId:String,count:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.removeMultiApprove(privateKey: privateKey, contractAddress: contractAddress, tokenId: tokenId, count: count, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func revokeApprove(privateKey:String,contractAddress:String,tokenId:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.revokeApprove(privateKey: privateKey, contractAddress: contractAddress, tokenId: tokenId, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func setApprovalForAll(privateKey:String,contractAddress:String,operatored:String,approved:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.setApprovalForAll(privateKey: privateKey, contractAddress: contractAddress, operatored: operatored, approved: approved, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
 public   func setIsTransfer(privateKey:String,contractAddress:String,tokenId:String,istransfer:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.setIsTransfer(privateKey: privateKey, contractAddress: contractAddress, tokenId: tokenId, istransfer: istransfer, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
public    func setMetadata(privateKey:String,contractAddress:String,metadata:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.setMetadata(privateKey: privateKey, contractAddress: contractAddress, metadata: metadata, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
   public func setStatus(privateKey:String,contractAddress:String,tokenId:String,status:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.setStatus(privateKey: privateKey, contractAddress: contractAddress, tokenId: tokenId, status: status, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func setUser(privateKey:String,contractAddress:String,tokenId:String,user:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.setUser(privateKey: privateKey, contractAddress: contractAddress, tokenId: tokenId, user: user, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func transferFrom(privateKey:String,contractAddress:String,from:String,to:String,tokenId:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.transferFrom(privateKey: privateKey, contractAddress: contractAddress, from: from, to: to, tokenId: tokenId, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
   public func transferFromWithArray(privateKey:String,contractAddress:String,from:String,to:String,tokenIds:Array<Any>,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.transferFromWithArray(privateKey: privateKey, contractAddress: contractAddress, from: from, to: to, tokenIds: tokenIds, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
  public  func transferOwnership(privateKey:String,contractAddress:String,address:String,gasLimit:String,gasPrice:String) -> Result {
        let result = asset.transferOwnership(privateKey: privateKey, contractAddress: contractAddress, address: address, gasLimit: gasLimit, gasPrice: gasPrice)
        return result
    }
    
  public  func balanceOf(contractAddress:String,owner:String) -> Result {
        let result = asset.balanceOf(contractAddress: contractAddress, owner: owner)
        return result
    }
  public  func checkUri(contractAddress:String,tokenId:String) -> Result {
        let result = asset.checkUri(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
 public   func getApproved(contractAddress:String,tokenId:String) -> Result {
        let result = asset.getApproved(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
  public  func getInfo(contractAddress:String) -> Result {
        let result = asset.getInfo(contractAddress: contractAddress)
        return result
    }
  public  func getIsTransfer(contractAddress:String,tokenId:String) -> Result {
        let result = asset.getIsTransfer(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
  public  func getMetadata(contractAddress:String) -> Result {
        let result = asset.getMetadata(contractAddress: contractAddress)
        return result
    }
  public  func getStatus(contractAddress:String,tokenId:String) -> Result {
        let result = asset.getStatus(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
  public  func getTokenInfo(contractAddress:String,tokenId:String) -> Result {
        let result = asset.getTokenInfo(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
  public  func getUser(contractAddress:String,tokenId:String) -> Result {
        let result = asset.getUser(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
  public  func isApprovedForAll(contractAddress:String,owner:String,operatored:String) -> Result {
        let result = asset.isApprovedForAll(contractAddress: contractAddress, owner: owner, operatored: operatored)
        return result
    }
  public  func name(contractAddress:String) -> Result {
        let result = asset.name(contractAddress: contractAddress)
        return result
    }
  public  func owner(contractAddress:String) -> Result {
        let result = asset.owner(contractAddress: contractAddress)
        return result
    }
   public func ownerOf(contractAddress:String,tokenId:String) -> Result {
        let result = asset.ownerOf(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
  public  func symbol(contractAddress:String) -> Result {
        let result = asset.symbol(contractAddress: contractAddress)
        return result
    }
  public  func tokenByIndex(contractAddress:String,index:String) -> Result {
        let result = asset.tokenByIndex(contractAddress: contractAddress, index: index)
        return result
    }
   public func tokenOfOwnerByIndex(contractAddress:String,owner:String,index:String) -> Result {
        let result = asset.tokenOfOwnerByIndex(contractAddress: contractAddress, owner: owner, index: index)
        return result
    }
   public func tokenURI(contractAddress:String,tokenId:String) -> Result {
        let result = asset.tokenURI(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
   public func totalSupply(contractAddress:String) -> Result {
        let result = asset.totalSupply(contractAddress: contractAddress)
        return result
    }
   public func valid(contractAddress:String,tokenId:String) -> Result {
        let result = asset.valid(contractAddress: contractAddress, tokenId: tokenId)
        return result
    }
    
    
    
}
