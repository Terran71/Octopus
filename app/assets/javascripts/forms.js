
// jQuery(document).ready(function(e){
//   // Textarea Autogrow
//   var dateToday = new Date();
//   // $('#datetimepickerStartIcon').datetimepicker();
//   // $('#datetimepickerEndIcon').datetimepicker();

//    // $('#datetimepickerStartIcon').hide();
//    // $('#datetimepickerStart').hide(); 
// /* Please note that if the css rules are set to display:none !important then it may not hide them */

//    // $('#datetimepickerStartIcon').click(function(){

//    //  $(this).toggle();
//    // });

//    // $('#datetimepickerStart').click(function(){

//    //  $(this).toggle();
//    // });

//  // $('#datetimepickerStart, #datetimepickerEnd').datetimepicker({
//  //   format: 'MM/DD/YYYY',
//  //   extraFormats: ['MM/DD/YY'],
//  //   maxDate: '12/31/2059',
//  //   minDate: dateToday,
//  //    viewMode: 'days',
//  //  });      

//  $('#datetimepickerStart, #datetimepickerEnd').datetimepicker({
//    maxDate: '12/31/2059',
//    minDate: dateToday,
//    viewMode: 'days',
//    format: 'MM/DD/YYYY',
//    extraFormats: ['MM/DD/YY'],
//   });  

//   $('#datetimepickerStart').datetimepicker({
//    maxDate: '12/31/2059',
//    minDate: dateToday,
//    viewMode: 'days',
//   });  


                
//   // $(' #datetimepickerStartIcon').datetimepicker({
//   //   minDate: dateToday,


//   // });
//   // $(' #datetimepickerEndIcon').datetimepicker({
//   //   // minDate: dateTomorrow
//   // });

//   // $(' #datetimepickerStart').datetimepicker({
//   //   // minDate: dateToday,
//   // });
//   // $(' #datetimepickerEnd').datetimepicker({
//   //   // minDate: dateTomorrow
//   // });


//   $("#datetimepickerStart, #datetimepickerStartIcon").on("dp.change", function (e) {
//     $('#datetimepickerEnd').data("DateTimePicker").minDate(e.date);
//   });
//   $("#datetimepickerEnd, #datetimepickerEndIcon").on( "dp.change", function (e) {
//     $('#datetimepickerStart').data("DateTimePicker").maxDate(e.date);
//   });

//     $("#hiddendate ").on("dp.change", function (e) {
//     $('#datetimepickerEnd').data("DateTimePicker").minDate(e.date);
//   });
//     $("#first_event ").on("dp.change", function (e) {
//     $('#datetimepickerEnd').data("DateTimePicker").minDate(e.date);
//   });

//   // $('#datetimepickerStart').datepicker().on('changeDate', function (ev) {
//   //   // start_date = "#datetimepickerStart";
//   //   // default_end = start_date + 2 days;
//   //   $('#datetimepickerEnd').change();
//   // });
//   // $('#datetimepickerStart').change(function () {
//   //     console.log($('#datetimepickerStart').val());
//   // });

//   // $('input#datetimepickerStart, input#datetimepickerEnd, #datetimepickerEndIcon, #datetimepickerStartIcon').datetimepicker({
//   //  format: 'MM/DD/YYYY',
//   //  defaultDate: new Date(),
//   //  extraFormats: ['MM/DD/YY'],
//   //  minDate: '01/01/1960',
//   //  maxDate: '12/31/2059'
//   // });     


// $('#timepickerStart').timepicker({
//   showInputs: false,
//   disableFocus: true,
//      minTime: '05:00:00',
//     maxTime: '22:00:00',
//      defaultTime: false
// });
// $('#timepickerEnd').timepicker({
//   showInputs: false,
//   disableFocus: true,
//     minTime: '05:00:00',
//     maxTime: '22:00:00',
//     defaultTime: false
// });


// // javascript:
// //  $(' #timepickerStart, #timepickerEnd').timepicker({
// //     timeFormat: 'h:mm:ss p',
// //       interval: 15,
// //     minTime: '05:00:00',
// //     maxTime: '22:00:00',

// //   });  



//   // $("#datetimepickerStart").mask("MM/DD/YYYY");



//    $("#phone").mask("(999) 999-9999");

//  });


// // jQuery(document).ready(function(){

// //   $('.panel-templates').on('show.collapse', function () {
// //    $(this).addClass('active');
// //  });

// //   $('.panel-templates').on('hide.collapse', function () {
// //    $(this).removeClass('active');
// //  });


 
// // });



// // // don't know what this does!!! I think it's scroll to top....I  THINK
// // jQuery(document).ready(function(){
// //   $('a[href*=#]:not([href=#])').click(function() {
// //     if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
// //       var target = $(this.hash);
// //       target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
// //       if (target.length) {
// //         $('html,body').animate({
// //           scrollTop: target.offset().top
// //         }, 500);
// //         return false;
// //       }
// //     }
// // });  




