

# Links

Track connections or dependencies between files/folders across different branches of your filesystem! For example, I mostly use this to keep track of places where I've taken notes for a particular project or on a particular reading that I anticipate I'll need to reference in another context.


### Install (unix)

* put repo somewhere
* install [jq](https://stedolan.github.io/jq/)
* copy 'links' to search path e.g. /usr/local/bin
* 'links config'

portability notes...
* 'links-print.sh' uses 'gsed', which is GNU sed via homebrew. might be able to change this to 'sed' depending on OS...
* 'links-open.sh' only considers (and configures for) .txt and .pdf files, so this could bear extending

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
