document.addEventListener("DOMContentLoaded", function () {
  const fields = ["first_name", "last_name", "email", "city"];

  fields.forEach(field => {
    const input = document.getElementById(`user_${field}`);
    const dataList = document.getElementById(`${field}-suggestions`);

    input.addEventListener("input", function () {
      const query = input.value;
      if (query.length > 2) {
        fetch(`/users/suggestions?query=${query}&field=${field}`)
          .then(response => response.json())
          .then(data => {
            dataList.innerHTML = "";
            data.forEach(value => {
              const option = document.createElement("option");
              option.value = value;
              dataList.appendChild(option);
            });
          });
      }
    });
  });
});
