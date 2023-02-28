import numpy as np

def angle(x1, y1, x2, y2):
    # Find length of segment
    SegmentLength = np.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)
    
    # Define Local Coordinates
    LocalPSegment = np.array([x2 - x1, y2 - y1])
    
    # Make Unit Vector for Segment
    UnitLocalX = LocalPSegment / np.mean(SegmentLength)
    
    # Find Local y vector
    LocalX = np.hstack((UnitLocalX.reshape(-1, 1), np.zeros((len(UnitLocalX), 1))))
    LocalY = np.zeros((len(LocalX), 3))
    
    for i in range(len(LocalX)):
        LocalY[i] = np.cross(np.array([0, 0, 1]), LocalX[i])  # [0, 0, 1] is Local Z
    
    # Establish Global Vectors
    GlobalX = np.array([1, 0, 0])
    GlobalY = np.array([0, 1, 0])
    
    # Create Rotation Matrix
    Rotation = np.zeros((len(LocalX), 4))
    
    for i in range(len(LocalX)):
        Rotation[i] = np.array([np.dot(LocalX[i], GlobalX), np.dot(LocalY[i], GlobalX), 
                               np.dot(LocalX[i], GlobalY), np.dot(LocalY[i], GlobalY)])
    
    # Create Transformation Matrix
    jointangle = np.zeros(len(LocalX))
    
    for i in range(len(LocalX)):
        GlobalTLocal = np.array([[Rotation[i, 0], Rotation[i, 1], x1[i]], 
                                [Rotation[i, 2], Rotation[i, 3], y1[i]],
                                [0, 0, 1]])
        LocalPP2 = np.array([x2[i], y2[i], 1])
        GlobalPP2 = GlobalTLocal @ LocalPP2.reshape(3, 1)
        
        # Second Rotation Matrix
        SegmentLength2 = np.sqrt((GlobalPP2[0, 0] - x1[i]) ** 2 + (GlobalPP2[1, 0] - y1[i]) ** 2)
        LocalPSegment2 = np.array([GlobalPP2[0, 0] - x1[i], GlobalPP2[1, 0] - y1[i]])
        UnitLocalX2 = LocalPSegment2 / np.mean(SegmentLength2)
        LocalX2 = np.hstack((UnitLocalX2.reshape(-1, 1), np.zeros((len(UnitLocalX2), 1))))
        LocalY2 = np.zeros((len(LocalX2), 3))
        
        for j in range(len(LocalX2)):
            LocalY2[j] = np.cross(np.array([0, 0, 1]), LocalX2[j])  # [0, 0, 1] is Local Z
        
        Rotation2 = np.zeros((len(LocalX2), 4))
        
        for k in range(len(LocalX2)):
            Rotation2[k] = np.array([np.dot(LocalX2[k], GlobalX), np.dot(LocalY2[k], GlobalX), 
                                     np.dot(LocalX2[k], GlobalY), np.dot(LocalY2[k], GlobalY)])
        
        # Find Angle
        jointangle[i] = np.arctan2(Rotation2[i, 2], Rotation2[i, 3]) - np.arctan