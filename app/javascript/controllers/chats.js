document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("chat-form");
    const chatHistory = document.getElementById("chat-history");

    form.addEventListener("submit", (event) => {
        event.preventDefault();

        const formData = new FormData(form);
        fetch(form.action, {
            method: "POST",
            body: formData,
            headers: { "X-CSRF-Token": document.querySelector("[name=csrf-token]").content },
        })
            .then((response) => response.json())
            .then((data) => {
                chatHistory.innerHTML = "";
                data.messages.forEach((message) => {
                    const p = document.createElement("p");
                    p.className = message.sender === "Você" ? "text-right text-blue-600 font-semibold" : "text-left text-green-600 font-semibold";
                    p.innerHTML = `<strong>${message.sender}: </strong>${message.text}`;
                    chatHistory.appendChild(p);
                });

                form.elements["awaiting_pain_level"].value = data.awaiting_pain_level;
                form.elements["user_input"].value = "";
                chatHistory.scrollTop = chatHistory.scrollHeight;
            });
    });
});
