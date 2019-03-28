//
//  IpfsService.swift
//  DMASDK
//
//  Created by Zhangxz& on 2019/3/25.
//  Copyright © 2019 Zhangxz&. All rights reserved.
//

import UIKit

public class IpfsService: NSObject {
    public var url:String?
    public var port:String?
    public  func add(filePath:String) -> String {
        let ipfs = IpfsStorage()
        ipfs.url = url
        ipfs.port = port
        return ipfs.add(filePath: filePath)
    }
    public   func add(fileData:Data) -> String {
        let ipfs = IpfsStorage()
        ipfs.url = url
        ipfs.port = port
        return ipfs.add(fileData:fileData)
    }
    public   func getBytes(hash:String) -> Array<UInt8> {
        let ipfs = IpfsStorage()
        ipfs.url = url
        ipfs.port = port
        return ipfs.getBytes(hash:hash)
    }
    public  func getString(hash:String) -> String{
        let ipfs = IpfsStorage()
        ipfs.url = url
        ipfs.port = port
        return getString(hash:hash)
    }
    
}
