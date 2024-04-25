package jp.hasshi.api.demo

import org.springframework.stereotype.Service

interface HelloService {
    fun sayHello(): String
}

@Service
class HelloServiceImpl: HelloService {
    override fun sayHello(): String {
        TODO("Not yet implemented")
    }
}