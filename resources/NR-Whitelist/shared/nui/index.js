hasCompleted = false;
questionTime = 0;
currentQuestion = 1;
var questions;
var messages = {};
var playerName;
var serverName;
var maxQuestions = 0;
var time;
var percentage;
var rulesURL;

if (!String.format) {
    String.format = function (format) {
        var args = Array.prototype.slice.call(arguments, 1);
        return format.replace(/{(\d+)}/g, function (match, number) {
            return typeof args[number] != 'undefined'
                ? args[number]
                : match
                ;
        });
    };
}

if (!Array.from) {
    Array.from = (function () {
        var toStr = Object.prototype.toString;
        var isCallable = function (fn) {
            return typeof fn === 'function' || toStr.call(fn) === '[object Function]';
        };
        var toInteger = function (value) {
            var number = Number(value);
            if (isNaN(number)) {
                return 0;
            }
            if (number === 0 || !isFinite(number)) {
                return number;
            }
            return (number > 0 ? 1 : -1) * Math.floor(Math.abs(number));
        };
        var maxSafeInteger = Math.pow(2, 53) - 1;
        var toLength = function (value) {
            var len = toInteger(value);
            return Math.min(Math.max(len, 0), maxSafeInteger);
        };
        // The length property of the from method is 1.
        return function from(arrayLike /*, mapFn, thisArg */) {
            // 1. Let C be the this value.
            var C = this;
            // 2. Let items be ToObject(arrayLike).
            var items = Object(arrayLike);
            // 3. ReturnIfAbrupt(items).
            if (arrayLike == null) {
                throw new TypeError(
                    "Array.from requires an array-like object - not null or undefined");
            }
            // 4. If mapfn is undefined, then let mapping be false.
            var mapFn = arguments.length > 1 ? arguments[1] : void undefined;
            var T;
            if (typeof mapFn !== 'undefined') {
                // 5. else
                // 5. a If IsCallable(mapfn) is false, throw a TypeError exception.
                if (!isCallable(mapFn)) {
                    throw new TypeError(
                        'Array.from: when provided, the second argument must be a function');
                }
                // 5. b. If thisArg was supplied, let T be thisArg; else let T be undefined.
                if (arguments.length > 2) {
                    T = arguments[2];
                }
            }
            // 10. Let lenValue be Get(items, "length").
            // 11. Let len be ToLength(lenValue).
            var len = toLength(items.length);
            // 13. If IsConstructor(C) is true, then
            // 13. a. Let A be the result of calling the [[Construct]] internal method 
            // of C with an argument list containing the single item len.
            // 14. a. Else, Let A be ArrayCreate(len).
            var A = isCallable(C) ? Object(new C(len)) : new Array(len);
            // 16. Let k be 0.
            var k = 0;
            // 17. Repeat, while k < len… (also steps a - h)
            var kValue;
            while (k < len) {
                kValue = items[k];
                if (mapFn) {
                    A[k] = typeof T === 'undefined' ? mapFn(kValue, k) : mapFn.call(T,
                        kValue, k);
                } else {
                    A[k] = kValue;
                }
                k += 1;
            }
            // 18. Let putStatus be Put(A, "length", len, true).
            A.length = len;
            // 20. Return A.
            return A;
        };
    }());
}


'use strict';
var myQuiz = {
    container: null,
    // helper function
    createElement: function (o) {
        var el, p;
        if (o && (o.tag || o.tagName)) {
            el = document.createElement(o.tag || o.tagName);
            if (o.text || o.txt) {
                var text = (o.text || o.txt)
                el.innerHTML = text;
            }
            for (p in o) {
                if (!p.match(/^t(e)?xt|tag(name)?$/i)) {
                    el[p] = o[p];
                }
            }
        }
        return el;
    },
    // user interface for a quiz question
    createOptions: function () {
        var t = this,
            options = [],
            ul = document.createElement("ul");
        t.emptyContainer();
        t.intoContainer(t.createElement({
            className: "appQuestionTitle",
            tag: "span",
            text: _localeType("question") + ": " + t.currentQuestion.question
        }));
        t.intoContainer(ul);
        // create options
        questionTime = time;
        document.getElementById('currentQuestionTime').innerHTML = '<i class="fal fa-clock" style="margin-right: 2px;"></i> ' + questionTime + " " + _localeType("seconds");
        document.getElementById('currentQuestion').innerHTML = '<i class="fal fa-info-circle" style="margin-right: 2px;"></i> ' + _localeType("question") + ' ' + currentQuestion + ' ' + _localeType("of") + ' ' + maxQuestions;
        options.push(t.currentQuestion.solution);
        t.currentQuestion.falses.forEach(function (s) {
            options.push(s);
        });
        t.shuffleArray(options);
        options.forEach(function (s, i) {
            var li = document.createElement("li"),
                label = t.createElement({
                    htmlFor: "a" + t.questions.length + "_" + i,
                    tag: "label",
                    text: s
                }),
                radio = t.createElement({
                    id: "a" + t.questions.length + "_" + i,
                    name: "answer",
                    tag: "input",
                    type: "radio",
                    tabindex: "0",
                    value: s
                });
            ul.appendChild(li);
            li.appendChild(radio);
            li.appendChild(label);
        });

        t.intoContainer(t.createElement({
            tag: "button",
            text: "yes",
            type: "submit"
        }));
    },
    currentChoices: [],
    currentQuestion: null,

    data: questions,
    emptyContainer: function () {
        var t = this;
        while (t.container.firstChild) {
            t.container.removeChild(t.container.firstChild);
        }
    },
    handleInput: function () {
        questionTime = time;

        var t = this,
            inputs = Array.from(t.container.getElementsByTagName("input")),
            selectedSolution = "/";
        inputs.forEach(function (o) {
            if (o.checked) {
                selectedSolution = o.value;
            }
        });

        if (selectedSolution && selectedSolution != "/" && t.currentQuestion) {
            t.currentChoices.push({
                a: selectedSolution,
                q: t.currentQuestion
            });

            currentQuestion++;

            document.getElementById('currentQuestion').innerHTML = '<i class="fal fa-info-circle"></i> ' + _localeType("question") + ' ' + currentQuestion + ' ' + _localeType("of") + ' 0';
            t.play();
        }
        // accept start button
        if (!t.currentQuestion) {
            t.play();
        }
    },
    init: function (data) {
        var t = this;
        // here goes any code for loading data from an external source
        t.container = document.getElementById("appQuestionContainer");
        t.data = data.questions;

        if (t.data.length && t.container) {
            // use anonymous functions so in handleInput
            // "this" can point to myQuiz
            t.container.addEventListener("submit", function (ev) {
                t.handleInput();
                ev.stopPropagation();
                ev.preventDefault();
                return false;
            });
            t.container.addEventListener("mouseup", function (ev) {
                // we want to only support clicks on start buttons...
                var go = ev.target.tagName.match(/^button$/i);
                // ... and labels for radio buttons when in a game
                if (ev.target.tagName.match(/^label$/i) && t.currentQuestion) {
                    go = true;
                }
                if (go) {
                    window.setTimeout(function () {
                        t.handleInput();
                    }, 50);
                    ev.stopPropagation();
                    ev.preventDefault();
                    return false;
                }
            });
            t.start();
        }
    },
    intoContainer: function (el, parentType) {
        var t = this,
            parent;
        if (!el) {
            return;
        }
        if (parentType) {
            parent = document.createElement(parentType);
            parent.appendChild(el);
        } else {
            parent = el;
        }
        t.container.appendChild(parent);
        return parent;
    },
    // ask next question or end quiz if none are left
    play: function () {
        questionTime = time;

        var t = this,
            ol;
        // game over?
        if (currentQuestion > maxQuestions) {
            t.showResults();
            return;
        }

        t.currentQuestion = t.questions.shift();
        t.createOptions();
        document.getElementById('appContent').innerHTML = "";
    },
    // list with remaining quiz question objects
    questions: [],
    // list original questions and given answers and elaborate on solutions
    showResults: function () {
        var cat, ol, s, scores = {},
            t = this,
            tab, thead, tbody, tr;

        t.emptyContainer();

        questionTime = 0;

        document.getElementById('appContent').innerHTML = "";
        document.getElementById('currentQuestion').innerHTML = "";
        document.getElementById('currentQuestionTime').innerHTML = "";

        // display a kind of percentual score over the categories
        cat = [];
        t.currentChoices.forEach(function (o) {
            if (!cat.includes(o.q.category)) {
                cat.push(o.q.category);
            }
        });
        cat.sort();
        cat.forEach(function (c) {
            var correct = 0,
                num = 0;
            t.currentChoices.forEach(function (o) {
                if (o.q.category == c) {
                    num++;
                    if (o.q.solution == o.a) {
                        correct++;
                    }
                }
            });
            scores[c] = Math.floor(100 * correct / num) + "%";
        });

        for (s in scores) {
            $.post('http://NR-Whitelist/resultWhitelist', JSON.stringify({
                percentage: parseInt(scores[s])
            }));
        }

        t.emptyContainer();
    },
    // helper function: shuffle array (adapted from http://javascript.jstruebig.de/javascript/69)
    shuffleArray: function (a) {
        var i = a.length;
        while (i >= 2) {
            var zi = Math.floor(Math.random() * i);
            var t = a[zi];
            a[zi] = a[--i];
            a[i] = t;
        }
        // no return argument since the array has been
        // handed over as a reference and not a copy!
    },
    // start quiz with a start button
    start: function () {
        var t = this;
        t.questions = [];
        t.data.forEach(function (o) {
            t.questions.push(o);
        });
        t.shuffleArray(t.questions);
        t.currentChoices = [];
        t.currentQuestion = null;

        element = t.createElement({
            className: "startBtn",
            tag: "button",
            text: _localeType("start_test")
        });

        element.setAttribute("id", "startBtn")

        t.intoContainer(element, "p");
    }
};

window.onload = function (e) {
    window.addEventListener('message', function (event) {
        if (event.data.type == "enableui") {
            playerName = event.data.playerName;
            serverName = event.data.serverName;
            time = event.data.time;
            rulesURL = event.data.rules;
            maxQuestions = event.data.maxQuestions;
            percentage = event.data.percentage;

            messages = JSON.parse(event.data.messageData);
            translateContainer();
            document.getElementById('bodyContainer').style.display = event.data.enable ? "block" : "none";

            if (event.data.enable)
                fetch("questions.json")
                    .then(response => response.json())
                    .then(json => {
                        myQuiz.init(json);
                    });
        }
    });
}

function translateContainer() {
    $("#test_content").html(_localeType("test_content").replace("{player_name}", playerName).replace("{time}", time).replace("{seconds}", _localeType("seconds")).replace("{percentage}", percentage).replace("{percentage}", percentage).replace("{max_questions}", maxQuestions));
    $("#warning").text(_localeType("warning"));
    $("#welcome").html(_localeType("welcome"));
    $(".appTitle").text(_localeType("menuTitle"));
    $("#server_name").text(serverName);
}

setInterval(function () {
    if (questionTime > 0) {
        questionTime--;
        document.getElementById('currentQuestionTime').innerHTML = questionTime > 1 ? '<i class="fal fa-clock" style="margin-right: 2px;"></i> ' + questionTime + ' ' + _localeType("seconds") : '<i class="fal fa-clock" style="margin-right: 2px;"></i> ' + questionTime + ' ' + _localeType("second");

        if (questionTime == 0) {
            var t = myQuiz, inputs = Array.from(t.container.getElementsByTagName("input")), selectedSolution = "";
            selectedSolution = "Wrong answer.";

            if (t.currentQuestion) {
                t.currentChoices.push({
                    a: selectedSolution,
                    q: t.currentQuestion
                });

                currentQuestion++;

                document.getElementById('currentQuestion').innerHTML = '<i class="fal fa-info-circle" style="margin-right: 2px;"></i> ' + currentQuestion + ' ' + _localeType("of") + ' 0';
                t.play();
            }

            if (!t.currentQuestion) {
                t.play();
            }
        }
    }
}, 1000)


function _localeType(/**/) {
    var args = arguments;
    if (messages[args[0]] != undefined)
        return String.format(messages[args[0]], args[1])
    else
        return "Not translated: " + args[0]
}