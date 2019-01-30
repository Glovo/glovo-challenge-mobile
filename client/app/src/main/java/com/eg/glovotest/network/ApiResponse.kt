package com.eg.glovotest.network

class ApiResponse {

    /**
     *  TODO Use generic APIRESPONSE to manage API errors
     */

    var responseObjects: List<Any>? = null
    var error: Throwable? = null

    constructor(responseObjects: List<Any>) {
        this.responseObjects = responseObjects
        this.error = null
    }

    constructor(error: Throwable){
        this.error = error
        this.responseObjects = null
    }
}