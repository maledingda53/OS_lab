#include <stdio.h>
#include <pmm.h>
#include <list.h>
#include <string.h>
#include <default_pmm.h>
#include <buddy.h>

#define LEFT_LEAF(index) ((index) * 2 + 1)
#define RIGHT_LEAF(index) ((index) * 2 + 2)
#define PARENT(index) ( ((index) + 1) / 2 - 1)
// offset=(index+1)*node_size – size。
// 上式中索引的下标均从0开始，size为内存总大小，node_size为内存块对应大小。

#define IS_POWER_OF_2(x) (!((x)&((x)-1)))
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define UINT32_SHR_OR(a,n)      ((a)|((a)>>(n)))//右移n位  

#define UINT32_MASK(a)          (UINT32_SHR_OR(UINT32_SHR_OR(UINT32_SHR_OR(UINT32_SHR_OR(UINT32_SHR_OR(a,1),2),4),8),16)) //大于a的最小2^k
#define UINT32_REMAINDER(a)     ((a)&(UINT32_MASK(a)>>1))
#define UINT32_ROUND_DOWN(a)    (UINT32_REMAINDER(a)?((a)-UINT32_REMAINDER(a)):(a)) //小于a的最大2^k

// 保证分配的内存块大小是2的幂次
static unsigned fixsize(unsigned size) {
  size |= size >> 1;
  size |= size >> 2;
  size |= size >> 4;
  size |= size >> 8;
  size |= size >> 16;
  return size+1;
}

struct buddy2 {
  unsigned size; 
  unsigned longest;  /*该内存块的最大可用空闲块的大小。*/ 
};

struct buddy2 root[40000]; // 存放内存管理的二叉树

free_area_t free_area;

#define free_list (free_area.free_list)
#define nr_free (free_area.nr_free)

/* 记录分配块的信息 */
struct allocRecord
{
  struct Page* base;
  int offset;
  size_t nr; //块大小
};

struct allocRecord rec[40000]; //存放内存块偏移量 offset
int nr_block; //已分配的块数

/* 初始化指向空闲块的双链表*/
static void buddy_init()
{
    list_init(&free_list);
    nr_free=0;
}

/* 初始化 buddy_allocator来管理大小为 size的总内存 */
void buddy2_new( int size ) 
{
  unsigned node_size;
  int i;
  nr_block=0;
  if (size < 1 || !IS_POWER_OF_2(size)) // 输入size不合法
    return;

  root[0].size = size;
  node_size = size * 2;

  for (i = 0; i < 2 * size - 1; ++i) {
    if (IS_POWER_OF_2(i+1))
      node_size /= 2;   //每层节点大小是父节点大小的一半
    root[i].longest = node_size;
  }
  return;
}

/* 初始化内存映射关系 */
static void
buddy_init_memmap(struct Page *base, size_t n)
{
    assert(n>0);     // n为要初始化的内存页数量
    struct Page* p = base;
    for(;p!=base + n;p++)
    {
        assert(PageReserved(p));
        p->flags = 0;
        p->property = 1;
        set_page_ref(p, 0);   
        SetPageProperty(p);
        list_add_before(&free_list,&(p->page_link));     
    }
    nr_free += n;

    //调整分配的页数至 2^k 
    //int allocpages =  UINT32_MASK(n); 
    int allocpages = UINT32_ROUND_DOWN(n); 

    buddy2_new(allocpages);
    return;
}

/* 分配合适大小的内存块 返回内存块偏移量 */ 
int buddy2_alloc(struct buddy2* self, int size) 
{
  unsigned index = 0;//节点的标号
  unsigned node_size;
  unsigned offset = 0;

  if (self==NULL) //无法分配
    return -1;
  if (size <= 0) //分配不合理
    size = 1;
  else if (!IS_POWER_OF_2(size))
    size = fixsize(size);
  if (self[index].longest < size) //可分配内存不足
    return -1;
  //cprintf("size is:%d\n",size);

  for(node_size = self->size; node_size != size; node_size /= 2 ) 
  {
    //cprintf("self[index].longest is: %d\n",self[index].longest);
    //cprintf("node_size is:%d\n",node_size);

    if (self[LEFT_LEAF(index)].longest >= size)
    {
       if(self[RIGHT_LEAF(index)].longest>=size)
        {
           // 若左右 leaf都符合分配大小，则比较出更省的那个
           index=self[LEFT_LEAF(index)].longest <= self[RIGHT_LEAF(index)].longest? LEFT_LEAF(index):RIGHT_LEAF(index);
        }
       else
         index=LEFT_LEAF(index);
    }
    else
      index = RIGHT_LEAF(index);
  }

  self[index].longest = 0; // 标记节点为已使用
  offset = (index + 1) * node_size - self->size;
  //cprintf("index is:%d\n",index);
  //cprintf("offset id:%d\n",offset);

  while (index) {  // 更新父节点 longest属性，确保其表示子节点中最大的longest
    index = PARENT(index);
    self[index].longest = 
      MAX(self[LEFT_LEAF(index)].longest, self[RIGHT_LEAF(index)].longest);
  }
  return offset;
}

/* 分配所需的物理页，返回分配块首地址指针 */
static struct Page* buddy_alloc_pages(size_t n)
{
  assert(n>0);
  if(n>nr_free) return NULL;

  struct Page* page=NULL;
  struct Page* p;
  list_entry_t *le=&free_list,*temp;

  rec[nr_block].offset=buddy2_alloc(root,n); //记录偏移量

  int i;
  // 定位到分配块的首地址指针 page
  for(i=0;i<rec[nr_block].offset+1;i++)
    le=list_next(le);  
  page=le2page(le,page_link);
  
  int allocpages;
  if(!IS_POWER_OF_2(n)) 
     allocpages=fixsize(n);
  else
     allocpages=n;

  // 根据需求n得到块大小
  rec[nr_block].base=page; //记录分配块首页
  rec[nr_block].nr=allocpages; //记录分配的页数
  nr_block++;

  for(i=0;i<allocpages;i++) // 修改每一页的状态
  {
    temp=list_next(le);
    p=le2page(le,page_link);
    ClearPageProperty(p); //清除property标志位 表示已被分配
    le=temp;
  }
  nr_free-=allocpages;//减去已被分配的页数
  page->property=n;
  return page;   
}


/* 释放指定的内存页大小 */
void buddy_free_pages(struct Page* base, size_t n) 
{
  unsigned node_size, index = 0;
  unsigned left_longest, right_longest;
  struct buddy2* self=root;
  
  list_entry_t *le=list_next(&free_list);

  int i=0;
  for(i=0;i<nr_block;i++) //找到块
  {
    if(rec[i].base==base)
     break;
  }

  int offset=rec[i].offset;
  int pos=i; //暂存i
  i=0;
  while(i<offset){
    le=list_next(le);
    i++;
  }

  int allocpages;
  if(!IS_POWER_OF_2(n))
    allocpages=fixsize(n);
  else
    allocpages=n;
  
  assert(self && offset >= 0 && offset < self->size);//是否合法
  node_size = 1;
  index = offset + self->size - 1;
  nr_free+=allocpages;//更新空闲页的数量

  struct Page* p;
  //self[index].longest = allocpages;
  self[index].longest=node_size;
  for(i=0;i<allocpages;i++) //回收已分配的页
  {
     p=le2page(le,page_link);
     p->flags=0;
     p->property=1;
     SetPageProperty(p);
     le=list_next(le);
  }

  while (index)  // 向上合并空闲块 更新父节点longest
  {
    index = PARENT(index);
    node_size *= 2;

    left_longest = self[LEFT_LEAF(index)].longest;
    right_longest = self[RIGHT_LEAF(index)].longest;

    // 若兄弟节点的 longest 属性之和等于父节点的 node_size，则可以合并
    if (left_longest + right_longest == node_size)  
      self[index].longest = node_size;
    else
      self[index].longest = MAX(left_longest, right_longest);
  }

  for(i=pos;i<nr_block-1;i++) //清除reg中相应的分配记录
    rec[i]=rec[i+1];

  nr_block--;//更新分配块数的值
  return;
}


/* 返回全局的空闲物理页数 */
static size_t
buddy_nr_free_pages(void) {
    return nr_free;
}

/* 堆测试样例进行check */
static void
buddy_check(void) {
    
    // Simple Checks
    struct Page  *A, *B;
    A = B  =NULL;
    assert((A = alloc_page()) != NULL);
    assert((B = alloc_page()) != NULL);

    assert( A != B);
    assert(page_ref(A) == 0 && page_ref(B) == 0);
    //free page就是free pages(A,1)
    free_page(A);
    free_page(B);
    
    cprintf("*******************************Check begin***************************\n");

    A=alloc_pages(500);     //alloc_pages返回的是开始分配的那一页的地址
    B=alloc_pages(500);
    cprintf("A %p\n",A);
    cprintf("B %p\n",B);

    free_pages(A,250);     //free_pages没有返回值
    free_pages(B,500);
    free_pages(A+250,250);

    cprintf("********************************Check End****************************\n");
   
}

const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check,
};
