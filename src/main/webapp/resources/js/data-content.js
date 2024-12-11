var PWB_COOKIE = "_Search_Result_PWB_Tree";
var SHOW_UNDEFINED_ATTRIBUTES = "showUndefinedAttributes";
var EXPAND = "expand-all";
var COLLAPSE = "collapse-all"; // default value for the Location in PWB

jQuery(document).ready(function () {
    togglePwbTree(readCookie(PWB_COOKIE));
});

jQuery(document).ready(function () {

    jQuery('[data-toggle="tooltip"]').tooltip();
    // Show summation up to 200 chars.
    function truncate(maxChars = 200) {
        // summation text only. The highlighting is lost and it will be done again after.
        let $node = jQuery(this);

        const originalHtml = $node.html(); // Save the original content
        const $clone = $node.clone(); // Clone the node for manipulation
        let truncatedHtml = '';
        let charCount = 0;
        let readMoreAdded = false; // Track if "... Read more" has been added

        // Recursive function to build truncated HTML with intact structure
        function recursiveTruncate($element) {
            $element.contents().each(function () {
                if (charCount >= maxChars) return false; // Stop if the limit is reached

                if (this.nodeType === Node.TEXT_NODE) { // For text nodes
                    const text = this.nodeValue;
                    const remainingChars = maxChars - charCount;

                    if (text.length > remainingChars) {
                        truncatedHtml += text.substring(0, remainingChars); // Append truncated text
                        charCount = maxChars; // Update char count

                        if (!readMoreAdded) {
                            truncatedHtml += `<a href="#" class="read-more">… Read more</a>`;
                            readMoreAdded = true;
                        }
                    } else {
                        truncatedHtml += text; // Append full text
                        charCount += text.length; // Update char count
                    }
                } else if (this.nodeType === Node.ELEMENT_NODE) { // For element nodes
                    const $child = jQuery(this);
                    const tagName = $child.prop('nodeName').toLowerCase(); // Get tag name

                    if (charCount < maxChars) {
                        truncatedHtml += `<${tagName}${getAttributesString($child)}>`; // Open tag
                        recursiveTruncate($child); // Recursively process children
                        truncatedHtml += `</${tagName}>`; // Close tag
                    }
                }
            });
        }

        recursiveTruncate($clone);

        if (charCount < maxChars) return; // No need to truncate if within limit

        $node.html(truncatedHtml); // Display the truncated content

        // Toggle functionality
        $node.on('click', '.read-more', function (e) {
            e.preventDefault();
            $node.html(originalHtml + ' <a href="#" class="show-less">Show less</a>');
        });

        $node.on('click', '.show-less', function (e) {
            e.preventDefault();
            $node.html(truncatedHtml);
            $node.get(0).scrollIntoView({behavior: 'smooth', block: 'start', inline: 'start'})
        });

    };
    jQuery('.summation').each(function () {
        truncate.bind(this)(200)
    });

    jQuery('.details-summation').each(function () {
        truncate.bind(this)(1000)
    });

});

jQuery(document).ready(function () {

    var termList = jQuery('ul.term-list');
    termList.on('click', '.more', function () {
        if (jQuery(this).hasClass('less')) {
            jQuery(this).text('More...').removeClass('less');
        } else {
            jQuery(this).text('Less...').addClass('less');
        }
        jQuery(this).siblings('li.toggleable').slideToggle();
    });

    termList.each(function () {
        var LiN = jQuery(this).find('li').length;
        if (LiN > 6) {
            jQuery('li', this).eq(5).nextAll().hide().addClass('toggleable');
            jQuery(this).append('<li class="more">More...</li>');
        }
    });

    jQuery('#search_form').submit(function (e) {
        var localsearchbox = jQuery('#local-searchbox').val();
        if (!localsearchbox) {
            e.preventDefault();
        } else if (localsearchbox.match(/^\s*jQuery/)) {
            e.preventDefault();
        }
    });

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

    // expand and collapse all feature
    jQuery("#pwb_toggle").click(function () {
        var action = jQuery("#pwb_toggle").attr("class");
        togglePwbTree(action);
        writeCookie(PWB_COOKIE, action);
    });

    var availableSpeciesSel = jQuery('[id*=availableSpeciesSel]');
    availableSpeciesSel.ready(function () {
        var DEFAULT_SPECIES = 'Homo sapiens';

        /** Check if hash is present in the URL **/
        var hash = decodeURIComponent(window.location.hash);
        var defaulLoaded = false;
        var tplSpecies = jQuery("div[class*=tplSpe_]");
        if (hash === "") {
            tplSpecies.each(function (index, value) {
                var item = jQuery(value).attr("class");
                if (item === "tplSpe_" + DEFAULT_SPECIES.replace(" ", "_")) {
                    availableSpeciesSel.val(DEFAULT_SPECIES.replace(" ", "_"));
                    jQuery("." + item).show();
                    //change url
                    if (availableSpeciesSel.val() != null) {
                        window.location.hash = "#" + encodeURIComponent(DEFAULT_SPECIES);
                    }
                    defaulLoaded = true;
                } else {
                    jQuery("." + item).css("display", "none");
                }
            });

            if (!defaulLoaded) {
                tplSpecies.css("display", "block");
            }
        } else {
            hash = hash.replace("#", "").replace(" ", "_");
            var tplSelected = jQuery(".tplSpe_" + hash);
            // hash has been change manually into a non-existing value. Pick the first one which is human
            if (tplSelected.val() == null) {
                jQuery("[id*=availableSpeciesSel] > option").each(function (index, value) {
                    var item = jQuery(value).attr("value");
                    tplSpecies.val(item);
                    jQuery(".tplSpe_" + item).show();
                    window.location.hash = "#" + encodeURIComponent(item.replace("_", " "));
                    return false;
                });
            } else {
                tplSpecies.val(hash);
                tplSelected.show();
            }
        }
    });

    availableSpeciesSel.on('change', function () {
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

/*----------------------*/
/* JAVASCRIPT FUNCTIONS */

/*----------------------*/

// Helper function to get attributes as a string
function getAttributesString($element) {
    const attributes = $element[0].attributes;
    const attrArray = [];
    for (let i = 0; i < attributes.length; i++) {
        const attr = attributes[i];
        attrArray.push(`${attr.name}="${attr.value}"`);
    }
    return attrArray.length > 0 ? ' ' + attrArray.join(' ') : '';
}

function togglePwbTree(action) {
    var treeLpwb = jQuery("div.tree-lpwb");
    treeLpwb.each(function (index, element) {
        if (action === EXPAND) {
            jQuery(element).show();
        } else {
            jQuery(element).hide(100);
        }
    });

    var pwbToggle = jQuery("#pwb_toggle");
    if (action === COLLAPSE || action == null) {
        jQuery(".fa-minus-square-o").attr("class", "fa fa-plus-square-o");
        pwbToggle.text("Expand All");
        pwbToggle.attr("class", EXPAND);
    } else {
        jQuery(".fa-plus-square-o").attr("class", "fa fa-minus-square-o");
        pwbToggle.text("Collapse All");
        pwbToggle.attr("class", COLLAPSE);
    }
}

function toggleShowUndefinedAttributes(showUndefinedAttributes) {
    writeCookie(SHOW_UNDEFINED_ATTRIBUTES, showUndefinedAttributes);
    location.reload()
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

function writeCookie(key, value) {
    var date = new Date();
    // Default at 365 days.
    var days = 365;
    // Get unix milliseconds at current time plus number of days
    date.setTime(+date + (days * 86400000)); //24 * 60 * 60 * 1000
    document.cookie = key + "=" + value + "; expires=" + date.toGMTString() + ";";
}

function openSideNav() {
    jQuery("#search-filter-sidenav").css({width: "310px", left: "0"});
    jQuery(".sidenav-bg").css('display', 'block');
    lockBackground();
}

/* Set the width of the side navigation to 0 */
function closeSideNav() {
    jQuery("#search-filter-sidenav").css({width: "0", left: ""});
    jQuery(".sidenav-bg").css('display', 'none');
    releaseBackground();
}

function openSchemaSideNav() {
    var width = "350px";
    if (window.matchMedia('screen and (max-width: 500px)').matches) {
        width = "100%";
    }
    jQuery(".schema-tree-mobile").html(jQuery(".schema-tree-ph").html());
    jQuery("#schema-sidenav").css({width: width, left: "0"});
    jQuery(".sidenav-bg").css('display', 'block');
    lockBackground();
}

/* Set the width of the side navigation to 0 */
function closeSchemaSideNav() {
    jQuery("#schema-sidenav").css({width: "0", left: ""});
    jQuery(".sidenav-bg").css('display', 'none');
    releaseBackground();
}

/* Lock background while scrolling in a popup or modal */
function lockBackground() {
    jQuery("html").addClass("modal-open");
    jQuery("body").addClass("modal-open");
}

function releaseBackground() {
    jQuery("html").removeClass("modal-open");
    jQuery("body").removeClass("modal-open");
}