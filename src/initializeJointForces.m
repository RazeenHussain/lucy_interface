function initializeJointForces(clientID, vrep, joints)
    for j=1:1:14
        res = vrep.simxSetJointForce(clientID, joints(j), 2.5, vrep.simx_opmode_oneshot_wait);
    end
end