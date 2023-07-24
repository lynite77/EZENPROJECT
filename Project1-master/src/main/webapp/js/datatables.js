window.addEventListener('DOMContentLoaded', event => {
    // Simple-DataTables
    
    const datatablesSimple = document.getElementById('datatablesSimple');
    if (datatablesSimple) {
        const inputElement = document.getElementById('productCode');
        new simpleDatatables.DataTable(datatablesSimple, {
            searchInput: inputElement
        });
    }
});
