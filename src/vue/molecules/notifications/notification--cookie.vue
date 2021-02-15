<template>
  <div
    v-if="showCookie"
    :class="[
      'fixed z-10 right-0 bottom-0 m-3 p-5 w-11/12 md:w-9/12 lg:w-4/12 text-white-100 bg-blue-600'
    ]"
  >
    <span class="text-2xl font-extrabold block text-white-100 pb-3">
      {{ options.title }}
    </span>

    <div class="text-white-100" v-html="options.article"></div>

    <div class="w-full flex items-center justify-end mt-5">
      <a
        :href="options.url"
        class="text-white-100 underline mr-5"
        :title="options.privacy"
      >
        {{ options.privacy }}
      </a>
      <button
        @click.prevent="acceptCookie"
        :class="[
          'inline-flex border-2 px-4 py-2 font-extrabold text-lg border-white-100  hover:bg-white-100',
          'hover:text-' + options.colour,
        ]"
        :title="options.accept"
      >
        {{ options.accept }}
      </button>
    </div>
  </div>
</template>

<script>
  export default {

    props: {
      options: {
        type: Object,
        required: true,
      }
    },

    data: () => ({
      showCookie: false,
    }),

    methods: {

      acceptCookie() {
          const expiry = 5 * 24 * 60 * 60 * 1000;
          localStorage.setItem('cookie:show', expiry);
          this.setCookie();
      },

      setCookie() {
          this.showCookie = localStorage.getItem('cookie:show') ? false : true;
      }

    },

    created() {

        this.setCookie();

    }
  };
</script>
