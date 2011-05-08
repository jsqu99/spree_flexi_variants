/* before including this file, make sure you have a variable, exclusions, initialized like:

   var exclusions = [{"s1": "1", "s2": "4", "s3": "7", "s4":"a"},
   {"s1": "1", "s2": "5", "s3": "8", "s4":"a"},
   {"s1": "2", "s2": "6", "s3": "8", "s4":"b"},
   {"s1": "2", "s2": "5", "s3": "*", "s4":"*"},
   {"s1": "*", "s2": "-1", "s3": "*", "s4":"*"}];

*/

function legalCombination(triggering_select, current_target, target_option) {
  // get every other drop down besides the two

  // create a matrix of all possible remaining values
  // The first step is to accumulate all the select ids and their options
  // e.g.
  //
  // {
  //     'select1': [optval1, optval2, optval3]
  //     ,'select2': [optval1, optval2]
  //     ,'select3': [optval1, optval2, optval3]
  //     ,'select4': [optval1, optval2, optval3, optval4]
  //     ,'select5': [optval1, optval2, optval3]
  // }

  var all_vals={};

  $('.ad_hoc').not(current_target).each(function(i) {
    var cur_opt_arr = [];
    all_vals[$(this).attr('id')] = cur_opt_arr;

    if ($(this).val() != "") {
      // this select has already been 'selected', so preserve the item in our possibilites martix, and don't include all the options in this drop down
      cur_opt_arr.push($(this).val());
    } else {
      var opts=$(this).data('options');
      $.each(opts, function(i, opt) { if (opt.value != "") {cur_opt_arr.push(opt.value);} });
    }
  });


  // set up an array to use as our input to possibleCombinations()

  var keyArray = [];
  var p = [];

  // we need to keep track of the keys for later correlation

  // keyArray[0] will correspond to all possibilities-column 0
  // keyArray[1] will correspond to all possibilities-column 1

  $.each(all_vals, function(sel_id, opt_arr) {
    keyArray.push(sel_id);
    p.push(opt_arr);
  });

  possibilities = possibleCombinations(p);
  // now iterate over the entire possibilities array, stopping
  // and returning success of the first non-violating row

  // now try to find ONE legal combination
  // our exclusions structure looks like:
  //   {"s1": "1", "s2": "4"},

  var has_legal_possibility=false;

  // if we only have two drop-downs
  if (possibilities.length==0) {

    var found_violation = false;

    $.each(exclusions, function(j, exclusion) {

      /* console.log('exclusion[' + $(triggering_select).attr('id') +']=>' + exclusion[$(triggering_select).attr('id')] +
         ',exclusion[' + $(current_target).attr('id') + ']=>' + exclusion[$(current_target).attr('id')]);*/

      // test the 'outter' two drop downs
      if ((exclusion[$(triggering_select).attr('id')] == $(triggering_select).val() || exclusion[$(triggering_select).attr('id')] == "*") && (
        exclusion[$(current_target).attr('id')] == target_option.value || exclusion[$(current_target).attr('id')] == "*")) {

        // this pair is NO GOOD
        //console.log('this pair is NO GOOD');
        found_violation=true;
        return false; // break out of 'each'
      }
    }); // each

    return !found_violation;
  } //  end if only two drop downs?
  else {

    // we really only need ONE possibility to pass the exclusion filter

    $.each(possibilities, function (i, possibility) {
      // can this combination exist, given the exclusions?

      // this possbility must pass EVERY exclusion

      var found_violation = false;

      $.each(exclusions, function(j, exclusion) {

        // TODO account for nil values in exclusions

        /*console.log('exclusion[' + $(triggering_select).attr('id') +']=>' +
          exclusion[$(triggering_select).attr('id')] +
          ',exclusion[' + $(current_target).attr('id') + ']=>' + exclusion[$(current_target).attr('id')]);
        */
        // test the 'outter' two drop downs


        // console.log("comparing to actual values: " + $(triggering_select).val() + ":" + target_option.value);

        // triggering_select might now be in a deselected state right now, but this 'if' should still work
        if ((exclusion[$(triggering_select).attr('id')] == $(triggering_select).val() || exclusion[$(triggering_select).attr('id')] == "*") && (
          exclusion[$(current_target).attr('id')] == target_option.value || exclusion[$(current_target).attr('id')] == "*")) {


          // console.log("partial match");
          // we have a partial match, now test the remaining possbilities

          // do ALL of the members of this 'possibility' return true matches for this exclusion?  If not, we have a 'pass' for this possibilty/exclusion
          var truth_map= $.map(possibility, function (possbility_item, k) {
            // console.log("comparing exclusion["+keyArray[k] + "] == " + possbility_item);
            return (exclusion[keyArray[k]] == possbility_item || exclusion[keyArray[k]] == "*");
          });

          // console.log("truth map: " + truth_map);
          // if all members are 'true', we have a violation
          if ($.inArray(false, truth_map) == -1) {
            found_violation=true;
            return false; // this breaks us out of the 'each', since we are done hunting for violations for this exclusion
          }
        } // if
      }); // each exclusion

      if (!found_violation) {
        has_legal_possibility=true;
        // console.log("WINNER: passing possbility: " + possibility);
        return false; // break out of possbilities.each since we've found a winner
      }
    }); // each possbility
    return has_legal_possibility;
  } // else more than two drop downs
} // legal combination


// return an array of possible combinations
function possibleCombinations (options) {
  // adapted from http://stackoverflow.com/questions/1636355/jquery-javascript-multiple-array-combinations

  var recursiveSearch;
  var possibilities = [];

  if (options.length == 0) {
    return possibilities;
  }

  recursiveSearch = function (arr, depth )  {
    arr = arr || [];

    depth = depth || 0;
    for ( var i = 0; i < options[depth].length; i++ )
    {
      // is there one more layer?
      if ( depth +1 < options.length ) {
        // yes: iterate the layer
        var a=new Array();
        $.merge(a,arr);
        a.push(options[depth][i]);
        recursiveSearch ( a , depth +1 );
      }
      else {
        // no: this is the last layer. we add the result to the array
        var a=new Array();
        $.merge(a,arr);
        a.push(options[depth][i]);
        possibilities.push ( a);
      }
    }
  };

  recursiveSearch();

  return possibilities;
}


$(document).ready(function() {
  // initialize all the 'options'
  $('select.ad_hoc').each(function() {
    var options = [];
    var select = this;

    // find the current options, and save them in the 'data' of the select

    $(select).find('option').each(function() {
      options.push({value: $(this).val(), text: $(this).text()});
    });

    $(select).data('options', options);
  });


  // set up the change event handler when any drop down changes,

  $('.ad_hoc').change(function() {
    var triggering_select = this;  // take not of the the drop down that triggered this activity

    // alter the contents of every other drop down
    $('.ad_hoc').not(triggering_select).each(function(i) {
      //     if ($(this).val() != "") {
      //       return true; // 'continue' the loop as we want to ignore selects that have already been 'selected'
      //     }

      // 1) grab current target_option
      // 2) is there at least one combination involving selected_option,
      //    target_option(from 'this' dropdown), and every other drop down's
      //    options that can make a legal combination?

      var current_target=this;

      var current_target_option=$(current_target).val();

      var target_options = $(current_target).empty().data('options');

      // so we now have the option selection that kicked off the whole process('s_1_n',
      // and our current(of many) 'other' drop downs (along w/ its options, s_2_0, s_2_1, s_2_2, s_2_3, etc.).
      //
      // now for each pair:
      // <selected>, <current_target>
      //     s_1_n      s_2_0
      //     s_1_n      s_2_1
      //     s_1_n      s_2_2
      //     s_1_n      s_2_3
      //
      // determine if legalCombination(triggering_select, current_target, current_target_option)

      $.each(target_options, function(i) {
        var target_option = target_options[i];                  // e.g. s_2_0

        // put the 'Choose...' right back on the select
        if (target_option.value=="") {
          $(current_target).append(
            $('<option>').text(target_option.text).val(target_option.value)
          );
        } else {
          if (legalCombination(triggering_select, current_target, target_option)) {
            $(current_target).append(
              $('<option>').text(target_option.text).val(target_option.value)
            );
          }
        }
      });

      // restore the previously selected value, if it exists

      $(current_target).find('option[value='+current_target_option+']').attr('selected', 'selected');
    }); //  .not().each()
  }); // .change()
}); // ready
