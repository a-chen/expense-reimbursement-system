$( document ).ready(function() {
    $(document).on('click','.edit_row a',function() {
        $(this).closest('tr').find('select')
            .prop('disabled', function(_, prop){ return !prop});
    });
});
