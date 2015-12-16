#!/usr/bin/python
import mapping
import prepare_data
dataFolderPath = '../voxforge/'
storagePlace = '../output'
dialect = \
    "American English|British English|European English|Canadian English"

fileList = mapping.mapData(dataFolderPath, storagePlace, dialect)

prepare_data.prepareData(dataFolderPath, storagePlace, fileList, \
                                                    int(len(fileList) * 1) )
