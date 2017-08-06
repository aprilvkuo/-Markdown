# C++ 读写 之 fsream

| 数据类型     | 描述                                       |
| -------- | ---------------------------------------- |
| ofstream | 该数据类型表示输出文件流，用于创建文件并向文件写入信息。             |
| ifstream | 该数据类型表示输入文件流，用于从文件读取信息。                  |
| fstream  | 该数据类型通常表示文件流，且同时具有 ofstream 和 ifstream 两种功能，这意味着它可以创建文件，向文件写入信息，从文件读取信息。 |

## open

 open(const char *filename, ios::openmode mode);

| 模式标志       | 描述                                   |
| ---------- | ------------------------------------ |
| ios::app   | 追加模式。所有写入都追加到文件末尾。                   |
| ios::ate   | 文件打开后定位到文件末尾。                        |
| ios::in    | 打开文件用于读取。                            |
| ios::out   | 打开文件用于写入。                            |
| ios::trunc | 如果该文件已经存在，其内容将在打开文件之前被截断，即把文件长度设为 0。 |

## close

## 写入文件 :<<

## 读取文件：>>

## 文件位置指针

```
// 定位到 fileObject 的第 n 个字节（假设是 ios::beg）
fileObject.seekg( n );
 
// 把文件的读指针从 fileObject 当前位置向后移 n 个字节
fileObject.seekg( n, ios::cur );
 
// 把文件的读指针从 fileObject 末尾往回移 n 个字节
fileObject.seekg( n, ios::end );
 
// 定位到 fileObject 的末尾
fileObject.seekg( 0, ios::end );
```