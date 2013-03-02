$(document).ready(function(){
  $('input.ui-date-picker').datepicker({
                dateFormat : "yy-mm-dd",
            });
  $('input.ui-datetime-picker').datetimepicker({
                dateFormat : "yy-mm-dd",
                showButtonPanel : false
            });
});