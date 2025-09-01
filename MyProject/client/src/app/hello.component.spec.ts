import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { HelloComponent } from './hello.component';

describe('HelloComponent', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, HelloComponent],
    }).compileComponents();
  });

  it('should create', () => {
    const fixture = TestBed.createComponent(HelloComponent);
    const component = fixture.componentInstance;
    expect(component).toBeTruthy();
  });
});
