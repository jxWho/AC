#!/usr/bin/python
"""
randomly split into test data and train data
"""
import random
import sys
import os
def prepareData(dataFolderPath, storagePlace, fileList, numTest,\
                test='test.scp', train='train.scp'):
    totlFiles = len(fileList)
    if numTest > totlFiles - 1:
        print 'No enough data'
        sys.ex(1)

    mark = [0 for _ in xrange(totlFiles)]

    testFiles = []
    trainFiles = []
    testFilePointer = open(os.path.join(storagePlace, 'test.scp'), "w")
    trainFilePointer = open(os.path.join(storagePlace, 'train.scp'), "w")

    cnt = 0
    while cnt < numTest:
        while True:
            index = random.randint(0, totlFiles-1)
            if mark[index] == 0:
                line = fileList[index].split('|')[1]
                testFiles.append( line )
                if cnt < numTest - 1:
                    testFilePointer.write( line + '\n' )
                else:
                    testFilePointer.write(line)
                mark[index] = 1
                break
        cnt += 1

    firstFlag = False
    for i in xrange(totlFiles):
        if mark[i] == 0:
            line = fileList[i].split('|')[1]
            trainFiles.append( line )
            if firstFlag is False:
                trainFilePointer.write( line )
                firstFlag = True
            else:
                trainFilePointer.write( '\n' + line )


    testFilePointer.close()
    trainFilePointer.close()
