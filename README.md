# imagenetteBenchmark

PIL: https://github.com/python-pillow/Pillow  
STBImage: https://github.com/nothings/stb  
JPEGTurbo: https://github.com/libjpeg-turbo/libjpeg-turbo  
JPEG Library: https://github.com/kelvin13/jpeg  

Creates a subset of 1000 training images by randomly choosing 100 images from each class of Imagenette with a seed value of 42.  

*----*

1.) First we get the paths of images in the datasetType  
2.) Load the image using that library  
3.) Convert and resize it to appropriate tensor  
4.) Calculate its label  
5.) Append it to final list lof tensors and labels.  

Benchmark Results

| size                    |name                    |  time            |  std       |  iterations  |
|-------------|:------------:|:------------------:|:--------------:|:---------------:|
|   160 x 160       | PIL Image Load operation | 50212789562.0 ns (50 s) | ±   2.98 %    |       5  |
|   320 x 320       | PIL Image Load operation | 131345557481.0.0 ns (131 s) | ±   7.21 %    |       5  |
|   160 x 160       | STBImage Image Load operation | 49629429859.0 ns (49.6 s) | ±   4.24 %    |       5  |
|   320 x 320       | STBImage Image Load operation | 126589557798.0 ns (126 s) | ±   13.58 %    |       5  |
|   160 x 160       | JPEGTurbo Load operation |   55647521090.5 ns (55 s) |  ±   2.51 %     |          5
|   320 x 320       | JPEGTurbo Load operation |  139024297588.0 ns (139 s) |  ±   2.66 %      |         5
|   160 x 160       | JPEG Load operation  |  117379591932.5 ns (117 s) |  ±   6.97 %     |         5
|   320 x 320       | JPEG Load operation  |  349771842833.5 ns (349 s) |  ±   0.63 %    |         5

*----*


1.) First we get the paths of images in the datasetType  
2.) Load the image using that library  
3.) Convert and resize it to appropriate tensor  

New Benchmark Results

| size                    |name                    |  time            |  std       |  iterations  |
|-------------|:------------:|:------------------:|:--------------:|:---------------:|
|   160 x 160       | PIL Image Load operation | 1119275437.5 ns (1.1 s) | ±   10.5 %    |       200  |
|   320 x 320       | PIL Image Load operation | 3745457027.0 ns (3.7 s) | ±   7.97 %    |       25  |
|   160 x 160       | STBImage Image Load operation | 944071793.0 ns (0.9 s) | ±   0.74 %    |       5  |
|   320 x 320       | STBImage Image Load operation | 2840012321.0 ns (2.8 s) | ±   0.95 %    |       5  |
|   160 x 160       | JPEGTurbo Image Load operation | 748089979.5 ns (0.75 s) | ±   2.85 %   |       50  |
|   320 x 320       | JPEGTurbo Image Load operation | 1985243526.50 ns (2.0 s) | ±   3.11 %    |       50  |
|   160 x 160       | JPEG Image Load operation | 52044369008.0 ns (52 s) | ±   1.99 %   |       5 |
|   320 x 320       | JPEG Image Load operation | 195361269887.0 ns (195 s) | ±   1.4 %    |       5  |

