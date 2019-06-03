var createPostRequest = (event) => {
  console.log("Hello2")
  var recipeCardPopup = document.querySelector('.recipe-card-popup');
  var recipeId = recipeCardPopup.dataset.recipeId;
  console.log(recipeId)
      httpUrl = `recipes/${recipeId}/wishlist`
      $.ajax({
        url: httpUrl,
        type: 'POST',
        data: {authenticity_token: authToken, confirm: "Are you sure?"},
      })
        .done(function( data ) {

        });
}

var addToWishlist = (event) => {
  setTimeout(() => {
    var addToWishlistIcon = document.querySelector('.add-to-wishlist');
    if (addToWishlistIcon) {
      console.log(addToWishlistIcon);
      addToWishlistIcon.addEventListener('click', (event) => {
        console.log("hello2");
      });


      // addToWishlistIcon.style.color = "blue";
      // console.log("hello4");
    }
  }, 1000)
}

var addClickEvent = (recipeCard) => {
  recipeCard.addEventListener('click', addToWishlist);
}

export var clickOnRecipeCard = () => {
  var recipeCards = document.querySelectorAll('.recipe-card');
  recipeCards.forEach(addClickEvent);
}






// swal({
//   title: "Are you sure?",
//   text: `This will delete "${bikeName}" permanently from your account`,
//   icon: "warning",
//   buttons: ["Not sure...", "Yep!"],
//   dangerMode: true,
// })
// .then((willDelete) => {
//   if (willDelete) {
//     $.ajax({
//       url: httpUrl,
//       type: 'DELETE',
//       data: {authenticity_token: authToken, confirm: "Are you sure?"},
//     })
//       .done(function( data ) {
//         const deletedCard = document.getElementById(`${id}`).parentNode.parentNode.parentNode.parentNode;
//         // const nextCard = deletedCard.nextSibling
//         deletedCard.style.opacity = 0;
//         setTimeout(function() {

//           deletedCard.remove();

//           swal({
//             // title: createButton.innerHTML,
//             title: `Deleted ${bikeName} successfully`,
//             icon: "success",
//             buttons: false
//           })

//           const swalOverlay = document.querySelector('.swal-overlay');
//           swalOverlay.setAttribute("id", "swal-created-overlay");

//           const swalAlert = document.querySelector('.swal-modal');
//           swalAlert.setAttribute("id", "swal-created");

//           setTimeout(() => {
//             swalOverlay.style.opacity = 0;
//           }, 2000)

//           setTimeout(() => {
//             swalOverlay.remove();
//           }, 3000);

//         }, 400)

//       });
//   } else {
//     swal("Phewww, that was close!");
//   }
// });
