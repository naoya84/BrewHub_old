package jp.hasshi.api

import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/report")
class ReportController(val reportService: ReportService) {
    @GetMapping
    fun getAll(): List<Report> {
        return reportService.getAll()
    }

    @PostMapping("/create")
    @ResponseStatus(HttpStatus.CREATED)
    fun create(@RequestBody body: SaveReportBody): Report {
        return reportService.create(body.text)
    }
}

data class SaveReportBody(var text: String)