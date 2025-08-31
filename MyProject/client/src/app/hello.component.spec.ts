import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { HelloComponent } from './hello.component';


describe('HelloComponent', () => {
  let component: HelloComponent;
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [],
    });
    httpMock = TestBed.inject(HttpTestingController);
    component = new HelloComponent();
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should set status to "Database is reachable" on success', () => {
    component.checkDb();
    const req = httpMock.expectOne('/api/health/db-status');
    req.flush({ status: 'Database is reachable' });
    expect(component.status()).toBe('Database is reachable');
  });

  it('should set status to "Database is NOT reachable" on error', () => {
    component.checkDb();
    const req = httpMock.expectOne('/api/health/db-status');
    req.error(new ErrorEvent('Network error'));
    expect(component.status()).toBe('Database is NOT reachable');
  });
});
