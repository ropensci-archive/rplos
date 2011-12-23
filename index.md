---
layout: base
title: rplos
subtitle: Wrapper for the PLoS Journals API
---

{% capture left %}

rplos is a set of functions for searching and fetching data from all of the Public Library of Science (PLoS) journals.  You can:

* Search and pull down full text of PLoS papers
* XXX
* XXXX

XXXX

* totally consistent names, arguments and outputs
* convenient parallelisation through the foreach package
* input from and output to data.frames, matrices and lists
* progress bars to keep track of long running operations
* built-in error recovery, and informative error messages
* labels that are maintained across all transformations

Considerable effort has been put into making plyr fast and memory efficient, and in many cases plyr is as fast as, or faster than, the built-in functions.

If you are interested in the watching the development of rplos, please see the [development site](https://github.com/ropensci/rplos) on [github](http://github.com). If you've discovered any bugs in the rplos package, you have bug reports or feature requests, or want to collaborate, please email us: [ropensci@gmail.com](mailto:ropensci@gmail.com).

{% endcapture %}


{% capture right %}

## More

Visit out website at [rOpenSci](http://ropensci.org/)

## Learning more

The best place to start is the article published in JSS: [The Split-Apply-Combine Strategy for Data Analysis](http://www.jstatsoft.org/v40/i01).

You might also find [the notes](09-user/) from a tutorial I offered at User! 2009 useful.

You are welcome to ask rplos questions on R-help, but if you'd like to participate in a more focussed mailing list, please sign up for the manipulatr mailing list:

{% endcapture %}

<div class="ten columns">
  {{ left | markdownify }}
</div>
<div class="five columns offset-by-one">
  {{ right | markdownify  }}
</div>