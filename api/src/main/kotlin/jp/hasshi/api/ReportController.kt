package jp.hasshi.api

import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseBody
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/report")
class ReportController(val reportService: ReportService) {
    @PostMapping("/create")
    @ResponseBody
    fun create(): Report {
        return reportService.create()
    }
}