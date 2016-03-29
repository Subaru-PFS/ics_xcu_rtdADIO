#include <linux/module.h>
#include <linux/vermagic.h>
#include <linux/compiler.h>

MODULE_INFO(vermagic, VERMAGIC_STRING);

struct module __this_module
__attribute__((section(".gnu.linkonce.this_module"))) = {
 .name = KBUILD_MODNAME,
 .init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
 .exit = cleanup_module,
#endif
 .arch = MODULE_ARCH_INIT,
};

static const struct modversion_info ____versions[]
__used
__attribute__((section("__versions"))) = {
	{ 0x568fba06, "module_layout" },
	{ 0xa2c56c31, "param_ops_ulong" },
	{ 0xf59f197, "param_array_ops" },
	{ 0x3ec8886f, "param_ops_int" },
	{ 0xf0fdf6cb, "__stack_chk_fail" },
	{ 0x6395be94, "__init_waitqueue_head" },
	{ 0x8c971e0b, "device_create" },
	{ 0x91715312, "sprintf" },
	{ 0x704af77a, "__class_create" },
	{ 0xd641eabf, "cdev_add" },
	{ 0x9c10fd4, "cdev_init" },
	{ 0x29537c9e, "alloc_chrdev_region" },
	{ 0x7485e15e, "unregister_chrdev_region" },
	{ 0xd3f74e31, "class_destroy" },
	{ 0x2b2a7c67, "class_unregister" },
	{ 0x9ee3dc36, "device_destroy" },
	{ 0x68f58ca6, "cdev_del" },
	{ 0xd6b8e852, "request_threaded_irq" },
	{ 0x1fedf0f4, "__request_region" },
	{ 0xf20dabd8, "free_irq" },
	{ 0x7c61340c, "__release_region" },
	{ 0xff7559e4, "ioport_resource" },
	{ 0xcf21d241, "__wake_up" },
	{ 0x77e2f33, "_copy_from_user" },
	{ 0xa70cdb8a, "pv_cpu_ops" },
	{ 0xb5dcab5b, "remove_wait_queue" },
	{ 0x71de9b3f, "_copy_to_user" },
	{ 0xa1c76e0a, "_cond_resched" },
	{ 0x1000e51, "schedule" },
	{ 0x5860aad4, "add_wait_queue" },
	{ 0xffd5a395, "default_wake_function" },
	{ 0x9021c4eb, "current_task" },
	{ 0xfcec0987, "enable_irq" },
	{ 0xd52bf1ce, "_raw_spin_lock" },
	{ 0x3ce4ca6f, "disable_irq" },
	{ 0x27e1a049, "printk" },
};

static const char __module_depends[]
__used
__attribute__((section(".modinfo"))) =
"depends=";

