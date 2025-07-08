import http from 'k6/http';
import { sleep } from 'k6';


// MODIFICAR VALORES SEGÚN LO REQUERIDO
const MAX_VUS = 100
const BEARER_TOKEN = 'dd5f78b3-6e58-4f91-ad37-407012fa66e9.f48e13b2-ed63-4c21-9f67-08e5f6c93677.4883c1c8-c866-46f5-afa3-3b9d0982ff34'
const URL = 'http://localhost:8080/did'

export const options = {
  // Key configurations for Stress in this section
  stages: [
    { duration: '15s', target: MAX_VUS }, // traffic ramp-up
    { duration: '3m', target: MAX_VUS }, // stay
    { duration: '15s', target: 0 }, // leave
  ],

  tags: {
    source: "k6-common",
    test_name: __ENV.TEST_NAME || "default-test", // Tag dinámico que cambia en cada test
  },
};

export default () => {
  const params = {};

  if(BEARER_TOKEN) {
    params.headers = {
      Authorization: `Bearer ${BEARER_TOKEN}`,
    }
  }

  const res = http.get(URL, params);
  sleep(1);
};