import deeplabcut as dlc
import pandas as pd

def analyzeNovelVideo(config_path, video_path):    
    dlc.analyze_videos(config_path, [video_path], )

def getVideoData(file_path):
    return pd.read_hdf(file_path)