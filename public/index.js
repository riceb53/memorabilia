/* global Vue, VueRouter, axios */

var StoreSignupPage = {
  template: "#store-signup-page",
  data: function() {
    return {
      errors: [],
      store: {
        password: "",
        passwordConfirmation: "",
        title: "",
        email: "",
        address: "",
        city: "",
        zip_code: ""
      }
    };
  },
  methods: {
    submit: function() {
      var params = {
        title: this.store.title,
        password: this.store.password,
        passwordConfirmation: this.store.passwordConfirmation,
        email: this.store.email,
        address: this.store.address,
        city: this.store.city,
        zip_code: this.store.zip_code
      };
      axios
        .post("/api/stores", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var CardsIndexPage = {
  template: "#cards-index-page",
  data: function() {
    return {
      cards: []
    }
  },
  created: function() {
    axios.get('/api/cards').then(function(response) {
      console.log(response.data)
      this.cards = response.data;
      if (this.cards.message === 'Unauthorized') {
        router.push('/login');
      }
    }.bind(this))
  }
};


var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      user_type: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        email: this.email,
        password: this.password,
        user_type: this.user_type
      };
      axios
        .post("/api/sessions", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          localStorage.setItem("email", response.data.email);
          if (this.user_type === 'user') {
            router.push("/");
          } else if (this.user_type === 'store') {
            router.push("/#/users");
          }
        }.bind(this))
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var CardsNewPage = {
  template: "#cards-new-page",
  data: function() {
    return {
      errors: [],
      card: {
        player: "",
        year_made: "",
        quality: "",
        notes: "",
        user_id: "",
        store_id: "",
        confirmed: "",
        value: "",
        quality: ""
      },
      stats: {
        runs: "",
        hits: "",
        ba: "",
        hr: "",
        sb: "",
        year_played: ""
      }
    };
  },
  methods: {
    submit: function() {
      var params = {
        player: this.card.player,
        year_made: this.card.year_made,
        notes: this.card.notes,
        value: this.card.value,
        quality: this.card.quality,
        stats: this.stats
      };

      console.log(params)
      console.log(this.card)
      console.log(params.year_made)
      axios
        .post("/api/cards", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var CardsEditPage = {
  template: "#cards-edit-page",
  data: function() {
    return {
      errors: [],
      card: {
        player: "",
        year_made: "",
        quality: "",
        notes: "",
        user_id: "",
        store_id: "",
        confirmed: "",
        value: "",
        quality: ""
      },
      stats: {
        runs: "",
        hits: "",
        ba: "",
        hr: "",
        sb: "",
        year_played: ""
      },
      user: {
        type: "",
        info: {}
      }
    };
  },
  created: function() {
    axios.get('/api/cards/' + this.$route.params.id).then(function(response) {
      console.log('response.data')
      console.log(response.data)
      this.card = response.data;
      this.stats = response.data.stats;
    }.bind(this))
    axios.get('/api/users/show').then(function(response) {
      console.log(response.data)
      this.user = response.data
    }.bind(this))
  },
  methods: {
    submit: function() {
      var params = {
        confirmed: this.card.confirmed,
        player: this.card.player,
        year_made: this.card.year_made,
        notes: this.card.notes,
        value: this.card.value,
        quality: this.card.quality,
        stats: this.stats
      };
      axios
        .patch("/api/cards/" + this.$route.params.id, params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};


var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      zip_code: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        zip_code: this.zip_code,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/api/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};



var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Welcome to Vue.js!"
    };
  },
  created: function() {
    axios.get('/api/users/show').then(function(response) {
      console.log('here is the person who is logged in');
      console.log(response.data)
    })
  },
  methods: {},
  computed: {}
};

var router = new VueRouter({
  routes: [
    { path: "/", component: CardsIndexPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/signup", component: SignupPage },
    { path: "/cards/new", component: CardsNewPage },
    { path: "/cards/:id/edit", component: CardsEditPage },
    { path: "/cards", component: CardsIndexPage },
    { path: "/store-signup", component: StoreSignupPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    var email = localStorage.getItem("email");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
    // console.log(jwt);
    // console.log(email);
    // console.log(localStorage.getItem("email"));

  }
});
