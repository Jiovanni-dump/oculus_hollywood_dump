#!/vendor/bin/sh

if [ -f /persist/calibration/screen_offset.json ]
then
    mv /persist/calibration/screen_offset.json /persist/calibration/display/screen_offset.json
fi
