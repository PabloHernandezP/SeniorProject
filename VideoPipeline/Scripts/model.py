import deeplabcut as dlc
import pandas as pd

def analyzeVideo(config_path, video_path):    
    dlc.analyze_videos(config_path, [video_path],)
    
def fetchOutput(output_path):
    return pd.read_hdf(output_path)