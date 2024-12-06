function toggleContent(id) {
    const content = document.getElementById(id);
    const link = content.nextElementSibling;
    if (content.classList.contains('hidden')) {
        content.classList.remove('hidden');
        link.textContent = 'Schließen';
    } else {
        content.classList.add('hidden');
        link.textContent = 'Weiterlesen »';
    }
}