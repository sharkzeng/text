//
//  MerchantServiceConfig.swift
//  DMASDK
//
//  Created by Zhangxz& on 2019/3/26.
//  Copyright © 2019 Zhangxz&. All rights reserved.
//

import UIKit
import Foundation


public let assetManagementUrl = URL(string: "http://192.168.1.104:8545")


public let platformWallet = "0x51f56e19f4e2c71fc5ffa4cd25520480c7708030"
public let isBurn = true
public let defaultGasPrice = "20000000000"
public let defaultGasLimit = "7002513"
public let firstExpenses = "5"
public let secondExpenses = "1"

public let API_URL = "http://192.168.1.104:9994/api/1.0/"
public let merchainContract = "contract/"
public let merchainSave = "save.do"
public let merchainDeploy = API_URL+merchainContract+merchainSave


public let merchainAsset = "asset/"
public let merchainsaveAsset = "saveAssets.do"
public let merchainMint = API_URL+merchainAsset+merchainsaveAsset

public let merchainshelfRecords = "shelfRecords/"
public let merchainsaveshelfRecords = "saveShelfRecords.do"
public let merchainSale = API_URL+merchainshelfRecords+merchainsaveshelfRecords

public let merchainorderInfo = "orderInfo/"
public let merchainorderInfoDetails = "orderInfoDetails/"

public let merchainosaverderInfo = "saveOrder.do"
public let merchainosaverderInfoJson = "info.json"
public let merchainosaverderInfoList = "all.list"
public let merchainopendingList = "pending.list"

public let merchaincreateorderInfo = API_URL+merchainorderInfo+merchainosaverderInfo
public let merchaingetorderInfo = API_URL+merchainorderInfo+merchainosaverderInfoJson
public let merchaingetorderInfoList = API_URL+merchainorderInfo+merchainosaverderInfoList
public let merchaingetorderInfoDetails = API_URL+merchainorderInfoDetails+merchainosaverderInfoList


public let merchaingetmyContract = API_URL+merchainContract+merchainosaverderInfoList
public let merchaingetshelfRecords = API_URL+merchainshelfRecords+merchainosaverderInfoList
public let merchaingetshelfRecordsDetails = API_URL+merchainshelfRecords+merchainosaverderInfoList

public let merchaingetshelfRecordsPendingDetails = API_URL+merchainshelfRecords+merchainopendingList


