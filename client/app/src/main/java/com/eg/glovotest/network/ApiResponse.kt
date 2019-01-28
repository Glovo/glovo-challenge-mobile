package com.eg.glovotest.network

class ApiResponse {

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