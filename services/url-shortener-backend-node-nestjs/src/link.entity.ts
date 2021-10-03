import {Column, Entity, PrimaryColumn} from "typeorm";

@Entity()
export class Link {
    @PrimaryColumn()
    id: string;

    @Column()
    url: string;

    @Column({type:"timestamp"})
    created: Date;
}