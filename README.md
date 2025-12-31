# Async-Await-and-Actors---Concurrency-in-Swift
Learn async/await, actors, async-let, task groups, unstructured concurrency, detached tasks and more!

<details>
  <summary>
    <h2>1️⃣ Understanding Concurrent Programming in iOS</h2>
  </summary>
  
  <ul>
    <li>
      <h3>What is Concurrency?</h3>
      <div>
        <p>
          <b>Concurrency (동시성): 여러가지 일을 동시에 하려고 하는 것</b>
        </p>
        <ul>
          <li>Implementation: 시분할 (Timd-slicing)을 통해 구현 or Host OS의 Multi CPU core 사용이 가능한 경우, 병렬처리 방식으로 구현</li>
          <li>
            <div>
              <p>[Example]</p>
              <img width="100%" height="100%" src="https://github.com/user-attachments/assets/abf6f709-84a0-40c9-b3c3-e9ae9facad30" />
              <p>
                Main-Thread는 <b>한 번에 하나씩 작업을 처리</b>하는 <b>"Serial Queue"</b>이므로, <br>
                Downloading Images와 같이 무거운 작업이 진행될 때, 해당 스레드를 점유하고 있기 때문에 다른 UI Event 진행이 불가능
              </p>
              <img width="100%" height="100%" src="https://github.com/user-attachments/assets/d8c48e6b-6740-4319-be8e-c4a1be600a2c" />
              <p>
                Image나 기타 자료를 다운로드하는 무거운 작업들은 Background-Thread에서 수행!
              </p>
              <br>
              <p>
                <b>즉, Main Queue는 UI Event나 매우 빠르게 발생할 수 있는 event를 위해 사용! <br>
                  반드시, 사용자 인터페이스는 매끄럽고 부드럽게 작동해야 하며, 어떠한 작업을 수행하더라도 끊김이 있어서는 안 됨
                </b>
              </p>
            </div>
          </li>
        </ul>
      </div>
    </li>
    <br>
    <li>
      <h3>Grand Central Dispatch</h3>
      <div>
        <p>
          GCD: Multi-core 및 기타 대칭형 멀티프로세싱 시스템을 사용하는 시스템에 대한 애플리케이션 지원을 최적화하기 위한 기술 <br>
          &emsp;&emsp;&emsp;<b>즉, OS 레벨의 동시성/멀티스레딩을 위한 라이브러리로, Dispatch Framework를 통해 사용 가능</b>
        </p>
        <ul>
          <li>
            <div>
              <p>Dispatch Queue의 특성</p>
              <img width="100%" height="100%" src="https://github.com/user-attachments/assets/09ac1773-37c7-4a58-bc0f-ddf96c731492" />
              <ul>
                <li><b>Serial (직렬): 모든 작업들을 "다른 하나의 thread로 보냄"</b> (-> 작업들의 순서가 중요한 경우에는 직렬처리가 필요할 수 있음)</li>
                <li><b>Concurrent (동시): 모든 작업들을 "여러개의 thread로 보냄"</b> (-> 작업의 중요도 및 성격 등을 고려했을 때, 유사한 여러개의 작업 처리 시, 사용)</li>
              </ul>
              <br>
            </div>
          </li>
          <li>
            <div>
              <p>Dispatch Queue의 종류</p>
              <img width="100%" height="100%" src="https://github.com/user-attachments/assets/d60152ec-6c55-4105-aaa2-222cee4621a4" />
              <ul>
                <li>Main Queue: GCD가 제공하는 시스템 큐로, UI 작업 처리에 사용되는 직렬 큐 (e.g. <code>DispatchQueue.main</code>)</li>
                <li>Global Queue: GCD가 제공하는 글로벌 동시 큐로, 여러 작업을 동시에 실행할 수 있는 큐 (e.g. <code>DispatchQueue.global(qos:)</code>)</li>
                <li>Custom Queue: 사용자 정의 직렬/동시 큐 (e.g. <code>DispatchQueue(label:, attributes:)</code>)</li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
    </li>
  </ul>
</details>
