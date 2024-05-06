package jp.hasshi.api.controller

import jp.hasshi.api.domain.model.Report
import jp.hasshi.api.service.ReportService
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
    fun create(body: SaveReportBody): Report {
        //@ResponseBody: キーと値のペアでデータを受け取る
        //@ModelAttribute: jsonなどのオブジェクトを受け取る
        return reportService.create(body.text)
    }
}

data class SaveReportBody(val text: String = "")