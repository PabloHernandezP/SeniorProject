import model
import angle
import distance

# location of config file and novel video
config_path = 'C:/Users/14074/OneDrive/Desktop/CIS4914/SeniorProject/VideoPipeline/Horse_Skeleton-M Smythe-2022-05-17/config.yaml'
video_path = 'C:/Users/14074/OneDrive/Desktop/CIS4914/SeniorProject/VideoPipeline/InputOutput/C0213.mp4'
data_path = 'C:/Users/14074/OneDrive/Desktop/dlc output/C0213DLC_resnet50_Horse_SkeletonMay17shuffle1_1030000.h5'

# analyze video at video_path using trained model indicated by config_path 
model.analyzeNovelVideo(config_path, video_path)

# extract gait parameters using results
df = model.getVideoData(data_path)
print(df)