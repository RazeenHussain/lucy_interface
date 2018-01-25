function setJointAngle(clientID, vrep, jointHandle, jointAngleDeg)
    jointAngleRad = (jointAngleDeg*pi)/180;
    res = vrep.simxSetJointPosition(clientID,jointHandle,jointAngleRad,vrep.simx_opmode_oneshot_wait);
end