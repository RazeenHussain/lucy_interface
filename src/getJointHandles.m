function joints = getJointHandles(clientID, vrep)
    [res, joints(1)] = vrep.simxGetObjectHandle(clientID,'Torso_front_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(2)] = vrep.simxGetObjectHandle(clientID,'Torso_side_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(3)] = vrep.simxGetObjectHandle(clientID,'Left_hip_front_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(4)] = vrep.simxGetObjectHandle(clientID,'Left_hip_side_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(5)] = vrep.simxGetObjectHandle(clientID,'Left_hip_vertical_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(6)] = vrep.simxGetObjectHandle(clientID,'Left_knee_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(7)] = vrep.simxGetObjectHandle(clientID,'Left_ankle_front_r',vrep.simx_opmode_oneshot_wait);
    [res, joints(8)] = vrep.simxGetObjectHandle(clientID,'Left_ankle_side_r',vrep.simx_opmode_oneshot_wait);
    [res, joints(9)] = vrep.simxGetObjectHandle(clientID,'Right_hip_front_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(10)] = vrep.simxGetObjectHandle(clientID,'Right_hip_side_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(11)] = vrep.simxGetObjectHandle(clientID,'Right_hip_zrot_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(12)] = vrep.simxGetObjectHandle(clientID,'Right_knee_joint',vrep.simx_opmode_oneshot_wait);
    [res, joints(13)] = vrep.simxGetObjectHandle(clientID,'Right_ankle_front_r',vrep.simx_opmode_oneshot_wait);
    [res, joints(14)] = vrep.simxGetObjectHandle(clientID,'Right_ankle_side_r',vrep.simx_opmode_oneshot_wait);    
end