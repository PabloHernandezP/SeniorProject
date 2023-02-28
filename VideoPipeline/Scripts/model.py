import deeplabcut as dlc
import pandas as pd

# sample_config_path = 'C:/Users/14074/OneDrive/Desktop/CIS4914/SeniorProject/VideoPipeline/Horse_Skeleton-M Smythe-2022-05-17/config.yaml'
# sample_video_path = 'C:/Users/14074/OneDrive/Desktop/CIS4914/SeniorProject/VideoPipeline/InputOutput/C0213.mp4'
# sample_data_path = 'C:/Users/14074/OneDrive/Desktop/dlc output/C0213DLC_resnet50_Horse_SkeletonMay17shuffle1_1030000.h5'

def analyzeNovelVideo(config_path, video_path):    
    dlc.analyze_videos(config_path, [video_path], )
    
def getVideoData(file_path):
    return pd.read_hdf(file_path)