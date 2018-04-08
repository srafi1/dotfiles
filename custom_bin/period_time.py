#! /usr/bin/python2
import datetime

# period end times
end_times = [
        [ 8, 41 ],
        [ 9, 26 ],
        [ 10, 15 ],
        [ 11, 1 ],
        [ 11, 47 ],
        [ 12, 33 ],
        [ 13, 19 ],
        [ 14, 5 ],
        [ 14, 50 ],
        [ 15, 35 ]
        ]

end_times_homeroom = [
        [ 8, 40 ],
        [ 9, 25 ],
        [ 10, 9 ],
        [ 10, 25 ],
        [ 11, 10 ],
        [ 11, 54 ],
        [ 12, 38 ],
        [ 13, 22 ],
        [ 14, 6 ],
        [ 14, 50 ],
        [ 15, 35 ]
        ]

dt = datetime.datetime.now()
time_now = [ dt.hour, dt.minute ]

period = 0

def concat_time(h, m):
    return h*60 + m

now_concatted = concat_time(time_now[0], time_now[1])
school_day = now_concatted > concat_time(8, 0) and now_concatted < concat_time(15, 35)
school_day = school_day and dt.weekday() < 5
if not school_day:
    print
    exit()

while period < 10 and concat_time(end_times[period][0], end_times[period][1]) < now_concatted:
    period += 1

time_left = concat_time(end_times[period][0], end_times[period][1]) - concat_time(time_now[0], time_now[1])

print 'PD %d | %d min' % (period + 1, time_left)
