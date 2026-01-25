# Async-Await-and-Actors---Concurrency-in-Swift
Learn async/await, actors, async-let, task groups, unstructured concurrency, detached tasks and more!

## 📖 Lectures
<!-- 1.Understanding Concurrent Programming in iOS -->
<article class="lecture1">
  <details>
    <!-- Title -->
    <summary><strong>1️⃣ Understanding Concurrent Programming in iOS</strong></summary>
    <!-- Contents -->
    <section>
      <ul>
        <!-- What is Concurrency? -->
        <li>
          <h3>What is Concurrency?</h3>
          <p><strong>Concurrency (동시성): 여러 가지 일을 동시에 하려고 하는 것</strong></p>
          <aside class="impl">
            <blockquote>
              <p>💻 Concurrency 구현</p>
              <ul>
                <li>시분할 (Time-slicing)을 통해 구현</li>
                <li>Host OS의 Multi CPU core 사용이 가능한 경우, 병렬처리 방식으로 구현</li>
              </ul>
            </blockquote>
          </aside>
          <figure>
            <img src="https://github.com/user-attachments/assets/abf6f709-84a0-40c9-b3c3-e9ae9facad30" />
            <figcaption>
              <p>Main-Thread는 <strong>'한 번에 하나씩 작업을 처리'</strong>하는 <strong>"Serial Queue"</strong>이므로, <br>
                Downloading Images와 같이 무거운 작업이 진행될 때, 해당 스레드를 점유하고 있어 다른 UI Event 진행이 불가능</p>
            </figcaption>
          </figure>
          <figure>
            <img src="https://github.com/user-attachments/assets/d8c48e6b-6740-4319-be8e-c4a1be600a2c" />
            <figcaption>
              <p>Image나 기타 자료를 다운로드하는 무거운 작업들은 Background-Thread에서 수행!</p>
            </figcaption>
          </figure>
          <br>
          <aside class="tip">
            <blockquote>
              <p><strong>⭐ Main Queue는 UI Event나 매우 빠르게 발생할 수 있는 event를 위해 사용!</strong></p>
              <p>&emsp;사용자 인터페이스는 매끄럽고 부드럽게 작동해야 하며, 어떠한 작업을 수행하더라도 끊김이 있어서는 안됨</p>
            </blockquote>
          </aside>
          <br>
        </li>
        <!-- Grand Central Dispatch -->
        <li>
          <h3>Grand Central Dispatch</h3>
          <p><strong>GCD: Multi-core 및 기타 대칭형 multiprocessing system을 사용하는 system에 대한 App 지원을 최적화하기 위한 기술</strong></p>
          <aside class="tip">
            <blockquote>
              <p><strong>🟰 즉, GCD는 OS 레벨의 동시성/멀티스레딩을 위한 라이브러리로, Dispatch Framework를 통해 사용 가능</strong></p>
            </blockquote>
          </aside>
          <ul>
            <li>
              <h4>Dispatch Queue의 특성</h4>
              <figure>
                <img src="https://github.com/user-attachments/assets/09ac1773-37c7-4a58-bc0f-ddf96c731492" />
                <figcaption>
                  <ol type="1">
                    <li><strong>Serial: 하나의 Thread에서 '순차 실행'</strong>하며, 작업의 순서가 중요한 경우 직렬처리를 사용</li>
                    <li><strong>Concurrent: 여러 Thread에서 '동시 실행'</strong>하며, 작업의 중요도 및 성격 등을 고려했을 때, 유사한 여러개의 작업 처리 시 사용</li>
                  </ol>
                </figcaption>
              </figure>
            </li>
            <li>
              <h4>Dispatch Queue의 종류</h4>
              <figure>
                <img src="https://github.com/user-attachments/assets/d60152ec-6c55-4105-aaa2-222cee4621a4" />
                <figcaption>
                  <ol type="1">
                    <li><strong>Main Queue</strong>: GCD가 제공하는 시스템 큐로, <strong>UI 작업 처리에 사용되는 직렬 큐</strong> (e.g. <code>DispatchQueue.main</code>)</li>
                    <li><strong>Global Queue</strong>: GCD가 제공하는 글로벌 동시 큐로, <strong>여러 작업을 동시에 실행할 수 있는 큐</strong> (e.g. <code>DispatchQueue.global(qos:)</code>)</li>
                    <li>Custom Queue: 사용자 정의 직렬/동시 큐 (e.g. <code>DispatchQueue(label:, attributes:)</code>)</li>
                  </ol>
                </figcaption>
              </figure>
              <br>
            </li>
          </ul>
        </li>
      </ul>
    </section>
  </details>
</article>

<!-- 2.Getting Started with Async and Await -->
<article class="lecture2">
  <details>
    <!-- Title -->
    <summary><strong>2️⃣ Getting Started with Async and Await</strong></summary>
    <!-- Contents -->
    <section>
      <ul>
        <!-- Sync & Async -->
        <li>
          <h3>Sync & Async</h3>
          <ul>
            <li>
              <p><strong>Synchronous (동기): 작업을 시키고 작업의 완료를 기다림</strong></p>
              <figure>
                <img src="https://github.com/user-attachments/assets/8d725a51-d9aa-4f55-93cc-cfddcdb4d8cb" />
                <figcaption>
                  <p>즉, 작업이 끝날 때까지 <strong>해당 thread가 점유되어 다른 작업 수행이 불가능!</strong></p>
                  <aside class="tip">
                    <blockquote>
                      <p><strong>⭐ thread가 점유되어 다른 일의 수행이 불가능한 상태를 'Thread-Blocking'이라고 한다</strong></p>
                    </blockquote>
                  </aside>
                </figcaption>
              </figure>
            </li>
            <li>
              <p><strong>Asynchronous (비동기): 작업을 시키고 작업의 완료를 기다리지 않음</strong></p>
              <figure>
                <img src="https://github.com/user-attachments/assets/e11d9834-ac30-4cc5-9757-25aade558918" />
                <figcaption>
                  <p>즉, <strong>해당 thread가 점유되지 않아 다른 작업 수행이 가능!</strong></p>
                  <aside class="tip">
                    <blockquote>
                      <p><strong>이를 'Non Thread-Blocking'이라고 한다</strong></p>
                    </blockquote>
                  </aside>
                </figcaption>
              </figure>
              <br>
            </li>
          </ul>
        </li>
        <!-- Async & Await -->
        <li>
          <h3>Async & Await</h3>
          <p><strong>async, await: 기존의 비동기 처리 코드를 "동기 처리처럼" 보일 수 있도록 지원</strong></p>
          <aside class="tip">
            <blockquote>
              <p>🟣 <code>async</code> & <code>await</code> 의미</p>
              <ul>
                <li><code>async</code>: <strong>함수가 비동기적임을 나타냄</strong></li>
                <li><code>await</code>: <strong>비동기 함수 및 비동기 Context 내에서 다른 비동기 함수를 호출할 때 사용</strong><br></li>
              </ul>
              <br>
              <p>&emsp;&emsp;비동기 context에는 <code>.task()</code>, <code>Task {}</code>, <code>async</code>함수 등이 존재</p>
            </blockquote>
          </aside>
          <ul>
            <li>
              <h4>Async/await 등장 배경</h4>
              <p>기존의 <code>@escaping</code> closures를 이용한 비동기 처리 코드는 Deeply-nested closures (중첩 클로저)가 됨으로써, <br>
                코드가 verbose (장황), complex (복잡), incorrect (부정확) 해졌고, 오류처리에 어려움이 있었음</p>
              <aside class="tip">
                <blockquote>
                  <p>⭐ <code>async</code>/<code>await</code>가 등장함에 따라, <strong>Straight-line code 작성 가능 + 가독성이 크게 향상</strong></p>
                </blockquote>
              </aside>
            </li>
            <li>
              <h4>Async/await 내부 원리 (Thread Control)</h4>
              <figure>
                <img src="https://github.com/user-attachments/assets/3ad9cdfa-6295-4d65-a60c-025228ce653b" />
                <figcaption>
                  <ol type="1">
                    <li>호출: caller가 callee (async)를 호출하면, caller가 실행되던 Thread Control을 callee에게 전달</li>
                    <li>진행: callee는 스레드 제어권을 포기하는 <strong>'suspend가 가능'</strong> (callee가 일시중단이 되면, caller도 일시중단됨)
                      <p></p>
                      <aside class="tip">
                        <blockquote>
                          <p><strong>⭐ <code>await</code></strong>는 async 함수가 <strong>"일시 중단될 수도 있음"</strong>을 나타내며, 이는 <strong>Non Thread-Blocking</strong>이다</p>
                          <p>&emsp;반드시 suspend 된다는 것이 아님! (<code>await</code>를 <strong>'potential suspension point (잠재적인 일시중단 지점)'</strong>이라고 표현함)</p>
                        </blockquote>
                      </aside>
                    </li>
                  <li>suspend: 스레드 제어권은 <strong>System에게 전달되고</strong>, System은 thread를 사용해 <strong>다른 작업을 수행 (우선순위가 높은 작업부터 처리)</strong>
                    <p></p>
                    <aside class="tip">
                      <blockquote>
                          <p><strong>⭐ 함수가 일시중단된 동안 App의 상태가 크게 바뀔 수 있다</strong></p>
                      </blockquote>
                    </aside>
                    </li>
                  <li>resume: suspend된 비동기 함수를 재개 (resume)하는 단계</li>
                  <li>종료: callee가 종료되면, 스레드 제어권을 caller에게 반납
                    <p></p>
                    <aside class="tip">
                      <blockquote>
                        <p>스레드 제어권을 System으로부터 다시 전달받을 떄, 할당된 thread는 이전과는 <strong>'다른 thread가 될 수도 있음'</strong></p>
                      </blockquote>
                    </aside>
                  </li>
                </ol>
              </figcaption>
              </figure>
            </li>
          </ul>
        </li>
      </ul>
    </section>
  </details>
</article>

<!-- 3.Understanding MVVM Design Pattern -->
<article class="lecture3">
  <details>
    <!-- Title -->
    <summary><strong>3️⃣ Understanding MVVM Design Pattern</strong></summary>
    <!-- Contents -->
    <section>
      <ul>
        <!-- What are Design Patterns? -->
        <li>
          <h3>What are Design Patterns?</h3>
          <p><strong>Design Pattern: 특정 시나리오에서 특정 문제를 해결하기 위한 최적의 방법</strong></p>
          <aside class="tip">
            <blockquote>
              <ul>
                <li>Best practice: 문제 해결을 위한 최적의 방법</li>
                <li>Relationships between classes & objects: class와 object 간의 관계</li>
                <li>Speed Up development: 개발 속도 향상</li>
              </ul>
              <br>
              <p>&emsp;Design Pattern은 언어, Framework에 구애받지 않음</p>
            </blockquote>
          </aside>
        </li>
        <!-- What is MVVM & Why MVVM (with. MVC, MVP) -->
        <li>
          <h3>What is MVVM & Why MVVM (with. MVC, MVP)</h3>
          <figure>
            <table>
              <tr>
                <td align="center">
                  <img src="https://github.com/user-attachments/assets/861f05ae-2972-4eb9-9e31-4086e8319a40" />
                  <p>MVC</p>
                </td>
                <td align="center">
                  <img src="https://github.com/user-attachments/assets/388c39ec-8e55-420a-b7fb-0743e1793d69" />
                  <p>MVP</p>
                </td>
                <td align="center">
                  <img src="https://github.com/user-attachments/assets/6d7dadfd-e1e8-4e49-bb41-d8f78344f8d4" />
                  <p>MVVM</p>
                </td>
              </tr>
            </table>
            <figcaption>
              <h4>MVC (Model-View-Controller)</h4>
              <ul>
                <li>Model: 데이터 요소</li>
                <li>View: 화면에 보여지는 요소</li>
                <li>Controller: UI Event I/O, B.L 처리</li>
              </ul>
              <br>
              <h4>MVP (Model-View-Presenter)</h4>
              <ul>
                <li>Model: 데이터 요소</li>
                <li>View: 화면에 보여지는 요소</li>
                <li>Presenter: 화면에 어떤 내용이 보여질지 담당하는 요소</li>
              </ul>
              <br>
              <h4>MVVM (Model-View-ViewModel)</h4>
              <ul>
                <li>Model: 데이터 요소</li>
                <li>View: 화면에 보여지는 요소</li>
                <li>ViewModel: 화면에 보여지는 데이터 요소만 갖는 요소</li>
              </ul>
            </figcaption>
          </figure>
        </li>
      </ul>
    </section>
  </details>
</article>
