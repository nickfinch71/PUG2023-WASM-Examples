
# Function to extract all propertis form  localJvm.properties
# set _jvmArgs value
getJvmScriptProperities() {
    _propfile="${pasoebase}/conf/localJvm.properties"
    _jvmArgs=""
    if [[ -f $_propfile ]] ; then
        while IFS= read -r _line
        do
            # display line or do somthing on $line
            _nline=`echo $_line | sed 's/ *$//g'`
            if ! [[ $_nline == "#"* ]] ; then 
            _jvmArgs="$_jvmArgs $_nline"
            fi
        done <"$_propfile"
    fi
}

findJar() {
    jarName=$1
    jars=`ls $commonLibBase/$jarName-[0-9\.]*\.jar 2>/dev/null`
    if [ "$jars" = "" ]; then
        jars=`ls $commonLib/$jarName-[0-9\.]*\.jar`
    fi
    jars=`echo "$jars" |  tr "\n" " "`
for ff in  $jars; do
  jar=$ff 
done

}

dbg=""
javahome=""
tmpdir=""
pasoepid=""
pasoehome=""
pasoebase=""


scriptPath=`dirname $0`
if [ ! "$dbg" = "" ]; then
	echo "scriptPath:  $scriptPath"
fi

#get environment parameters using tcman.sh 
envVars=`exec sh $scriptPath/tcman.sh env  javahome tmpdir pid home base`
envVars=`echo "$envVars" |  tr "\n" " "`

for val in  $envVars; do
if [ "$javahome" = "" ]; then	javahome="$val";   else
if [ "$tmpdir" = "" ]; then 	tmpdir="$val";  else
if [ "$pasoepid" = "" ]; then 	pasoepid="$val"; else
if [ "$pasoehome" = "" ]; then 	pasoehome="$val"; else
 pasoebase="$val";  
fi  fi  fi fi	
done
if [ ! "$dbg" = "" ]; then
	echo "javahome: $javahome"
	echo "tmpdir: $tmpdir"
	echo "pasoepid: $pasoepid"
	echo "pasoehome: $pasoehome"
fi


# Get parameters
command=""
needpw="yes"
args=""
if [ $# -le 1 ]; then
    needpw="no"
fi

while [ $# -gt 0 ]
do
  if [ "$command" = "" ]; then
    command=$1
  fi
  if [ "$1" = "-password" ]; then
    needpw="no"
  fi
  args="$args $1"
  shift
done

if [ "$command" = "help" ]; then
    needpw="no"
fi

if [ ! "$dbg" = "" ]; then
	echo "args:   $args"
fi

commonLib="$pasoehome/common/lib"
commonLibBase="$pasoebase/common/lib"
binDir="$pasoehome/bin"

# get $_jvmArgs
_jvmArgs=""
getJvmScriptProperities 



findJar "oesectool"
oesectoolJar=$jar

findJar "httpclient"
httpclientJar=$jar 

findJar "jackson-annotations"
jacksonAnnotationsJar=$jar

findJar "jackson-databind"
jacksonDatabindJar=$jar

findJar "jackson-core"
jacksonCoreJar=$jar

findJar "jjwt"
jjwtJar=$jar

findJar "jettison"
jettisonJar=$jar

findJar "bcpkix-jdk15on"
bcpkixJar=$jar

findJar "bcprov-jdk15on"
bcprovJar=$jar

findJar "nimbus-jose-jwt"
nimbusJoseJar=$jar

findJar "json-smart"
jsonSmartJar=$jar

findJar "accessors-smart"
accessorsSmartJar=$jar

findJar "jcl-over-slf4j"
jclOverSlf4jJar=$jar

findJar "slf4j-api"
slf4jApiJar=$jar

findJar "logback-classic"
logbackClassicJar=$jar

findJar "logback-core"
logbackCoreJar=$jar

findJar "httpcore"
httpcoreJar=$jar

findJar "jaxb-api"
jaxbApiJar=$jar

if [ "$needpw" = "yes" ]; then
    echo -n Password: 
    read -s sw
    echo
fi


pasoeJmxCall="$javahome/bin/java" 
pasoeJmxCallCp="-cp $oesectoolJar:$bcpkixJar:$bcprovJar:$nimbusJoseJar:$jsonSmartJar:$accessorsSmartJar:$jclOverSlf4jJar:$slf4jApiJar:$logbackClassicJar:$logbackCoreJar:$jettisonJar:$jjwtJar:$jacksonCoreJar:$jacksonDatabindJar:$jacksonAnnotationsJar:$jaxbApiJar:$httpclientJar:$httpcoreJar"

logger="org.apache.commons.logging.impl.NoOpLog"  
logbackFile="$pasoebase/conf/logging-oesectool.xml"

class="com.progress.appserv.util.sectool.PasoeSectoolService" 
command="$pasoeJmxCall $_jvmArgs $pasoeJmxCallCp -Dpasoebase=$pasoebase -Dsw=$sw -Dorg.apache.cxf.Logger=$logger -Dlogback.configurationFile=$logbackFile $class $args" 
if [ ! "$dbg" = "" ]; then
    echo "COMMAND: $command"
fi
$command
#echo "$ret"

