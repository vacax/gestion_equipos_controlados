

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'gestion_equipos_controlados.auth.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'gestion_equipos_controlados.auth.UserRole'
grails.plugin.springsecurity.authority.className = 'gestion_equipos_controlados.auth.Role'
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.successHandler.defaultTargetUrl = '/'
grails.plugin.springsecurity.successHandler.alwaysUseDefault = true

//Presentar los errores directo.
grails.plugin.springsecurity.rejectIfNoRule = false
grails.plugin.springsecurity.fii.rejectPublicInvocations = false


grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['ROLE_ADMIN']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/error.gsp',          access: ['permitAll']],
	[pattern: '/index',          access: ['ROLE_ADMIN']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/forbidden.gsp',      access: ['permitAll']],
	[pattern: '/forbidden',      access: ['permitAll']],
	[pattern: '/notFound.gsp',      access: ['permitAll']],
	[pattern: '/notFound',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']],
	[pattern: '/dbconsole/**', access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]

