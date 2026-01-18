# Async-Await-and-Actors---Concurrency-in-Swift
Learn async/await, actors, async-let, task groups, unstructured concurrency, detached tasks and more!

<!--1.Understanding Concurrent Programming in iOS-->
<div class="container">
  <details>
    <!--Title-->
    <summary><h2>1️⃣ Understanding Concurrent Programming in iOS</h2></summary>
    <!--Contents-->
    <ul>
      <li><h3>What is Concurrency?</h3></li>
      <p><b>Concurrency (동시성): 여러가지 일을 동시에 하려고 하는 것</b></p>
      <ul>
        <li>Impl: 시분할 (Time-slicing)을 통해 구현 or Host OS의 Multi CPU core 사용이 가능한 경우, 병렬처리 방식으로 구현</li>
        <br>
        <div>
          <img width="100%" height="100%" src="https://github.com/user-attachments/assets/abf6f709-84a0-40c9-b3c3-e9ae9facad30" />
          <p>
            Main-Thread는 <b>한 번에 하나씩 작업을 처리</b>하는 <b>"Serial Queue"</b>이므로, <br>
            Downloading Images와 같이 무거운 작업이 진행될 때, 해당 스레드를 점유하고 있어 다른 UI Event 진행이 불가능
          </p>
          <img width="100%" height="100%" src="https://github.com/user-attachments/assets/d8c48e6b-6740-4319-be8e-c4a1be600a2c" />
          <p>Image나 기타 자료를 다운로드하는 무거운 작업들은 Background-Thread에서 수행!</p>
          <br>
          <blockquote>
            <b>⭐ Main Queue는 UI Event나 매우 빠르게 발생할 수 있는 event를 위해 사용! <br><br>
              -> 사용자 인터페이스는 매끄럽고 부드럽게 작동해야 하며, 어떠한 작업을 수행하더라도 끊김이 있어서는 안됨
            </b>
          </blockquote>
        </div>
      </ul>
      <br>
      <li><h3>Grand Central Dispatch</h3></li>
      <p><b>Concurrency (동시성): 여러가지 일을 동시에 하려고 하는 것</b></p>
      <blockquote>
        <b>즉, GCD는 OS 레벨의 동시성/멀티스레딩을 위한 라이브러리로, Dispatch Framework를 통해 사용 가능</b>
      </blockquote>
      <ul>
        <li>Dispatch Queue의 특성</li>
        <br>
        <div>
          <img width="100%" height="100%" src="https://github.com/user-attachments/assets/09ac1773-37c7-4a58-bc0f-ddf96c731492" />
          <ul>
            <li><b>Serial (직렬): 모든 작업들을 "다른 하나의 thread로 보냄"</b> (-> 작업들의 순서가 중요한 경우에는 직렬처리가 필요할 수 있음)</li>
            <li><b>Concurrent (동시): 모든 작업들을 "여러개의 thread로 보냄"</b> (-> 작업의 중요도 및 성격 등을 고려했을 때, 유사한 여러개의 작업 처리 시, 사용)</li>
          </ul>
        </div>
        <br>
        <li>Dispatch Queue의 종류</li>
        <br>
        <div>
          <img width="100%" height="100%" src="https://github.com/user-attachments/assets/d60152ec-6c55-4105-aaa2-222cee4621a4" />
          <ul>
            <li><b>Main Queue</b>: GCD가 제공하는 시스템 큐로, <b>UI 작업 처리에 사용되는 직렬 큐</b> (e.g. <code>DispatchQueue.main</code>)</li>
            <li><b>Global Queue</b>: GCD가 제공하는 글로벌 동시 큐로, <b>여러 작업을 동시에 실행할 수 있는 큐</b> (e.g. <code>DispatchQueue.global(qos:)</code>)</li>
            <li>Custom Queue: 사용자 정의 직렬/동시 큐 (e.g. <code>DispatchQueue(label:, attributes:)</code>)</li>
          </ul>
        </div>
      </ul>
    </ul>
  </details>
</div>
<br>

<!--2.Getting Started with Async and Await-->
<div class="container">
  <details>
    <!--Title-->
    <summary><h2>2️⃣ Getting Started with Async and Await</h2></summary>
    <!--Contents-->
    <ul>
      <li><h3>Sync vs Async</h3></li>
      <ul>
        <li><b>Synchronous (동기): 작업을 시키고 작업의 완료를 기다림</b></li>
        <br>
        <div>
          <img width="100%" height="100%" src="https://github.com/user-attachments/assets/8d725a51-d9aa-4f55-93cc-cfddcdb4d8cb" />
          즉, 작업이 끝날 때까지 <b>해당 thread가 점유되어 다른 작업 수행이 불가능!</b> <br><br>
          <blockquote>
            <b>⭐ thread가 점유되어 다른 일의 수행이 불가능한 상태를 'Thread-Blocking'이라고 한다</b>
          </blockquote>
        </div>
        <br>
        <li><b>Asynchronous (비동기): 작업을 시키고 작업의 완료를 기다리지 않음</b></li>
        <br>
        <div>
          <img width="100%" height="100%" src="https://github.com/user-attachments/assets/e11d9834-ac30-4cc5-9757-25aade558918" />
          즉, <b>해당 thread가 점유되지 않아 다른 작업 수행이 가능!</b> <br><br>
          <blockquote>
            <b>이를 'Non Thread-Blocking'이라고 한다</b>
          </blockquote>
        </div>
      </ul>
      <br>
      <li><h3>Async & Await</h3></li>
      <p><b>async, await: 기존의 비동기 처리 코드를 "동기 처리처럼" 보일 수 있도록 지원</b></p>
      <ul>
        <li>Async/await 등장 배경</li>
        <br>
        <div>
          <p>
            기존의 <code>@escaping</code> closures를 이용한 비동기 처리 코드는 Deeply-nested closures (중첩 클로저)가 됨으로써, <br>
            코드가 verbose (장황), complex (복잡), incorrect (부정확) 해졌고, 오류처리에 어려움이 있었음
          </p>
          <blockquote>
            <b>⭐ <code>async</code>/<code>await</code></b>가 등장함에 따라, <b>Straight-line code 작성 가능 + 가독성이 크게 향상</b>
          </blockquote>
          <ul>
            <li><b><code>async</code>: 함수가 비동기적임을 나타냄</b></li>
            <li><b><code>await</code>: 비동기 함수 및 비동기 Context 내에서 다른 비동기 함수를 호출할 때 사용</b></li>
            <br>
            <blockquote>
              비동기 context에는 <code>.task()</code>, <code>Task {}</code>, <code>async</code>함수 등이 존재
            </blockquote>
          </ul>
        </div>
        <br>
        <li>Async/await 내부 원리 (Thread Control)</li>
        <br>
        <div>
          <img width="100%" height="100%" src="https://github.com/user-attachments/assets/3ad9cdfa-6295-4d65-a60c-025228ce653b" />
          <ul>
            <li>호출: caller가 callee (async)를 호출하면, caller가 실행되던 Thread Control을 callee에게 전달</li>
            <li>진행: callee는 스레드 제어권을 포기하는 <b>'suspend가 가능'</b> (callee가 일시중단이 되면, caller도 일시중단됨)</li>
            <br>
            <blockquote>
              <b>⭐ <code>await</code></b>는 async 함수가 <b>"일시 중단될 수도 있음"</b>을 나타내며, 이는 <b>Non Thread-Blocking</b>이다 <br><br>
              -> 반드시 suspend 된다는 것이 아님!, 이로 인해 <code>await</code>를 <b>'potential suspension point (잠재적인 일시중단 지점)'</b>이라고 표현함
            </blockquote>
            <li>suspend: 스레드 제어권은 <b>System에게 전달되고</b>, System은 thread를 사용해 <b>다른 작업을 수행 (우선순위가 높은 작업부터 처리)</b></li>
            <br>
            <blockquote>
              <b>⭐ 함수가 일시중단된 동안 App의 상태가 크게 바뀔 수 있다</b> 
            </blockquote>
            <li>resume: suspend된 비동기 함수를 재개 (resume)하는 단계</li>
            <li>종료: callee가 종료되면, 스레드 제어권을 caller에게 반납</li>
            <br>
            <blockquote>
              스레드 제어권을 System으로부터 다시 전달받을 떄, 할당된 thread는 이전과는 다른 thread가 될 수도 있음
            </blockquote>
          </ul>
        </div>
      </ul>
    </ul>
  </details>
</div>
