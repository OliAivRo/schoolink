import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js';

export default class extends Controller {
  static targets = ['bar']
  static values = {
    gradesavg: Array
   }


  connect() {
    const gradesavgData = this.gradesavgValue;
    console.log(gradesavgData);
    Chart.register(...registerables);

    const labels = gradesavgData.map(item => item.section);
    const dataStudent = gradesavgData.map(item => item.avg_student);
    const dataSection = gradesavgData.map(item => item.avg_class);
    const colors = gradesavgData.map(item => item.color);

    new Chart(this.barTarget.getContext('2d'), {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: 'Class Average Grades',
          data: dataSection,
          fill: false,
          type: 'line',
          borderColor: 'rgb(52, 5, 163)',
          tension: 0.1
        }, {
          labels: 'Your child',
          data: dataStudent,
          backgroundColor: colors,
          borderColor: colors,
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          y: {
            beginAtZero: true,
            min: 0,
            max: 6
          }
        },
        plugins: {
          legend: {
            labels: {
              usePointStyle: true,
              pointStyle: 'line',
              filter: (legendItem, data) => (typeof legendItem.text !== 'undefined')
            }
          }
        }
      }
    });
  }
}
