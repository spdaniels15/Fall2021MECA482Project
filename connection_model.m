function connection_model()
    disp('Program started');
    sim =remApi('remoteApi');    % using the prototype file (remoteApiProto.m)
    sim.simxFinish(-1);         % just in case, close all opened connections
    clientID = sim.simxStart('127.0.0.1',19999,true,true,5000,5); % Localhost
   
    if (clientID>-1)
        disp('Connected to remote API server');
        % enable the synchronous mode on the client:
 
        %% Initialize the measurement state
        [res retInts retFloats retStrings retBuffer] = sim.simxCallScriptFunction(clientID,'remoteApiCommandServer',...
            sim.sim_scripttype_childscript,'init_measure_state',[],[],'',[],sim.simx_opmode_blocking);
        
        for i_counter=1:1:500
            % Measure
            [res retInts retFloats retStrings retBuffer] = sim.simxCallScriptFunction(clientID,'remoteApiCommandServer',...
                sim.sim_scripttype_childscript,'measure_state',[],[],'',[],sim.simx_opmode_blocking);
            disp(retFloats)
            % Send command
            Vm = 5.0; % Apply voltage
            [res retInts retFloats retStrings retBuffer] = sim.simxCallScriptFunction(clientID,'Revolute',...
            sim.sim_scripttype_childscript,'input_voltage',[],[Vm],[],'',sim.simx_opmode_blocking);

        end

        %% Stop Simulation
        sim.simxStopSimulation(clientID,sim.simx_opmode_blocking);
        
    else
        disp('Failed connecting to remote API server');
    end
    %% Destroy the object
    sim.delete();    
    
    disp('End of Connection Test');
end