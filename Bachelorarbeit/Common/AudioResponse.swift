//
//  AudioResponse.swift
//  Bachelorarbeit
//
//  Created by JT X on 16.08.22.
//

import Foundation


struct audioResponse: Codable{
    let id: String?
    let creationdate : String?
    let updatedate: String?
    let pid: String?
    let orgtext: String?
    let assessment: String?
    let priority: Int?
    let status: String?
    let code: String?
    let startdate: String?
    let enddate : String?
   // let log: Array<Any>
    let comment: String?
    let tool_id: String?
    let admin_comment: String?
    let worker_id : String?
    let nexttask_id: String?
    let type: String?
}

