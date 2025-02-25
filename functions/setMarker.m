function [] = setMarker(expinfo, marker_id, wait_time)
    if ~exist('wait_time', 'var')
        wait_time = 0.1;
    end

    if expinfo.send_markers
        io64(expinfo.ioObj, expinfo.PortAddress, marker_id);
        WaitSecs(wait_time);
        io64(expinfo.ioObj, expinfo.PortAddress,0);% Stop Writing to Output Port

        disp(strcat('Set Marker with ID: ', num2str(marker_id)));
    else
        disp(strcat('No Marker: ', num2str(marker_id), ' set. Running in TESTING mode'));
    end
end