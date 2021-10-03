import {Body, Controller, Get, Logger, Param, Post, Res} from '@nestjs/common';
import {InjectRepository} from "@nestjs/typeorm";
import {Link} from "./link.entity";
import {Repository} from "typeorm";
import {Response} from "express";
import {generateId, validUrl} from "./link.utils";

@Controller()
export class AppController {
    private readonly logger: Logger = new Logger(AppController.name);

    constructor(
        @InjectRepository(Link) private linkRepository: Repository<Link>
    ) {
    }

    @Get(":id")
    async getLink(@Param() {id}: any, @Res() response: Response) {
        this.logger.log(`GET /${id}`);
        let link = await this.linkRepository.findOne(id);
        if (link === undefined) {
            this.logger.log(`GET /${id} response=NOT_FOUND`);
            return response.sendStatus(404);
        }
        this.logger.log(`GET /${id} response=redirect to ${link.url}`);
        return response.redirect(link.url);
    }

    @Post("new")
    async newLink(@Body() request: { url: string }, @Res() response: Response) {
        this.logger.log(`POST /new request=${JSON.stringify(request)}`);
        let {url} = request;
        if (!validUrl(url)) {
            this.logger.log(`POST /new request=${JSON.stringify(request)} response=NOT_FOUND`);
            return response.sendStatus(400);
        }
        let entity = new Link();
        entity.id = generateId(url);
        entity.url = url;
        entity.created = new Date();
        entity = await this.linkRepository.save(entity);
        this.logger.log(`POST /new request=${JSON.stringify(request)} response=${JSON.stringify(entity)}`);
        return response.json(entity);
    }
}
