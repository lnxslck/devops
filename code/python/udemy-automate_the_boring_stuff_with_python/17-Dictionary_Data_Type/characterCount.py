import pprint

message = 'It was a bright cold day in April, and the clocks were striking thirteen.'
count = { } # 'r': 12 r appears 12 times

for character in message.upper():
    count.setdefault(character, 0)
    count[character] = count[character] + 1

pprint.pprint(count)
rjtext = pprint.pformat(count)
print(rjtext)
