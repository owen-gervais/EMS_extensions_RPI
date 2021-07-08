module ("templates.PiTemplate", thingworx.template.extend)
properties.bed_temperature={baseType="NUMBER", pushType="ALWAYS", value=0, handlers="test"}
properties.extr_temperature={baseType="NUMBER", pushType="ALWAYS", value=0, handler="test"}
properties.remote_photo={baseType="IMAGE", pushType="ALWAYS", value =0}

serviceDefinitions.GetSystemProperties(
    output { baseType="BOOLEAN", description="" },
    description { "updates properties" }
)

--serviceDefinitions.Jog(
--    input {name="axis", baseType="STRING", description="movement axis (x,y,z)"},
--    input {name="dist", baseType="NUMBER", description="relative jog distance (mm)"},
--    output { baseType="BOOLEAN", description="" },
--    description { "jogs printer" }
--)

serviceDefinitions.uploadGCODE(
    input {name="filename", baseType="STRING", description="filename in file repository"},
    output {baseType="BOOLEAN", description=""},
    description {"add custom gcode to text box and it will send to your 3D printer"} 
)


serviceDefinitions.downloadSTL(
    input {name="onshapeURL", baseType="STRING", description="filename in file repository"},
    output {baseType="BOOLEAN", description=""},
    description {"slice new stl"}
)


services.downloadSTL = function(me, headers, query, data)
    local rootPaths = "python3 /home/pi/testingSTL.py \""
    local url = data.onshapeURL
    print(url)
    print(rootPaths .. url .. "\"")
    local uploadCmd = io.popen(rootPaths .. url .. "\"")
    return 200, true
end


services.uploadGCODE = function(me, headers, query, data)
    local rootPath = "/usr/bin/python /home/pi/testingFileDownload.py \""   
    local filename = data.filename
    local uploadCmd = io.popen(rootPath .. filename .. "\"")
    return 200, true
end


--services.Jog = function(me, headers, query, data)
--   local rootPath = "/usr/bin/python /home/pi/homeTest.py "
--   local axis = data.axis
--   local amnt = data.dist 
--   local jogCmd = io.popen(rootPath .. amnt .. " " .. axis)
--   return 200, true
--end

services.GetSystemProperties = function(me, headers, query, data)
    queryHardware()
--  if properties are successfully updated, return HTTP 200 code with a true service return value
    return 200, true
end

function queryHardware()
    local tempCmd = io.popen("/usr/bin/python /home/pi/tempStatus.py")
    local s = tempCmd:read("*a")
    local d = string.match(s,"BedTemp=(%d+\.%d+)");
    properties.bed_temperature.value = d
    properties.bed_temperature.time = data.time;
    s = string.match(s,"ExtrTemp=(%d+\.%d+)");
    properties.extr_temperature.value = s
    properties.extr_temperature.time = data.time;
	-- UpdatePropertyValues("bed_temperature", s);
    local photoCmd = io.popen("/usr/bin/python /home/pi/encodeImage.py")
    s = photoCmd:read("*a")
    properties.remote_photo.value = s
end

tasks.refreshProperties = function(me)
    log.trace("[PiTemplate]","~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ In tasks.refreshProperties~~~~~~~~~~~~~ ")
    queryHardware()
end


