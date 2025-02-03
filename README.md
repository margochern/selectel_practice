# Практическое задание, работа с Terraform и Ansible

Для работы были взяты модули terraform из репозитория с описанием задачи.

Для работы с репозиторием необходимо склонировать его.

Затем создать в той же папке ssh ключи, командой *ssh-keygen -t rsa* и назвать ключи keys и keys.pub.


Сначала необходимо выполнить инициализацию терраформ модулей
![Terraform init](screenshots/terraform_init.png)

Так как все чувствительные переменные скрыты в публичном репозитории, необходимо создать файл .tfvars или вводить переменные 
для авторизации вручную, в моем случае был использован файл terraform.tfvars

Перед применением команды terraform apply необходимо проверить план выполнения.

![Terraform plan1](screenshots/terraform_plan.png)


![Terraform plan2](screenshots/terraform_plan2.png)

После проверки плана можно выполнить команду terraform apply

![Terraform apply](screenshots/terrafrom_apply.png)

Проверим, что машины созданы в веб интерфейсе

![VM](screenshots/check_in_cloud.png)

Теперь к ним можно подключиться по ssh
![ssh](screenshots/ssh_outputs.png)

Запустим ansible
![ansc](screenshots/ansible-cmd.png)

![ans1](screenshots/ansible1.png)

![ans2](screenshots/ansible2.png)

Проверим, что приложение работает
![word](screenshots/app_is_working.png)







