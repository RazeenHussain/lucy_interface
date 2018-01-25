[lucyID, vrep] = setupConnection;
if (lucyID > -1)
    vrep.simxAddStatusbarMessage(lucyID,'Hello V-REP!',vrep.simx_opmode_oneshot);
    disp('Connected to remote API server');
    lucyJoints = getJointHandles(lucyID, vrep);
    pause(2);
    while(1)
        initializeJointAngles(lucyID, vrep,lucyJoints);
    end
    vrep.simxGetPingTime(lucyID);     % Before closing the connection to V-REP, make sure that the last command sent out had time to arrive. You can guarantee this with (for example):
    vrep.simxFinish(lucyID);    % Now close the connection to V-REP:    
else
    disp('Failed connecting to remote API server');
end
vrep.delete(); % call the destructor!
disp('Program ended');
