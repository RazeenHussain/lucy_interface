function jointAngleDeg = getJointAngle(clientID, vrep, jointHandle)
    [res, jointAngleRad] = vrep.simxGetJointPosition(clientID,jointHandle,vrep.simx_opmode_oneshot_wait);
    jointAngleDeg = (jointAngleRad*180)/pi;
end