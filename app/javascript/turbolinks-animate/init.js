import 'turbolinks-animate'

const loadingStart = () => {
  if (document.querySelector('.is-loading-on-load')) {
    document.querySelector('.is-loading-on-load').classList.add('is-loading')
  }
}

const loadingEnd = () => {
  if (document.querySelector('.is-loading-on-load')) {
    document.querySelector('.is-loading-on-load').classList.remove('is-loading')
  }
}

const turboLinksLoad = () => {
  loadingEnd()

  TurbolinksAnimate.init({
    animation: 'fadeInUp',
    duration: '0.6s',
    delay: 100,
  })

  for (let form of document.querySelectorAll(
    'form[method=get][data-remote=true]'
  )) {
    form.addEventListener('ajax:beforeSend', function (event) {
      Turbolinks.visit(event.detail[1].url)
      event.preventDefault()
    })
  }

  for (let form of document.querySelectorAll(
    'form[method=post][data-remote=true]'
  )) {
    form.addEventListener('ajax:beforeSend', function () {
      loadingStart()
    })
  }
}

document.addEventListener('turbolinks:load', turboLinksLoad)
document.addEventListener('turbolinks:request-start', loadingStart)
