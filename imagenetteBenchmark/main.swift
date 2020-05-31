//
//  main.swift
//  imagenetteBenchmark
//
//  Created by Ayush Agrawal on 28/05/20.
//  Copyright © 2020 Ayush Agrawal. All rights reserved.
//

import Foundation
import Benchmark

print("Hello, World!")

let classNames = ["n01440764", "n02102040", "n02979186", "n03000684", "n03028079",
"n03394916", "n03417042", "n03425413", "n03445777", "n03888257"]

let datasetPath = "/Users/ayush517/subsetImagenette"

//let newTrainPaths = create320Dataset(datasetType: "train", numImagesPerClass: 100)
//let newValPaths = create320Dataset(datasetType: "val", numImagesPerClass: 100)

//let data = loadSTBImageImagenetteTrainingFiles(imageSize: 160)
//let data = loadPILImagenetteTrainingFiles(imageSize: 160)

//print(data.0.shape)
//print(data.1.shape)

//benchmark("160 px PIL Image Load operation", settings: .iterations(5)) {
//    let _ = loadPILImagenetteTrainingFiles(imageSize: 160)
//}

//benchmark("320 px PIL Image Load operation", settings: .iterations(5)) {
//    let _ = loadPILImagenetteTrainingFiles(imageSize: 320)
//}

//benchmark("160 px STBImage Load operation", settings: .iterations(5)) {
//    let _ = loadSTBImageImagenetteTrainingFiles(imageSize: 160)
//}

benchmark("320 px STBImage Load operation", settings: .iterations(5)) {
    let _ = loadSTBImageImagenetteTrainingFiles(imageSize: 320)
}

Benchmark.main()

// --------- Path Processing Functions --------------

func getURLS(datasetType: String, imageSize: Int32) throws -> [URL] {
    let path = datasetPath+String(imageSize)+"/\(datasetType)"
    let url = URL(string: path)!
    let dirContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles])
    var urls: [URL] = []
    for directoryURL in dirContents {
        let subdirContents = try FileManager.default.contentsOfDirectory(
            at: directoryURL, includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles])
        urls += subdirContents
    }
    return urls
}

func getTrainPaths(imageSize: Int32) throws -> [String] {
    let urls = try getURLS(datasetType: "train", imageSize: imageSize)
    return urls.map{$0.absoluteString.components(separatedBy: "//")[1]}
}

func getValPaths(imageSize: Int32) throws -> [String] {
    let urls = try getURLS(datasetType: "val", imageSize: imageSize)
    return urls.map{$0.absoluteString.components(separatedBy: "//")[1]}
}
