 # ToDoApp_MVVM
[내일배움캠프 iOS트랙] 앱 개발 심화 개인 과제 - 디자인이 정해진 UI 구성하기 및 CoreData를 활용하여 데이터 일관성 구현하기
<br>

## 🧑🏻‍💻 프로젝트 소개
"ToDoApp_MVVM 앱 만들기"<p> 
이 프로젝트는 Swift 언어를 사용하여 Xcode에서 개발한 애플리케이션입니다. <br>
이 앱은 Core Data를 활용하여 만든 ToDo 애플리케이션입니다. 사용자는 데이터를 조회/입력/삭제/수정 할 수 있으며, 다양한 기능과 사용자 경험을 제공합니다.
1. **메인 화면**: 해야할 일과 완료된 일 그리고 프로필 페이지로 이동할 수 있습니다.
2. **카테고리 화면**: 카테고리를 만들고 삭제할 수 있습니다.
3. **ToDo 화면**: 해야할 일을 만들고 완료하거나 삭제할 수 있습니다.
4. **디테일 화면**: 회원 정보를 관리하고 개인 계정정보를 수정하세요.
5. **완료 화면**: 완료된 목록을 확인하고 삭제할 수 있습니다.
6. **프로필 화면**: 프로필 페이지를 보여줍니다.
<br>

## 🗓️ 개발 기간
* 2023-09-11(월) ~ 2023-09-22(금), 11일간
<br><br>

## 💁🏻 개발자
- 김준우 - [MOMO](https://github.com/jakkujakku)
<br><br>

## Git Flow
- main : 소프트웨어 제품을 배포하는 용도로 쓰는 브랜치
- develop : 개발용 develop 브랜치

### Git Conventions
---
Commit Message는 아래와 같은 규칙을 따릅니다.

- [FEAT]: 새로운 기능을 추가
- [FIX]: 잔잔바리 수정
- [DESIGN]: UI 디자인 변경
- [STYLE]: 코드 포맷 변경, 세미 콜론 누락, 코드 수정이 없는 경우
- [DOCS]: 문서 수정, 필요한 주석 추가 및 변경
- [RENAME]: 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우
- [REMOVE]: 파일을 삭제하는 작업만 수행한 경우
- [MERGE] : 병합
- [CONFLICT]: 병합 시 충돌 해결
- [COMPLETION]: 작업을 완료하고 마지막 커밋을 작성하는 경우
Pull Requests는 Commit Message와 동일하게 써서 올립니다.

## 📌 주요 기능
#### 카테고리 
- 카테고리를 만들기
- 하나씩 삭제하기
- 전체 삭제하기

#### To Do 화면
- To Do 만들기
- 하나씩 삭제하기
- 전체 삭제하기
- 디테일 화면 이동

#### 디테일 화면
- 선택된 화면의 정보를 보여줍니다.
- 선택된 화면의 정보를 수정할 수 있습니다.

#### 프로필 화면
- Figma 예시대로 화면을 구현했습니다.
<br><br>

## 🧐 앱 실행 이미지
<img src="https://velog.velcdn.com/images/jakkujakku98/post/7efa2d8d-2b68-455d-9e60-21ee180d5187/image.png" width="30%" height="30%">
<img src="https://velog.velcdn.com/images/jakkujakku98/post/54ec5a4c-fed5-4a28-8be2-740b9c646865/image.png" width="30%" height="30%">
<img src="https://velog.velcdn.com/images/jakkujakku98/post/addeac5d-2dc2-4253-99b7-980eff18ccd6/image.png" width="30%" height="30%">
<img src="https://velog.velcdn.com/images/jakkujakku98/post/69e6f122-4aec-4ba8-8aa6-9eb94d41f45f/image.png" width="30%" height="30%">
<img src="https://velog.velcdn.com/images/jakkujakku98/post/607a5c8b-1c04-41ee-ac18-808dd2618902/image.png" width="30%" height="30%">
<img src="https://velog.velcdn.com/images/jakkujakku98/post/74c1e221-e0a2-4dae-86b4-dfeca76a63f4/image.png" width="30%" height="30%">
<img src="https://velog.velcdn.com/images/jakkujakku98/post/cc92950b-71a8-4056-b9a1-5216dced92ad/image.png" width="30%" height="30%">
<br><br>

## 앱 구조 - MVVM
### MODEL
- DataManager : CoreData context 보유
- MockupData : ProfileViewController와 ProfileCell의 이미지 목업 데이터 보유
- DataManager.xcdatamodeld : Core Data 

### VIEW
- MainViewController : 메인 페이지
- CategoryViewController : 카테고리 작성 페이지
- ToDoViewController : 해야할 일 작성 페이지
- DetailViewController : 해야할 일 세부사항 페이지
- CompletionViewController : 재사용할 UIBar 버튼
- ProfileViewController : 프로필 페이지

### ViewModel
- CategoryViewModel : 카테고리뷰에서 입력 받은 내용을 처리 & 데이터를 모델로 전달
- ToDoViewModel : ToDo뷰에서 입력 받은 내용을 처리 & 데이터를 모델로 전달
- CompletionViewModel : ToDo뷰에서 보낸 데이터를 CoreData 모델로 전달 & ToDo뷰와 Completion뷰에서 입력 받은 내용을 처리

## MVC 와 MVVM 비교
- MVC란? : 모델 - 뷰 - 컨트롤러로 이루어져 있는 패턴입니다. 유지보수와 구현이 쉬운 것이 장점이지만, 대규모 애플리케이션에서는 컨트롤러의 의존성 문제가 발생할 수 있는 단점이 있는 패턴입니다.

- MVVM란? : 모델 - 뷰 - 뷰모델로 이루어져 있는 패턴입니다. 뷰와 로직이 분리되어 유지보수가 쉬우며, 뷰와 뷰모델 사이를 자동 업데이트를 하기 때문에 MVC에 비해 코드를 조금 더 간결하게 만들 수 있습니다. 하지만 점점 더 많은 뷰 모델이 생긴다면, 관리 및 유지보수하기 까다롭다는 단점이 있습니다.

## UserDefaults와 CoreData의 차이점
- UserDefaults란? : 간단한 키-값 쌍을 사용하여 작은 양의 데이터를 영구 저장하는 데 사용됩니다.
간단한 설정 및 사용자 기본 설정 저장 같은 작은 데이터에 적합합니다.

- CoreData란? : CoreData를 사용하면 데이터를 데이터베이스에 저장하고 검색, 정렬 및 관리할 수 있으며, 복잡한 데이터 모델을 정의하고 관리하는 데 용이합니다.

- 둘의 차이점 : UserDefaults는 작은 양의 데이터를 저장하는 데 적합하며, 대규모 데이터 또는 구조화된 데이터를 저장하기에는 적합하지 않습니다. CoreData는 대규모 데이터와 복잡한 데이터 구조를 다루는 데 적합합니다.

## 기존의 MVC 코드와 MVVM으로 바꾼 코드 비교
- 기존의 MVC 코드 
- TodoWriteController : 데이터를 저장하는 코드
```swift
@IBAction func tappedSaveButton(_ sender: UIButton) {
        guard let text = textField.text else { return }
        let todoData = ToDoData(title: text, section: selectedSection)

        switch selectedSection {
        case Section.do.rawValue:
            DataManager.doData.insert(todoData, at: 0)
            DataManager.saveToDoUserDefaults()
        case Section.decide.rawValue:
            DataManager.decideData.insert(todoData, at: 0)
            DataManager.saveToDoUserDefaults()
        case Section.delegate.rawValue:
            DataManager.delegateData.insert(todoData, at: 0)
            DataManager.saveToDoUserDefaults()
        case Section.delete.rawValue:
            DataManager.deleteData.insert(todoData, at: 0)
            DataManager.saveToDoUserDefaults()
        default:
            return
        }
        navigationController?.popViewController(animated: true)
    }
```
- MVVM 패턴 코드 
- ToDoViewModel 부분의 데이터 저장하는 코드
```swift
class ToDoViewModel {
    private var todoList = CurrentValueSubject<[Task], Never>([])
    private var selectedItem = CurrentValueSubject<Task?, Never>(nil)
    private var detailItem = CurrentValueSubject<Task?, Never>(nil)

    var todoPublisher: AnyPublisher<[Task], Never> {
        return todoList.eraseToAnyPublisher()
    }

    var selectedPublisher: AnyPublisher<Task?, Never> {
        return selectedItem.eraseToAnyPublisher()
    }

    var detailPublisher: AnyPublisher<Task?, Never> {
        return detailItem.eraseToAnyPublisher()
    }

    var item: Task?

    var todos: [Task] = [] {
        didSet {
            todos.sort(by: { $0.date! > $1.date! })
            todoList.send(todos)
        }
    }

    var selectedCategory: Category? {
        didSet {
            readItem()
        }
    }

    var totalCount: Int {
        return todos.count
    }

    var title: String {
        return item?.title ?? ""
    }

    var date: String {
        return DataManager.dateFormatter(date: item?.date ?? Date())
    }

    var modified: String {
        return DataManager.dateFormatter(date: item?.modifyDate ?? Date())
    }

    func didSelecteItem(at indexPath: Int) {
        print("### \(#function)")
        let item = todos[indexPath]
        selectedItem.send(item)
    }

    func createItem(id: UUID, title: String, date: Date, modifyDate: Date?, isCompleted: Bool) {
        let newTask = Task(context: DataManager.context)
        newTask.id = id
        newTask.title = title
        newTask.date = Date()
        newTask.isCompleted = false
        newTask.parentCategory = selectedCategory
        todos.append(newTask)

        do {
            try DataManager.context.save()
            readItem()
        } catch {
            print("### Insert Error: \(error)")
        }
    }

    func readItem(with request: NSFetchRequest<Task> = Task.fetchRequest(), predicate: NSPredicate? = nil) {
        let categoryPredicate = NSPredicate(format: "parentCategory.title MATCHES %@", selectedCategory?.title ?? "")

        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }

        do {
            todos = try DataManager.context.fetch(request)
            todoList.send(todos)
        } catch {
            // error
            print("패치 에러 : \(error)")
        }
    }

    func updateItem(task: Task?, newTitle: String, modifyDate: Date) {
        task?.title = newTitle
        task?.modifyDate = modifyDate

        do {
            try DataManager.context.save()
            todoList.send(todos)
            selectedItem.send(item)
        } catch {
            print("### Update Error: \(error)")
        }
    }

    func deleteItem(at indexPath: Int) {
        let itemIndexPath = todos[indexPath]
        DataManager.context.delete(itemIndexPath)

        do {
            try DataManager.context.save()
            readItem()
            todoList.send(todos)
        } catch {
            print("### Delete Error: \(error)")
        }
    }

    func deleteItems() {
        for task in todos {
            DataManager.context.delete(task)
        }

        do {
            try DataManager.context.save()
            readItem()
            todoList.send(todos)
        } catch {
            print("### Delete Error: \(error)")
        }
    }
}

```
- MVC 패턴
1. 데이터 로직이 Controller 부분에 노출이 되어 있다.
2. 뷰와 컨트롤러에서 UI 관련 로직이 혼재되어 코드가 복잡해질 수 있습니다.
3. 데이터를 뷰에 수동으로 업데이트해야 합니다.

- MVVM 패턴
1. 비즈니스 로직은 오로지 ViewModel을 통해서 접근할 수 있으므로, 각 구성 요소를 더 독립적으로 유지할 수 있고 비즈니스 로직을 분리할 수 있습니다.
2. 데이터 바인딩을 통해 뷰와 뷰모델 간의 자동 업데이트가 가능합니다.

## ToDo App_MVVM FlowChart
<img src="https://velog.velcdn.com/images/jakkujakku98/post/c3db60f3-8ba5-40dc-8f24-e2aeadf54590/image.png">

## CategoryController 작동 순서
<img src="https://velog.velcdn.com/images/jakkujakku98/post/6462b5fe-212c-4580-a339-43719e738afd/image.png">

## ToDoViewController 작동 순서
<img src="https://velog.velcdn.com/images/jakkujakku98/post/e682e2f5-fbbf-4839-9d9f-619e77f74e64/image.png">

## CompletionViewController 작동 순서
<img src="https://velog.velcdn.com/images/jakkujakku98/post/6f7f0e18-2261-4ef9-aa17-fec21f9fd16d/image.png">
