function moveJoint(clientID, vrep, jointHandle, jointAngleDeg)
    jointAngleRad = (jointAngleDeg*pi)/180;
    res = vrep.simxSetJointTargetPosition(clientID,jointHandle,jointAngleRad,vrep.simx_opmode_oneshot_wait);
end