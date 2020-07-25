

# Links

Track connections or dependencies between files/folders across different branches of your filesystem! For example, I mostly use this to keep track of places where I've taken notes for a particular project or on a particular reading that I anticipate I'll need to reference in another context.


### Install (unix)

* put repo somewhere
* copy 'links' to search path e.g. /usr/local/bin
* 'links config'


### subcommands:

```
config
crt <source> <target>
edit <source> <target>
rm <source> <target>
get <path> [-i | -o]
- if path omitted or given w/ trailing slash, prints all links
   in current or given directory
- otherwise, prints links to/from <path>
- also accepts 'get <key> ...' to match filenames in ./.links
open <key>
- open file referenced in ./.links
- search key must yield unique match
```
