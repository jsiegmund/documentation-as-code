.. sample-docs-reST documentation master file, created by
   sphinx-quickstart on Thu Jan  2 11:33:10 2020.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to sample-docs-reST's documentation!
============================================

This sample repository combines document generation based on Markdown and reStructuredText 
with diagram generation based on C4 PlantUML. The end result is a fully generated static HTML 
website which can be very easily pushed to and hosted on an Azure storage account. 

The entire process can be included in a build pipeline which triggers upon a commit on 
the repository where you host these files.


.. toctree::
   :maxdepth: 2
   :caption: About:

   about.rst


.. toctree::
   :glob:
   :maxdepth: 2
   :caption: Diagrams:

   diagrams/*


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`