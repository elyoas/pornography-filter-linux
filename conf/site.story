# This is the site level storybook

# override library functions and add your site level functions here


########################### elias ##########################
# Don't put any comments after a line
# These functions are reimplemented from [common.story]. See V5_Storyboard.pdf
# For blanket block, see [examplef1.story]



### section added on 20220627 to force doing safe search on google/ddg
# done by adding line [if(true) sslreplace] twice to below
# SSL site replace (used instead of dns kulge)
#  returns true on match and successful replacement
#function(sslreplace)
#if(fullurlin,sslreplace) return setconnectsite
#if(true) return false
###

###########################
# greylist check (greylists no longer surpass bannedurllist; but it does not work on exception lists):

#  returns true on match
function(greycheck)
if(sitein, bannedsitelistelias) return setblock
if(urlin, banned) return setblock
if(sitein, banned) return setblock
if(urlin, grey) return setgrey


#########################################
# same as above but on exception lists (banned lists override exception lists)

# Exception check
#  returns true on match (elias: added 2nd & rd lines)
function(exceptioncheck)
if(sitein, bannedsitelistelias) return setblock
if(true) sslreplace
if(urlin, banned) return setblock
if(sitein, banned) return setblock
if(urlin, exception) return setexception
if(refererin,refererexception) return setexception
if(headerin, exceptionheader) return setexception
if(useragentin, exceptionuseragent) return setexception
ifnot(urlin,embededreferer) return false
if(embeddedin,refererexception) return setexception

# SSL Exception check
#  returns true on match (elias: added 2nd & rd lines)
function(sslexceptioncheck)
if(sitein, bannedsitelistelias) return setblock
if(true) sslreplace
if(urlin, banned) return setblock
if(sitein, banned) return setblock
if(sitein, exception) return setexception
if(headerin, exceptionheader) return setexception
if(useragentin, exceptionuseragent) return setexception
if(true) return false

#########################################

function(checkblanketblock) # L267 common.story (how to use it?)

function(sslcheckblanketblock)

# Banned list check # L187 common.story
#  returns true on match
function(bannedcheck)
if(true) returnif checkblanketblock
if(sitein, bannedsitelistelias) return setblock
if(urlin, banned) return setblock
#ifnot(urlin,exceptionfile) returnif checkurlextension # ELIAS!!!! ERROR HERE!; instead use from older file the following line: CONFIRMED 20220616
if(urlin,bannedextension) return setblock
if(useragentin, banneduseragent) return setblock
if(headerin, bannedheader) return setblock

#########################################

#Examples:-

# General:-

# If you do not use local files then uncomment the following lines:-
function(localcheckrequest)
function(localsslrequestcheck)
function(localgreycheck)
function(localbannedcheck)
function(localexceptioncheck)
function(localsslcheckrequest)

# To disable checks on embedded urls then uncomment:-
#function(embeddedcheck)

# If you have av scanning enabled then comment out next 2 lines:-
function(checknoscanlists)
function(checknoscantypes)

# If you only want exception extensions/mime filetypes to be allowed
# then uncomment the following 4 lines
#function(checkfiletype)
#if(mimein, exceptionmime) return false
#if(extensionin, exceptionextension) return false
#if(true) return setblock

# To override the nolog lists temporarily
# then uncomment the following two lines
#function(checklogging)
#if(true) return true


# For ICAP mode:-

# If you are using squid bump for https interception uncomment
# next 2 lines
#function(icapsquidbump)
#if(true) return true
