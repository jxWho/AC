import os
def mapData(dataFolderPath, storagePlace, dialect):
    dataFolderPath = os.path.abspath(dataFolderPath)
    folder_queue = []
    folder_queue.append(dataFolderPath)
    fileList = []
    speakerCnt = 0
    languages = {}

    dialects = dialect.split('|')
    dialectsMapping = {}
    dialectFile = open(os.path.join(storagePlace, 'dialects.txt'), "w")
    for i, x in enumerate(dialects):
        dialectsMapping[x] = str(i)
        dialectFile.write(x + ':' + str(i) + '\n')

    dialectFile.close()

    writeFile = open(os.path.join(storagePlace, 'map.scp'), 'w')

    while len(folder_queue) > 0:
        currentFolerPath = folder_queue[0]
        folder_queue.remove(currentFolerPath)
        subFolders = os.listdir(currentFolerPath)
        if 'etc' in subFolders and 'wav' in subFolders:
            # This is a folder with sound files
            etcFolderPath = os.path.join(currentFolerPath, 'etc')
            README = os.path.join(etcFolderPath, 'README')
            wavFolderPath = os.path.join(currentFolerPath, 'wav')
            prefix = "Pronunciation dialect:"
            for line in open(README):
                if prefix in line:
                    k = line.split(':')[1].strip()
                    if dialect == 'ALL' or k in dialects:
                        for sound in os.listdir(wavFolderPath):
                            if sound.find(".wav") == -1:
                                continue
                            temp = str(speakerCnt) + '|' + dialectsMapping[k]\
                                    + ':' + os.path.join(wavFolderPath, sound)
                            fileList.append(temp)
                            writeFile.write(temp + '\n')

                        speakerCnt += 1

                    languages[k] = languages.get(k, 0) + 1


        else:
            # checking sub-folders
            for subFolder in subFolders:
                subFolder = os.path.join(currentFolerPath, subFolder)
                if os.path.isdir(subFolder):
                    folder_queue.append(subFolder)

    writeFile.close()
    print len(fileList)
    return fileList
