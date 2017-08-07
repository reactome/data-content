var PWB_COOKIE="_Search_Result_PWB_Tree";
var EXPAND = "expand-all";
var COLLAPSE = "collapse-all"; // default value for the Location in PWB

jQuery(document).ready(function () {
    jQuery('#local-searchbox').autocomplete({
        serviceUrl: '/content/getTags',
        minChars: 2,
        deferRequestBy: 250,
        paramName: "tagName",
        delimiter: ",",
        transformResult: function (response) {
            return {
                suggestions: jQuery.map(jQuery.parseJSON(response), function (item) {
                    return {value: item};
                })
            };
        },
        onSelect: function (value, data) {
            jQuery("#search_form").submit()
        }
    });

    // read cookie when loading page for the first time
    var pwb_cookie = readCookie(PWB_COOKIE);
    // PWB Tree always collapse if cookie not set.
    togglePwbTree(pwb_cookie == null ? COLLAPSE : pwb_cookie);
});

jQuery(document).ready(function () {
    jQuery('ul.term-list').each(function () {
        var LiN = jQuery(this).find('li').length;
        if (LiN > 6) {
            jQuery('li', this).eq(5).nextAll().hide().addClass('toggleable');
            jQuery(this).append('<li class="more">More...</li>');
        }
    });
});

// Show summation up to 200 chars.
jQuery(document).ready(function() {
    // Configure/customize these variables.
    var showChar = 200;  // How many characters are shown by default
    var ellipsestext = "... ";
    var moretext = "Read more";
    var lesstext = " Show less";


    // FIXME: highlighting is not working in the summation
    jQuery('.summation').each(function() {
        var content = jQuery(this).text();

        if(content.length > showChar) {
            var c = content.substr(0, showChar);
            var h = content.substr(showChar, content.length - showChar);
            var html = jQuery.trim(c) + '<span class="moreellipses">' + ellipsestext+ '</span><span class="morecontent"><span>' + h + '</span><a href="javascript:void(0);" class="morelink">' + moretext + '</a></span>';
            jQuery(this).html(html);
        }
    });

    jQuery(".morelink").click(function(){
        if(jQuery(this).hasClass("less")) {
            jQuery(this).removeClass("less");
            jQuery(this).html(moretext);
        } else {
            jQuery(this).addClass("less");
            jQuery(this).html(lesstext);
        }

        jQuery(this).parent().prev().toggle();
        jQuery(this).prev().toggle();
        return false;
    });
});

jQuery(document).ready(function () {
    jQuery('ul.term-list').on('click', '.more', function () {
        if (jQuery(this).hasClass('less')) {
            jQuery(this).text('More...').removeClass('less');
        } else {
            jQuery(this).text('Less...').addClass('less');
        }
        jQuery(this).siblings('li.toggleable').slideToggle();
    });
});

jQuery(document).ready(function () {
    jQuery('#search_form').submit(function (e) {
        if (!jQuery('#local-searchbox').val()) {
            e.preventDefault();
        } else if (jQuery('#local-searchbox').val().match(/^\s*jQuery/)) {
            e.preventDefault();
        }
    });
});

jQuery(document).ready(function () {
    jQuery(".plus").click(function () {
        $plus = jQuery(this);
        $treeLpwb = $plus.nextAll().eq(0);
        $treeLpwb.slideToggle(500, function () {
            if ($treeLpwb.is(":visible")) {
                //return $plus.find(".sprite-plus").attr("class", "sprite-resize-small sprite sprite-minus");
                return $plus.find(".fa-plus-square-o").attr("class", "fa fa-minus-square-o");
            } else {
                //return $plus.find(".sprite-minus").attr("class", "sprite-resize-small sprite sprite-plus");
                return $plus.find(".fa-minus-square-o").attr("class", "fa fa-plus-square-o");
            }
        });
    });
});

jQuery(document).ready(function () {
    jQuery('[id*=availableSpeciesSel]').ready(function () {
        var DEFAULT_SPECIES = 'Homo sapiens';

        /** Check if hash is present in the URL **/
        var hash = decodeURIComponent(window.location.hash);
        var defaulLoaded = false;
        if (hash == "") {
            jQuery("div[class*=tplSpe_]").each(function (index, value) {
                var item = jQuery(value).attr("class");
                if (item == "tplSpe_" + DEFAULT_SPECIES.replace(" ", "_")) {
                    jQuery("[id*=availableSpeciesSel]").val(DEFAULT_SPECIES.replace(" ", "_"));
                    jQuery("." + item).show();

                    //change url
                    if (jQuery("[id*=availableSpeciesSel]").val() != null) {
                        window.location.hash = "#" + encodeURIComponent(DEFAULT_SPECIES);
                    }

                    defaulLoaded = true;
                } else {
                    jQuery("." + item).css("display", "none");
                }
            });

            if (!defaulLoaded) {
                jQuery("div[class*=tplSpe_]").css("display", "block");
            }
        } else {
            hash = hash.replace("#", "").replace(" ", "_");

            // hash has been change manually into a non-existing value. Pick the first one which is human
            if (jQuery(".tplSpe_" + hash).val() == null) {

                jQuery("[id*=availableSpeciesSel] > option").each(function (index, value) {
                    var item = jQuery(value).attr("value");

                    jQuery("[id*=availableSpeciesSel]").val(item);

                    jQuery(".tplSpe_" + item).show();
                    window.location.hash = "#" + encodeURIComponent(item.replace("_", " "));

                    return false;
                });
            } else {
                jQuery("[id*=availableSpeciesSel]").val(hash);
                jQuery(".tplSpe_" + hash).show();
            }
        }
    });
});

jQuery(document).ready(function () {
    jQuery('[id*=availableSpeciesSel]').on('change', function () {
        var selectedSpecies = this.value;

        // hide everything
        jQuery("div[class*=tplSpe_]").each(function (index, element) {
            jQuery(element).hide();
        });

        // show div related to the species
        jQuery(".tplSpe_" + selectedSpecies).show();

        // change anchor in the URL
        window.location.hash = "#" + encodeURIComponent(selectedSpecies.replace("_", " "));

    });
});

jQuery(document).ready(function () {
    // expand and collapse all feature
    jQuery("#pwb_toggle").click(function () {
        var action = jQuery("#pwb_toggle").attr("class");
        togglePwbTree(action);
        writeCookie(PWB_COOKIE, action);
    });
});

function togglePwbTree(action){
    var treeLpwb = jQuery("div.tree-lpwb");
    treeLpwb.each(function (index, element) {
        if (action == EXPAND) {
            jQuery(element).show();
        } else {
            jQuery(element).hide(100);
        }
    });

    if (action == COLLAPSE) {
        jQuery(".fa-minus-square-o").attr("class", "fa fa-plus-square-o");
        jQuery("#pwb_toggle").text("Expand All");
        jQuery("#pwb_toggle").attr("class", EXPAND);
    } else {
        jQuery(".fa-plus-square-o").attr("class", "fa fa-minus-square-o");
        jQuery("#pwb_toggle").text("Collapse All");
        jQuery("#pwb_toggle").attr("class", COLLAPSE);
    }
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function writeCookie(key, value) {
    var date = new Date();
    // Default at 365 days.
    var days = 365;
    // Get unix milliseconds at current time plus number of days
    date.setTime(+ date + (days * 86400000)); //24 * 60 * 60 * 1000
    document.cookie = key + "=" + value + "; expires=" + date.toGMTString() + ";";
}

function openSideNav() {
    jQuery("#search-filter-sidenav").css({width: "270px", left: "0" });
    jQuery(".sidenav-bg").css('display', 'block');
    jQuery("html").addClass("modal-open");
    jQuery("body").addClass("modal-open");
}

/* Set the width of the side navigation to 0 */
function closeSideNav() {
    jQuery("#search-filter-sidenav").css({width: "0", left: "" });
    jQuery(".sidenav-bg").css('display', 'none');
    jQuery("html").removeClass("modal-open");
    jQuery("body").removeClass("modal-open");
}