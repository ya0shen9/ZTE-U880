# -*- coding: cp936 -*-
import os
import sys
import struct
from stat import *

def walk_dir(dir,topdown=True):
    file_list = [];
    for root, dirs, files in os.walk(dir, topdown):
        for name in files:
            file_path = root+"/"+name;
            target_file_path = file_path.replace("\\","/");
            #print target_file_path
            file_list.append(target_file_path)
    return file_list;

def makefile():
    n = len("./proprietary");
    file_list = walk_dir("./proprietary");
    for file_path in file_list:
        file_xpath = file_path[n+1:len(file_path)];
        #print file_xpath
#        source_file = "vendor/zte/u880/proprietary/"+file_xpath;
        source_file = "vendor/zte/Mu880/proprietary/"+file_xpath;
        target_file = "system/"+file_xpath;
        print "    "+source_file+":"+target_file+" \\";
        
if __name__ == '__main__':
    makefile();
