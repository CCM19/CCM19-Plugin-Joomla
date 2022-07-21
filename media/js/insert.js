
(document =>{

    var jsvars = Joomla.getOptions('snippet');

    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');

    script.type = 'text/javascript';
    script.src = jsvars.url;
    script.referrerPolicy = 'origin';

    head.appendChild(script)

    })(document)

