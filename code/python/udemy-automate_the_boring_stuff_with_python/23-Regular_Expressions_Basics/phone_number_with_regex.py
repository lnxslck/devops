import re

message = 'Call me 415-123-1234 tomorrow, or at 123-321-3214 at my office.'

phoneNumRegex = re.compile(r'\d\d\d-\d\d\d-\d\d\d\d') # search for digits \d
mo = phoneNumRegex.search(message)
print(mo.group())
