//
//  attiwari.swift
//  imagenetteBenchmark
//
//  Created by Ayushi Tiwari on 03/06/20.
//  Copyright © 2020 Ayushi Tiwari. All rights reserved.
//  All code in this file is written by Ayushi Tiwari and belongs to her. Copied here just for testing and debugging purposes.
//
/**
import Foundation
import TensorFlow
import PythonKit

let random = Python.import("random")
let glob = Python.import("glob")
let pilImage = Python.import("PIL.Image")
let np = Python.import("numpy")
let pil = Python.import("PIL")

func getTensor(fromPath: String) -> (Tensor<Float>, Int32) {
    let img = pilImage.open(fromPath)
    let image = np.array(img, dtype: np.float32) * (1.0 / 255)
    var imageTensor = Tensor<Float>(numpy: image)!
    imageTensor = imageTensor.expandingShape(at: 0)
    imageTensor = _Raw.resizeArea(images: imageTensor , size: [160, 160])
    
    var label: Int32 = 0

    for i in 0..<10 {
        if fromPath.contains(classNames[i]) {
            label = Int32(i)
            break
        }
    }
    
    return (imageTensor, label)
}

func loadDataset(datasetType: String) -> (Tensor<Float>, [Int32]) {
    
    let fromList = glob.glob("/Users/ayush517/subsetImagenette160/\(datasetType)/*/**.JPEG")
    var labels: [Int32] = []
    let imagePath = String(fromList[0])!
    
    var imageTensor: Tensor<Float>
    
    let data = getTensor(fromPath: imagePath)
    imageTensor = data.0
    labels.append(data.1)
    
    for file in fromList[1..<fromList.count] {
        
        let imagePath = String(file) ?? ""
        let data = getTensor(fromPath: imagePath)
        let tensor = data.0
        labels.append(data.1)
        imageTensor = Tensor(concatenating: [imageTensor, tensor], alongAxis: 0)
        
    }
    return (imageTensor, labels)
}

func loadImagenetteTrainingFiles() -> (Tensor<Float>, [Int32]) {
    return loadDataset(datasetType: "train")
}

func loadImagenetteTestFiles() -> (Tensor<Float>, [Int32]) {
    return loadDataset(datasetType: "val")
}

 
 import Foundation
 import TensorFlow
 import PythonKit


let random = Python.import("random")
let glob = Python.import("glob")
let pilImage = Python.import("PIL.Image")
let np = Python.import("numpy")
let pil = Python.import("PIL")
let os = Python.import("os")
let osPath = Python.import("os.path")

 let datasetPath = "/Users/ayushitiwari/Downloads/imagenette2-160"
 let savedImagePath = "/Users/ayushitiwari/Downloads/imagenette160New"
 var numberOfImages = 0

 func imageDataset(datasetType: String, numImagesPerClass: Int32) -> PythonObject{
     
     random.seed(42)
     //counter to count all the images
     var numberOfImages: Int32 = 0
     let imageList: PythonObject = []
     
     for name in classNames[0..<10] {
         let path = datasetPath+"/\(datasetType)/\(name)"
        //print(path)
         let files = glob.glob(path+"/*.JPEG")
        
        let newFolder = savedImagePath+"/\(datasetType)/\(name)"
        //print(newFolder)
        
        numberOfImages = 0

         for file in files {
             
             do
             {
                 try FileManager.default.createDirectory(atPath: newFolder, withIntermediateDirectories: true, attributes: nil)
             }
             catch let error as NSError
             {
                 NSLog("Unable to create directory \(error.debugDescription)")
             }

            let imagePath = String(file) ?? ""
            print(imagePath)
            let image = pilImage.open(imagePath)
             let filename = osPath.basename(imagePath)
            print(filename)
            //print(filename)
             let filePath = "\(newFolder)/\(filename)"
            print(filePath)
             
             if (Python.len(image.getbands()) == 3){
                 numberOfImages += 1
                 image.save(filePath)
                 imageList.append(filePath)
             }
             
             if (numberOfImages == numImagesPerClass){
                 break
             }
         }
         
     }
     return imageList
     
 }
 */*/*/*/

import TensorFlow
import Foundation
import libjpeg

public func tjJPEGLoadCompressedImage2( filename: UnsafePointer<Int8>?, width: inout Int32, align: inout Int32,  height: inout Int32, pixelFormat: inout Int32, inSubsamp: Int32, flags: Int) -> UnsafeMutablePointer<UInt8>? {
    
    let scalingFactor = tjscalingfactor( num: 1, denom: 1 )
    let inFormat = UnsafeMutablePointer<Int8>(mutating: "jpg")
    let outFormat = UnsafeMutablePointer<Int8>(mutating: "jpg")
  
    pixelFormat = -1
 
    /* Read the JPEG file into memory. */
    var jpegFile = fopen(filename, "rb")
    fseek(jpegFile, 0, SEEK_END)
    let size = ftell(jpegFile)
    fseek(jpegFile, 0, SEEK_SET)
    let jpegSize = CUnsignedLongLong(size)
    var jpegBuf = (tjAlloc(Int32(jpegSize)))
    fread(jpegBuf, Int(jpegSize), 1, jpegFile)
    fclose(jpegFile)
    jpegFile = nil
    
    var tjInstance = tjInitDecompress()
    tjDecompressHeader(tjInstance, jpegBuf, UInt(jpegSize), &width, &height)
    
    let imgBuf = tjAlloc(3 * width * height)
    tjDecompress2(tjInstance, jpegBuf, UInt(jpegSize), imgBuf, width, 0, height, 0, 0)
    tjFree(jpegBuf)
    jpegBuf = nil
    tjDestroy(tjInstance)
    tjInstance = nil
    
    return imgBuf
}
