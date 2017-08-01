/**
 * Created by HP on 2016-12-09.
 */




// $('#btn_click').on('click', function () {

function drawGraphWith1stInClass(subjects, terms, marks, class1stMarks) {
    console.log('start the function');
    try {
        var st = (terms.length - 1) * subjects.length;
        var studentMarks = [];
        // var class1stMarksD = [];
        var j = 0;
        for (i = st; i < marks.length; i++) {
            studentMarks.push(parseFloat(marks[i]));
            // classAvgD.push(classAvg[j]);
            j++;

        }
        ;

        console.log(class1stMarks);
    } catch (e) {
        console.log(e);
    }


    Highcharts.chart('cmpfirstchart', {
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Marks variation with 1st in class'
        },
        subtitle: {
            text: 'Subject marks in last term test'
        },
        xAxis: [{
            categories: subjects,
            reversed: true,

            labels: {
                step: 1
            }
        }, { // mirror axis on right side
            opposite: true,
            reversed: true,
            categories: subjects,
            linkedTo: 0,
            labels: {
                step: 1
            }
        }],
        yAxis: {
            title: {
                text: null
            },
            max: 100,
            min: -100,
            labels: {
                formatter: function () {
                    return Math.abs(this.value) + '%';
                }
            }
        },

        plotOptions: {
            series: {
                stacking: 'normal'
            }
        },

        tooltip: {
            formatter: function () {
                return '<b>' + this.series.name + ' : For - ' + this.point.category + '</b><br/>' +
                    'Marks: ' + Highcharts.numberFormat(Math.abs(this.point.y), 0);
            }
        },

        series: [{
            name: '1st of class',
            data: class1stMarks
        }, {
            name: $("#studentName").text(),
            data: studentMarks
        }]
    });

}

function drawClassAvgGraph(subjects, term, marks, classAvg) {

    // console.log('Come here');
    var st = (term.length - 1) * subjects.length;
    var studentMarks = [];
    var classAvgD = [];
    var j = 0;
    for (i = st; i < marks.length; i++) {
        studentMarks.push(parseFloat(marks[i]));
        classAvgD.push(classAvg[j]);
        j++;

    }
    ;

    Highcharts.chart('classavgchart', {
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: 'Average marks of student with class average'
        },
        subtitle: {
            text: ''
        },
        xAxis: [{
            categories: subjects,
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            min: 0,
            max: 100,
            labels: {
                format: '{value}',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            title: {
                text: 'Class Average',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            }
        }, { // Secondary yAxis
            min: 0,
            max: 100,
            title: {
                text: 'Marks of student',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value}',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 120,
            verticalAlign: 'middle',
            y: 100,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        series: [{
            name: 'Marks of student',
            type: 'column',
            yAxis: 1,
            data: studentMarks,


        }, {
            name: 'Class Average',
            type: 'spline',
            data: classAvg,
            tooltip: {
                valueSuffix: null
            }
        }]
    });
}


function drawLastTermMarksGraph(subjects, terms, marks, grade) {
    var marksDraw = [];
    var c = 0;
    for (j = 0; j < terms.length; j++) {
        var temp = [];
        for (i = 0; i < subjects.length; i++) {
            temp.push(parseInt(marks[c]));
            c++;
        }
        marksDraw.push(temp);

    }


    Highcharts.chart('allmarkschart', {
        chart: {
            type: 'bar',
            inverted: true,
            polar: false
        },
        title: {
            text: 'All marks in ' + grade
        },
        subtitle: {
            text: ''
        },
        xAxis: {

            categories: subjects,
            title: {
                text: 'Subjects'
            }
        },
        yAxis: {
            min: 0,
            max: 100,
            title: {
                text: 'Marks (%) ',
                align: 'high'
            },
            labels: {
                overflow: 'justify'
            }
        },
        tooltip: {
            valueSuffix: ' %'
        },
        plotOptions: {
            bar: {
                dataLabels: {
                    enabled: false
                }
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -40,
            y: 80,
            floating: true,
            borderWidth: 1,
            backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
            shadow: true
        },
        credits: {
            enabled: false
        },
        series: [{
            name: terms[0] + ' Term',
            data: marksDraw[0]
        }, {
            name: terms[1] + ' Term',
            data: marksDraw[1]
        }, {
            name: terms[2] + ' Term',
            data: marksDraw[2]
        }]
    });


}

function drawRankInClassGraph($year, $ranks) {
    console.log('this is it');
    Highcharts.chart('rank_in_class', {
        chart: {
            type: 'line'
        },
        title: {
            text: 'Rank in the class'
        },
        subtitle: {
            text: 'out of 40 students'
        },
        xAxis: {
            categories: $year
        },
        yAxis: {
            reversed: true,
            min: 1,

            title: {
                text: 'Place '
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: false
                },
                enableMouseTracking: true
            }
        },
        series: [{
            name: ' ',
            data: $ranks
        },]
    });

}

function drawCompareSubjectMarksAvg(name1, name2, categories, marks1, marks2, subject) {
    Highcharts.chart('cmp_with_student_subject_avg_chart', {
        chart: {
            type: 'area',
            inverted: true
        },
        title: {
            text: 'Average marks for ' + subject
        },
        subtitle: {
            style: {
                position: 'absolute',
                right: '0px',
                bottom: '10px'
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -10,
            y: 10,
            floating: true,
            borderWidth: 1,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
        },
        xAxis: {
            categories: categories
        },
        yAxis: {
            title: {
                text: 'Average Marks'
            },
            labels: {
                formatter: function () {
                    return this.value;
                }
            },
            min: 0,
            max: 100
        },
        plotOptions: {
            area: {
                fillOpacity: 0.5
            }
        },
        series: [{
            name: name1,
            data: marks1
        }, {
            name: name2,
            data: marks2
        }]
    });
}

function drawCompareSubjectMarks(name1, name2, categories, marks1, marks2, subject) {
    Highcharts.chart('cmp_with_student_subject_chart', {
        chart: {
            type: 'spline'
        },
        title: {
            text: 'Compare ' + subject + ' marks with ' + name2
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            // type: 'datetime',
            labels: {
                overflow: 'justify'
            },
            categories: categories
        },
        yAxis: {
            title: {
                text: 'Marks'

            },
            max: 100,
            min: 0,

            minorGridLineWidth: 0,
            gridLineWidth: 0,
            alternateGridColor: null,
            plotBands: [{ // Light air
                from: 0,
                to: 20,
                color: 'rgba(68, 170, 213, 0.1)',
                label: {
                    text: 'Very Weak',
                    style: {
                        color: '#FF795C'
                    }
                }
            }, { // Light breeze
                from: 20,
                to: 45,
                color: 'rgba(0, 0, 0, 0)',
                label: {
                    text: 'Weak',
                    style: {
                        color: '#FAAE9D'
                    }
                }
            }, { // Gentle breeze
                from: 45,
                to: 60,
                color: 'rgba(68, 170, 213, 0.1)',
                label: {
                    text: 'Moderate',
                    style: {
                        color: '#606060'
                    }
                }
            }, { // Moderate breeze
                from: 60,
                to: 80,
                color: 'rgba(0, 0, 0, 0)',
                label: {
                    text: 'Good',
                    style: {
                        color: '#6BFBFF'
                    }
                }
            }, { // Fresh breeze
                from: 80,
                to: 100,
                color: 'rgba(68, 170, 213, 0.1)',
                label: {
                    text: 'Excelent',
                    style: {
                        color: '#4EAFFF'
                    }
                }
            }]
        },
        tooltip: {
            valueSuffix: ' %'
        },
        plotOptions: {
            spline: {
                lineWidth: 4,
                states: {
                    hover: {
                        lineWidth: 5
                    }
                },
                marker: {
                    enabled: false
                }

            }
        },
        series: [{
            name: name1,
            data: marks1

        }, {
            name: name2,
            data: marks2
        }],
        navigation: {
            menuItemStyle: {
                fontSize: '10px'
            }
        }
    });
}

function drawAvgMarksGraphsForAll(grades, subjects, series) {

    console.log(series);
    Highcharts.chart('marksChart', {
        title: {
            text: 'Average marks for each subject',
            x: -20 //center
        },
        subtitle: {
            text: null,
            x: -20
        },
        xAxis: {
            title: {
                text: 'Grades'
            },
            categories: grades
        },
        yAxis: {
            min: 0,
            max: 100,
            title: {
                text: 'Marks (%)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        // tooltip: {
        //     valueSuffix: '°C'
        // },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle',
            borderWidth: 0
        },
        series: series
    });


}


