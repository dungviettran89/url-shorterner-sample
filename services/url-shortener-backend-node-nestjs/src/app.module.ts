import {Module} from '@nestjs/common';
import {AppController} from './app.controller';
import {TypeOrmModule} from "@nestjs/typeorm";
import {Link} from "./link.entity";
const {DB_HOST,DB_PORT,DB_NAME,DB_USER,DB_PASS} = process.env
@Module({
    imports: [
        TypeOrmModule.forRoot({
            type: 'mysql',
            host: DB_HOST,
            port: parseInt(DB_PORT),
            username: DB_PASS,
            password: DB_USER,
            database: DB_NAME,
            entities: [Link],
            synchronize: true,
        }),
        TypeOrmModule.forFeature([Link])
    ],
    controllers: [AppController],
    providers: [],
})
export class AppModule {
}
