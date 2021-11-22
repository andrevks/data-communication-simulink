
    function addCookies(record)
        % Add cookies in Response message in history record
        % to the map entry for the host to which the request was directed.
        %
        ahost = record.URI.Host; % the host the request was sent to
        cookieFields = record.Response.getFields('Set-Cookie');
        if isempty(cookieFields)
            return
        end
        cookieData = cookieFields.convert(); % get array of Set-Cookie structs
        cookies = [cookieData.Cookie]; % get array of Cookies from all structs
        try
            % If info for this host was already in the map, add its cookies to it.
            ainfo = infos(ahost);
            ainfo.cookies = [ainfo.cookies cookies];
            infos(char(ahost)) = ainfo;
        catch
            % Not yet in map, so add new info struct.
            infos(char(ahost)) = struct('cookies',cookies,'uri',[]);
        end
    end
