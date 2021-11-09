xquery version "3.1";

(:~ This library module contains XQSuite tests for the woposs app.
 :
 : @author Helena Bermúdez Sabel
 : @version 1.0.0
 : @see helenasabel.github.io
 :)

module namespace tests = "https://woposs.unine.ch/apps/woposs/tests";

import module namespace app = "https://woposs.unine.ch/apps/woposs/templates" at "../../modules/app.xql";
 
declare namespace test="http://exist-db.org/xquery/xqsuite";


declare variable $tests:map := map {1: 1};

declare
    %test:name('dummy-templating-call')
    %test:arg('n', 'div')
    %test:assertEquals("<p>Dummy templating function.</p>")
    function tests:templating-foo($n as xs:string) as node(){
        app:foo(element {$n} {}, $tests:map)
};
