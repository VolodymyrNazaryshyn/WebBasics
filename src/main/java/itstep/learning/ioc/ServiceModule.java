package itstep.learning.ioc;

import com.google.inject.AbstractModule;
import itstep.learning.service.DbService;
import itstep.learning.service.HashService;
import itstep.learning.service.LocalDbService;
import itstep.learning.service.Md5HashService;

public class ServiceModule extends AbstractModule {
    @Override
    protected void configure() {
        bind(DbService.class).to(LocalDbService.class);
        bind(HashService.class).to(Md5HashService.class);
    }
}