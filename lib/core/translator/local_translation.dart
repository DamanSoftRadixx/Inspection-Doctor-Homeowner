import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

class LocalString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'sp': {
          AppStrings.logout: "Cerrar sesión",
          AppStrings.date: "Fecha",
          AppStrings.images: "Imágenes",

          AppStrings.strNoInternetConnection: "Sin conexión",
          AppStrings.strPleaseCheckYourInternetConnectivity:
              "Por favor verifique su conectividad a Internet.",
          AppStrings.strSometingWentWrong: "Algo salió mal.",

          AppStrings.strError: "Error",
          AppStrings.add: "Agregar",
          AppStrings.alert: "Alerta",
          AppStrings.somethingWentWrong: "Algo salió mal.",

          AppStrings.and: " y ",
          AppStrings.ok: "DE ACUERDO",

          //Language
          AppStrings.selectLanguage: "Seleccione el idioma",
          AppStrings.continueBtn: "Continuar",

          //login
          AppStrings.welcomeToLogin: "Bienvenido a iniciar sesión",
          AppStrings.cONSTRUCTION: "CONSTRUCCIÓN",
          AppStrings.inspectionsDoctor: "Médico de inspecciones",

          AppStrings.fillLoginDetail:
              "Complete los detalles a continuación para iniciar sesión en su cuenta.",

          AppStrings.loginScreenPassword: "Contraseña",
          AppStrings.email: "Correo electrónico",
          AppStrings.forgotPassword: "¿Has olvidado tu contraseña?",
          AppStrings.dontHaveAccount: "¿No tienes una cuenta? ",
          AppStrings.signupCaps: "Inscribirse",
          AppStrings.orContinueWith: "O continuar con",

          //signup
          AppStrings.signup: "Inscribirse",
          AppStrings.registerStarted: "¡Regístrate para empezar!",
          AppStrings.fillDetail:
              "Complete los detalles a continuación para crear su cuenta.",
          AppStrings.firstName: "Nombre de pila",
          AppStrings.lastName: "Apellido",
          AppStrings.phoneNumber: "Número de teléfono",
          AppStrings.password: "Contraseña",
          AppStrings.confirmPassword: "Confirmar Contraseña",
          AppStrings.street: "Calle",
          AppStrings.address_line_1: "Dirección Línea 1",
          AppStrings.address_line_2: "Línea de dirección 2",
          AppStrings.city: "Ciudad",
          AppStrings.state: "Estado",
          AppStrings.zipCode: "Código postal",
          AppStrings.alreadyAccount: "¡Ya tienes una cuenta! ",
          AppStrings.mailingAddress: "Dirección de envio",
          AppStrings.login: "Log inAcceso",
          AppStrings.uploadPhoto: "Subir foto",
          AppStrings.removePhoto: "Quitar foto",
          AppStrings.takePhoto: "Tomar foto",
          AppStrings.uploadFromDevice: "Subir desde el dispositivo",
          AppStrings.addFile: "Agregar archivo",
          AppStrings.chooseOnMap: "Elige en el mapa",
          AppStrings.selectAddress: "Seleccionar dirección",

          AppStrings.searchAddress: "Buscar dirección",
          AppStrings.plotNumber: "Número gráfico",

          //OTP
          AppStrings.otp: "OTP",
          AppStrings.codeVerification: "Verificación de código",
          AppStrings.oTPSent: "OTP is sent toLa OTP se envía a",
          AppStrings.verify: "Verificar",
          AppStrings.expiresIn: "Expira en",
          AppStrings.dontYouReceivedOTP: "¿No recibiste OTP?",
          AppStrings.resendOTP: "Reenviar OTP",

          //Forgot
          AppStrings.forgot: "Olvidó",
          AppStrings.forgotpassword: "Has olvidado tu contraseña",
          AppStrings.sendlink: "Enviar enlace",
          AppStrings.sendOTP: "Enviar OTP",
          AppStrings.dontYouReceivedLink: "¿No recibiste el enlace?",
          AppStrings.resendlink: "Reenviar enlace",
          AppStrings.donworryItOccurs: "¡No te preocupes! ocurre",
          AppStrings.forgetPleaseEnterEmail:
              "Ingrese la dirección de correo electrónico vinculada con su cuenta y le enviaremos un enlace.",
          //Reset
          AppStrings.reset: "Reiniciar",
          AppStrings.resetcreatePassword: "Crear nueva contraseña",
          AppStrings.resetNewPasswordMustUnique:
              "Su nueva contraseña debe ser única de las utilizadas anteriormente.",
          AppStrings.resetNewPassword: "Nueva contraseña",
          AppStrings.resetConfirmPassword: "Confirmar Contraseña",

          AppStrings.uploadDocument: "Subir documento",

          //Dashboard
          AppStrings.homeTab: "Hogar",
          AppStrings.inspectionsTab: "Inspecciones",
          AppStrings.notificationTab: "Notificación",
          AppStrings.myProfileTab: "Mi perfil",

          //Common
          AppStrings.noDataFound: "Datos no encontrados",
          AppStrings.done: "Hecho",
          AppStrings.next: "Próximo",
          AppStrings.cancel: "Cancelar",
          AppStrings.connectionTimeOut: "La conexión ha expirado",
          AppStrings.close: "Cerca",
          AppStrings.yes: "Sí",
          AppStrings.no: "No",

          AppStrings.noData: "Datos no encontrados",
          AppStrings.listEmpty: "¡Aún no hay inspecciones!",

          //Add Property
          AppStrings.addPropertiesForInspection:
              "Agregar propiedades para inspección",
          AppStrings.youHaveNotAddedPropertyYet:
              "Aún no has agregado ninguna propiedad. Toque el botón de abajo para agregar.",
          AppStrings.addPropertyButton: "Agregar propiedad",
          AppStrings.addProperty: "Agregar propiedad",
          AppStrings.propertyNameNickName: "Nombre de la propiedad (apodo)",
          AppStrings.permitNumber: "Numero de permiso",
          AppStrings.lotNumber: "Numero de lote",
          AppStrings.blockNumber: "Número de bloque",
          AppStrings.county: "Condado",
          AppStrings.uploadArchitecturalDrawing: "Subir dibujo arquitectónico",
          AppStrings.uploadAPdf: "Sube un pdf",
          AppStrings.time: "Tiempo",
          AppStrings.addressNotAssigned: "Dirección no asignada",

          //Home List
          AppStrings.searchNameAddress: "Buscar por nombre y dirección",

          //Property Detail
          AppStrings.propertyDetail: "Detalle de propiedad",
          AppStrings.drawing: "Dibujo",
          AppStrings.edit: "Editar",
          AppStrings.delete: "Borrar",
          AppStrings.scheduleInspection: "Programar inspección",
          AppStrings.updateProperty: "Actualizar propiedad",
          AppStrings.contactPerson: "Persona de contacto",
          AppStrings.trackYourInspection:
              "Realice un seguimiento de su inspección",
          AppStrings.reschedule: "Reprogramar",

          //Select Cateories
          AppStrings.categories: "Categorías",
          AppStrings.pleaseSelectCategory:
              "Seleccione a continuación la categoría que desea.",

          //Inspection List

          AppStrings.pleaseSelectInspections:
              "Seleccione a continuación las inspecciones que desee.",
          AppStrings.schedule: "Cronograma",
          AppStrings.fillCategoryForm:
              "Complete el siguiente formulario para su inspección. Puede seleccionar múltiples franjas horarias.",
          AppStrings.contactPersonInformation:
              "Información de la persona de contacto",
          AppStrings.description: "Descripción",
          AppStrings.searchCategoryAndInspection:
              "Buscar por categoría y nombre de inspección",
          AppStrings.inspectionDetail: "Detalle de inspección",

          AppStrings.selectState: "Seleccione estado",

          //Permissions
          AppStrings.permissionDenied: "Permiso denegado",
          AppStrings.openSettings: "Configuración abierta ",
          AppStrings.accessWasPreviouslyDenied:
              "El acceso fue previamente denegado",
          AppStrings.areYouWantDelete:
              "¿Estás seguro de que quieres eliminar esta propiedad?",
          AppStrings.areYouWantLogout:
              "¿Estás seguro de que quieres cerrar sesión?",

          AppStrings.inspectionRequested: "Inspección solicitada",
          AppStrings.inspectorAssigned: "Inspector asignadod",
          AppStrings.inspectionRescheduled: "Inspección reprogramada",
          AppStrings.inspectionCanceled: "Inspección cancelada",
          AppStrings.inspectorIsOnTheWay: "El inspector está en camino",
          AppStrings.inspectionStarted: "Inspección iniciada",
          AppStrings.inspectionDone: "Inspección realizada",
          AppStrings.correctionRequired: "Corrección requerida",
          AppStrings.inspectionComplete: "Inspección completa",
          AppStrings.viewReport: "Vista del informe",
          AppStrings.giveFeedback: "Dar opinion",

          AppStrings.submitAndNotify: "Enviar y notificar",
          AppStrings.cancelInspection: "Cancelar inspección",
          AppStrings.areYouSureYouWantToCanelThisInspection:
              "¿Está seguro de que desea cancelar esta inspección? Toque el botón SÍ para cancelar.",

          AppStrings.inspectionReport: "Reporte de inspección",
          AppStrings.document: "Documento",
          AppStrings.inspector: "Inspector",

          ErrorMessages.emailIsEmpty:
              "Por favor introduzca su correo electrónico.",
          ErrorMessages.emailIsNotValid:
              "Por favor introduzca un correo electrónico válido.",
          ErrorMessages.firstNameIsEmpty:
              "Por favor, introduzca su nombre de pila.",
          ErrorMessages.firstNameMatch:
              "Su nombre debe tener al menos dos letras y ningún carácter inusual.",
          ErrorMessages.lastNameMatch:
              "Su apellido debe tener al menos dos letras y ningún carácter inusual.",
          ErrorMessages.lastNameIsEmpty: "Por favor ingrese su apellido.",
          ErrorMessages.addressIsEmpty: "Por favor ingrese su dirección.",
          ErrorMessages.phoneIsEmpty:
              "Por favor, introduzca su número de teléfono.",
          ErrorMessages.phoneValid:
              "Por favor ingrese un número de teléfono válido.",
          ErrorMessages.passwordIsEmpty: "Por favor, introduzca su contraseña.",
          ErrorMessages.newPasswordIsEmpty:
              "Por favor ingrese su nueva contraseña.",
          ErrorMessages.oldPasswordIsEmpty:
              "Por favor ingrese su antigua contraseña.",
          ErrorMessages.confirmPasswordIsEmpty:
              "Por favor ingrese su contraseña de confirmación.",
          ErrorMessages.passwordLength:
              "La contraseña debe contener 8 caracteres con combinaciones (Una mayúscula, una letra minúscula, un número y un carácter especial).",
          ErrorMessages.passwordMatches:
              "La contraseña y la contraseña de confirmación no coinciden.",
          ErrorMessages.restPasswordMatches:
              "La contraseña nueva y la contraseña confirmada no coinciden.",
          // ErrorMessages.noDataFound: "No data found",
          ErrorMessages.otpIsEmpty: "Por favor ingrese su otp.",
          ErrorMessages.pleaseSelectAppLanguage:
              "Seleccione el idioma de la aplicación.",
          ErrorMessages.pleaseEnter4DigitOtp: "Por favor ingrese su OTP.",
          ErrorMessages.otpIsIncorrect: "Otp es incorrecto.",
          ErrorMessages.pleaseEnterCompleteOTP:
              "Por favor ingresa una OTP válida.",
          ErrorMessages.pleasSelectLanguage: "Por favor seleccione idioma.",
          ErrorMessages.pleasEnterAddress: "Por favor ingrese la dirección.",
          ErrorMessages.pleaseEnterCity: "Por favor ingresa la ciudad.",
          ErrorMessages.pleaseEnterZipCode:
              "Por favor ingrese el código postal.",

//add property

          ErrorMessages.propertyEmty:
              "Por favor ingrese el nombre de la propiedad.",
          ErrorMessages.streetEmty: "Por favor ingrese el nombre de la calle.",
          ErrorMessages.cityEmty: "Por favor ingrese el nombre de la ciudad.",
          ErrorMessages.stateEmty: "Por favor ingrese el nombre del estado.",
          ErrorMessages.zipCodeEmty: "Por favor ingrese el código postal.",
          ErrorMessages.permitEmty: "Por favor ingrese el número de permiso.",
          ErrorMessages.lotEmty: "Por favor ingrese el número de LOTE.",
          ErrorMessages.blockEmty: "Por favor ingrese el número de bloque.",
          ErrorMessages.countyEmty: "Por favor seleccione el condado.",
          ErrorMessages.docEmty: "Por favor cargue un dibujo arquitectónico.",
          ErrorMessages.dateEmty: "Por favor seleccione fecha.",
          ErrorMessages.timeEmty: "Por favor seleccione la hora.",

          InspectionListStatus.inspectorIsNotAssignedYet:
              "El inspector no está asignado todavía.",
          InspectionListStatus.scheduled: "Programado",
          InspectionListStatus.rescheduled: "Reprogramado",
          InspectionListStatus.canceled: "Cancelado",
          InspectionListStatus.onTheWay: "En camino",
          InspectionListStatus.done: "Hecho",
          InspectionListStatus.correctionRequired: "Corrección requerida",
          InspectionListStatus.inspectionComplete: "Inspección completa",

          AppStrings.youHaveRequested: "Tú lo pediste",
          AppStrings.inspectionBy: "inspección por",
          AppStrings.isAssignedAndInspectionIsScheduledAt:
              "está asignado y la inspección está programada en",
          AppStrings.youHaveRescheduledTheInspectionAt:
              "Ha reprogramado la inspección en",
          AppStrings.youHaveCanceledTheinspection:
              "Ha cancelado la inspección.",
          AppStrings.canceledTheInspection: "Canceló la inspección",
          AppStrings.rescheduledTheInspectionAt: "reprogramó la inspección en",
          AppStrings.isOnTheWayForInspection:
              "está en camino para la inspección",
          AppStrings.hasStartedTheInspection: "ha iniciado la inspección",
          AppStrings.hasCompletedTheInspctionAndNowWaitForTheReport:
              "Ha completado la inspección y ahora espera el informe.",
          AppStrings.hasSubmittedTheReportCorrectionIsRequired:
              "ha presentado el informe. Se requiere corrección, consulte el informe desde aquí",
          AppStrings.hasSubmittedTheReportYourInspectionIsApproved:
              "ha presentado el informe. Su inspección está aprobada. Por favor vea el informe desde aquí",
          AppStrings.signIn: "Iniciar sesión",
        }
      };
}
