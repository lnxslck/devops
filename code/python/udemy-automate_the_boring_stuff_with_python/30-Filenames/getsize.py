#! python3

import os

totalSize = 0

for filename in os.listdir('/home/bruno/Downloads'):
	if not os.path.isfile(os.path.join('/home/bruno/Downloads', filename)):
		continue
	totalSize = totalSize + os.path.getsize(os.path.join('/home/bruno/Downloads', filename))

print(totalSize)