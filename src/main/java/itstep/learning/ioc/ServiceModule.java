package itstep.learning.ioc;

import com.google.inject.AbstractModule;
import itstep.learning.service.DbService;
import itstep.learning.service.LocalDbService;

public class ServiceModule extends AbstractModule {
    @Override
    protected void configure() {
        bind(DbService.class).to(LocalDbService.class);
    }
}