#  .pem file Permission Denied

```bash
*****************************
UN-PROTECTED PRIVATE KEY FILE
*****************************
Permissions are too open.
```
While connecting with AWS through any SSH client, we usually get this error


## Solution:

```pem
chmod 400 your_Key.pem
```
Now, ssh again.

**Boom!**
