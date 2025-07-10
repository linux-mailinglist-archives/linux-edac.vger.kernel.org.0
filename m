Return-Path: <linux-edac+bounces-4341-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA15B00797
	for <lists+linux-edac@lfdr.de>; Thu, 10 Jul 2025 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6006A1C20FF5
	for <lists+linux-edac@lfdr.de>; Thu, 10 Jul 2025 15:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89F2749F6;
	Thu, 10 Jul 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNJ9wnkL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E062271468;
	Thu, 10 Jul 2025 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162418; cv=none; b=d/LUYLIY8qIod+Z7BufAs9/Tg6rgQ/RtjnJCCipqxX30wT9duqyfTMc3KU7d1pKgGiNbycSf2vSWz9cKeZfTPyhxBzEpXdCdYRwJl4hriZAw40vubT0Zinf4FriYz26AdO2vsGHW7/+d1/k1AxjQNgqAZu7sEhqHUZHjUN3sdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162418; c=relaxed/simple;
	bh=oM1+Ehyo1XKAXDXS91myjKMXCy9LpbNbrfG5dwb/SMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux7pCHR7trmLVprSxHo2hV/Lf+KRLMDKVjGHk5Jl5Q8txgAtbNToiDsc9/wONLLG94yokSGVsp7hPfejE2OJW2LuY/Y/uz50/DxQfvuwyhvhtceRIxsjMnK2rW3A8nCYCz2HbB8hD8c8lZL3c0oON5GhRUxxGlcvyAc/iH/7ZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNJ9wnkL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a4312b4849so13717411cf.1;
        Thu, 10 Jul 2025 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752162416; x=1752767216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFRh5M+wR2uMTMJ/MORNLebKOfjVF5STzcGd6MRegLQ=;
        b=NNJ9wnkLoPT9OyT9eYgv7pU4yBozqcnbwEs8wzZAg0W2w6OZ0SbLfteUcCKcsGsslb
         kZc6MG+IoZLQ2SWZlsBXMjE7EoLzLsFSSitKGy+Du1Ei+DA9WMesZLjhLabvi+fvEQzO
         1Z1UjGbXJ38xwsOVgTXQ/cuZquWJRjD950J7GwrJ0+vjEuMKvwQ5biT8yYWbmWBlq/Xh
         L7TuixLCNe0a0suAx88Jb9VCvM/7BhSgjC778ObaXqDuW3NtoibboraLd9CIUropBe+7
         acGkNN4n5yJDuC7Cf44samTpsAUM3V6SUGFVGGuFqzjW7//RpYOxuMY2Fajlbt2oAC3A
         kRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162416; x=1752767216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFRh5M+wR2uMTMJ/MORNLebKOfjVF5STzcGd6MRegLQ=;
        b=fOKcoVcB3IP0wRPXG/SYpFX8jJaBBUA2QUdZyzOKe5i5LUQF5E/jBJf8z2wNEv/sfA
         9F9SdCmgFesnNix9sWViWg8J+KiEEyQEcnRaPYWhz0vEaujR8cS5G847VaXPN2cFaDP5
         ceIkP5xkYWeGetye+ob3oOheDMrGHrlbdy+GOSesFJsZWNK9DOGLETmB2V3gr2TdsT9q
         rDBtp3jnq+2Y+HUR34pC94UxF3JBGWxFl+KsACaI4rnIWP8E72Gqe1b7/pvEgyvYptNc
         r3mS/d2Oglb5XdlJzYHg0sFsgPb7au2u186vVtZyUJtIAquDfrwAqSAy6rrQBUTzH5Ca
         YuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0rZy5GaqX2+X52P5ypLcono4WuncqQJ1dg76hX4BF7e5LtdH5srVXQRVYITAarKJ2EDyMsr5aVw1S@vger.kernel.org, AJvYcCXHc6tLVDpw23GuJtkGJLI1S2fp66hxrr3lsINkq3Ws7u1lMQLgIgEXy8ZruBTqhqoJnWcYqwSxpfptDz3X@vger.kernel.org
X-Gm-Message-State: AOJu0YztJZxSv3/j90WFQxxtJ9kGX/LkD5AFDKIuJkihsK5FBSUtDGm9
	VT5AUt8lzDnT/tHfdPv9UeaBsBwBw9RcI13qa/IXUnkL3j1qjg+2f1zMwNTQTL2R0s48qJfKX1b
	8RCflGhyw4xJKxK8Too7LQKz89SZH+Sh8pIEkBmCEFA==
X-Gm-Gg: ASbGncvSekTjmnVJqXSNBNcInO1I/sYd3aQtun4rau2n34fiSUdXVN7G2UChJNNZHTr
	ZSbYYYHiYYmDt/8v4Hlm+OnZSJ6dVgMxjmWDLLYS7hJxTrDjfxdJpV2WPnyZwPmuciRaKKHTQsW
	HBQUk1VSnfKfSBuE983DYEWcNq8tTlmtvNjjqeszjUrETBQ2wwxpsPTg==
X-Google-Smtp-Source: AGHT+IFzf7Wiy6uC7ifSVXNVJ02wG6d3iH9vAVhb54iIBDZYHdSilUfQGokgjtv7Vpa7hoe/Rf4u42B/9+7pm+cCcqs=
X-Received: by 2002:ac8:5709:0:b0:4a8:5a:9e2f with SMTP id d75a77b69052e-4a9dec28aacmr85662381cf.8.1752162415579;
 Thu, 10 Jul 2025 08:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANZ3JQTpr1xRwc9GED7aXePsZE_KZ6GnpO+wMn2UaMrD4tbMzg@mail.gmail.com>
 <CY8PR11MB71349230AB9CF3347D333AC48948A@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB71349230AB9CF3347D333AC48948A@CY8PR11MB7134.namprd11.prod.outlook.com>
From: Wang Haoran <haoranwangsec@gmail.com>
Date: Thu, 10 Jul 2025 23:46:41 +0800
X-Gm-Features: Ac12FXxzTjNlU8rlUG5TwEgMhAuCRQinxhwqzCZ1nLSH0eao7iaEPJVm5xWxsCc
Message-ID: <CANZ3JQQdNGjzkAY-VUbs22sveHCsvCtgVkUApfTYFG7wGw1gCg@mail.gmail.com>
Subject: Re: We found a bug in skx_common.c for the latest linux
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, I have!
Thank you for your reply.
This issue was discovered through static analysis rather than at
runtime, so unfortunately we do not have a real-world PoC or specific
dmesg log from skx_show_retry_rd_err_log().
To provide additional context, during the execution of
skx_show_retry_rd_err_log(res, skx_msg + len, MSG_SIZE - len,
scrub_err);
if len is greater than the allocated MSG_SIZE, the subsequent call
inside skx_show_retry_rd_err_log such as
n =3D snprintf(msg, len, " retry_rd_err_log[%.8x %.8x %.8x %.8x %.8x]",
log0, log1, log2, log3, log4);
will pass an invalid address (skx_msg + len) that has exceeded the
bounds of the skx_msg buffer. Moreover, the size parameter (len)
becomes negative, which is treated as a very large positive number due
to the use of size_t. This can result in out-of-bounds memory access
and potentially dangerous behavior in the kernel.

we crafted a minimal kernel module to demonstrate this case:
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/string.h>

static int __init snprintf_test_init(void)
{
    char buf[10];
    int i;

    printk(KERN_INFO "snprintf_test: start\n");

    for (i =3D 0; i < 10; i++) {
        buf[i] =3D 'a' + i;
    }

    printk(KERN_INFO "snprintf_test: original buf (before snprintf):\n");
    for (i =3D 0; i < sizeof(buf); i++) {
        printk(KERN_INFO "  buf[%2d] =3D 0x%02x (%c)\n", i, buf[i],
               (buf[i] >=3D 32 && buf[i] <=3D 126) ? buf[i] : '.');
    }

    int len =3D snprintf(buf + 12, -2, "snprintf with -2 size, num: %d", 12=
3);

    printk(KERN_INFO "snprintf_test: snprintf returned %d\n", len);

    printk(KERN_INFO "snprintf_test: buf after snprintf:\n");
    for (i =3D 0; i < sizeof(buf); i++) {
        printk(KERN_INFO "  buf[%2d] =3D 0x%02x (%c)\n", i, buf[i],
               (buf[i] >=3D 32 && buf[i] <=3D 126) ? buf[i] : '.');
    }

    return 0;
}

static void __exit snprintf_test_exit(void)
{
    printk(KERN_INFO "snprintf_test: exit\n");
}

module_init(snprintf_test_init);
module_exit(snprintf_test_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("YourName");
MODULE_DESCRIPTION("snprintf test");
And here is the relevant excerpt from the kernel log (dmesg):
[   61.503462] snprintf_test: loading out-of-tree module taints kernel.
[   61.503472] snprintf_test: module verification failed: signature
and/or required key missing - tainting kernel
[   61.504431] snprintf_test: start
[   61.504433] snprintf_test: original buf (before snprintf):
[   61.504435]   buf[ 0] =3D 0x61 (a)
[   61.504438]   buf[ 1] =3D 0x62 (b)
[   61.504440]   buf[ 2] =3D 0x63 (c)
[   61.504442]   buf[ 3] =3D 0x64 (d)
[   61.504444]   buf[ 4] =3D 0x65 (e)
[   61.504446]   buf[ 5] =3D 0x66 (f)
[   61.504448]   buf[ 6] =3D 0x67 (g)
[   61.504450]   buf[ 7] =3D 0x68 (h)
[   61.504452]   buf[ 8] =3D 0x69 (i)
[   61.504453]   buf[ 9] =3D 0x6a (j)
[   61.504466] ------------[ cut here ]------------
[   61.504468] WARNING: CPU: 0 PID: 4133 at lib/vsprintf.c:2780
vsnprintf+0x5ad/0x5f0
[   61.504475] Modules linked in: snprintf_test(OE+) snd_seq_dummy
snd_hrtimer target_core_user uio target_core_pscsi target_core_file
target_core_iblock iscsi_target_mod target_core_mod bnep qrtr
intel_rapl_msr intel_rapl_common polyval_clmulni polyval_generic
ghash_clmulni_intel sha256_ssse3 sha1_ssse3 aesni_intel crypto_simd
cryptd vmw_balloon snd_ens1371 snd_ac97_codec gameport ac97_bus
snd_pcm btusb btrtl snd_seq_midi snd_seq_midi_event btintel
snd_rawmidi snd_seq btbcm btmtk bluetooth snd_seq_device
vsock_loopback vmw_vsock_virtio_transport_common snd_timer
vmw_vsock_vmci_transport snd vsock binfmt_misc soundcore vmw_vmci
i2c_piix4 i2c_smbus input_leds joydev mac_hid sch_fq_codel vmwgfx
drm_ttm_helper ttm msr parport_pc ppdev lp parport efi_pstore
nfnetlink dmi_sysfs ip_tables x_tables autofs4 hid_generic psmouse
vga16fb serio_raw vgastate mptspi mptscsih ahci mptbase e1000 libahci
scsi_transport_spi pata_acpi usbhid hid floppy
[   61.504595] CPU: 0 UID: 0 PID: 4133 Comm: insmod Tainted: G
  OE       6.15.4-061504-generic #202506271452 PREEMPT(voluntary)
[   61.504599] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[   61.504600] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[   61.504603] RIP: 0010:vsnprintf+0x5ad/0x5f0
[   61.504606] Code: 73 04 41 c6 06 20 49 83 c6 01 4c 39 f0 75 ee 48
8b 74 24 28 49 89 c6 45 31 c9 8b 06 83 f8 2f 0f 87 28 ff ff ff e9 a5
fc ff ff <0f> 0b e9 d5 fb ff ff 48 8b 7c 24 28 48 8b 57 08 48 8d 42 08
48 89
[   61.504608] RSP: 0018:ffffd1ea04d4f7d0 EFLAGS: 00010296
[   61.504611] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffd1ea04d=
4f848
[   61.504613] RDX: ffffffffc0abe0e8 RSI: fffffffffffffffe RDI: ffffd1ea04d=
4f8bc
[   61.504614] RBP: ffffd1ea04d4f838 R08: 0000000000000000 R09: 00000000000=
00000
[   61.504616] R10: 0000000000000000 R11: 0000000000000000 R12: ffffd1ea04d=
4f8b0
[   61.504617] R13: 0000000000000009 R14: 0000000000000009 R15: 00000000000=
0006a
[   61.504619] FS:  00007140a8251680(0000) GS:ffff8ccf6b49a000(0000)
knlGS:0000000000000000
[   61.504621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.504623] CR2: 000072de22c27330 CR3: 0000000011235000 CR4: 00000000007=
50ef0
[   61.504639] PKRU: 55555554
[   61.504641] Call Trace:
[   61.504643]  <TASK>
[   61.504648]  snprintf+0x4e/0x80
[   61.504652]  snprintf_test_init+0xfb/0xff0 [snprintf_test]
[   61.504656]  ? __pfx_snprintf_test_init+0x10/0x10 [snprintf_test]
[   61.504659]  do_one_initcall+0x5d/0x330
[   61.504697]  do_init_module+0x97/0x280
[   61.504701]  load_module+0x74b/0x840
[   61.504705]  init_module_from_file+0x95/0x100
[   61.504710]  idempotent_init_module+0x110/0x300
[   61.504715]  __x64_sys_finit_module+0x6b/0xd0
[   61.504718]  x64_sys_call+0x18cd/0x2320
[   61.504722]  do_syscall_64+0x7e/0x10c0
[   61.504724]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504727]  ? ext4_llseek+0xc0/0x120
[   61.504731]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504734]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504736]  ? arch_exit_to_user_mode_prepare.isra.0+0x22/0xd0
[   61.504739]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504741]  ? syscall_exit_to_user_mode+0x38/0x1d0
[   61.504744]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504746]  ? do_syscall_64+0x8a/0x10c0
[   61.504749]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504751]  ? __fsnotify_parent+0x182/0x3e0
[   61.504754]  ? __entry_text_end+0x102579/0x10257d
[   61.504759]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504761]  ? vfs_read+0x178/0x390
[   61.504766]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504769]  ? ksys_read+0x6f/0xf0
[   61.504771]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504774]  ? arch_exit_to_user_mode_prepare.isra.0+0x22/0xd0
[   61.504776]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504778]  ? syscall_exit_to_user_mode+0x38/0x1d0
[   61.504781]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504784]  ? do_syscall_64+0x8a/0x10c0
[   61.504786]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504788]  ? do_syscall_64+0x8a/0x10c0
[   61.504791]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504794]  ? count_memcg_events.constprop.0+0x2a/0x50
[   61.504797]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504799]  ? handle_mm_fault+0x1ca/0x2e0
[   61.504803]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504806]  ? do_user_addr_fault+0x2f8/0x830
[   61.504809]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504811]  ? arch_exit_to_user_mode_prepare.isra.0+0x22/0xd0
[   61.504814]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504816]  ? irqentry_exit_to_user_mode+0x2d/0x1d0
[   61.504819]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504821]  ? irqentry_exit+0x43/0x50
[   61.504824]  ? srso_alias_return_thunk+0x5/0xfbef5
[   61.504826]  ? exc_page_fault+0x96/0x1e0
[   61.504830]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   61.504832] RIP: 0033:0x7140a7931a2d
[   61.504835] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e
fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9b f3 0d 00 f7 d8 64 89
01 48
[   61.504837] RSP: 002b:00007ffd1bbeb7e8 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[   61.504839] RAX: ffffffffffffffda RBX: 00006484bd099790 RCX: 00007140a79=
31a2d
[   61.504841] RDX: 0000000000000000 RSI: 00006484887fd19e RDI: 00000000000=
00003
[   61.504843] RBP: 00007ffd1bbeb890 R08: 0000000000000000 R09: 00007ffd1bb=
eb8d8
[   61.504844] R10: 0000000000000000 R11: 0000000000000246 R12: 00006484887=
fd19e
[   61.504846] R13: 0000000000000000 R14: 00006484bd099750 R15: 00000000000=
00000
[   61.504850]  </TASK>
[   61.504852] ---[ end trace 0000000000000000 ]---
[   61.504854] snprintf_test: snprintf returned 0
[   61.504856] snprintf_test: buf after snprintf:
[   61.504857]   buf[ 0] =3D 0x61 (a)
[   61.504858]   buf[ 1] =3D 0x62 (b)
[   61.504860]   buf[ 2] =3D 0x63 (c)
[   61.504861]   buf[ 3] =3D 0x64 (d)
[   61.504863]   buf[ 4] =3D 0x65 (e)
[   61.504864]   buf[ 5] =3D 0x66 (f)
[   61.504865]   buf[ 6] =3D 0x67 (g)
[   61.504867]   buf[ 7] =3D 0x68 (h)
[   61.504868]   buf[ 8] =3D 0x69 (i)
[   61.504869]   buf[ 9] =3D 0x6a (j)

On Thu, Jul 10, 2025 at 7:39=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> Hi Haoran,
>
> > From: Wang Haoran <haoranwangsec@gmail.com>
> > [...]
> > Subject: We found a bug in skx_common.c for the latest linux
> >
> > Hi, my name is Wang Haoran. We found a bug in the skx_mce_output_error
> > function located in drivers/edac/skx_common.c in the latest Linux kerne=
l
> > (version 6.15.5).
> > The issue arises from the use of snprintf to write into the buffer skx_=
msg,
> > which is allocated with size MSG_SIZE.The function formats multiple str=
ings
> > into skx_msg, including the dynamically generated adxl_msg, which is al=
so
> > allocated with MSG_SIZE. When combined with the format string "%s%s
> > err_code:0x%04x:0x%04x %s", the total output length may exceed MSG_SIZE=
.
> > As a result, the return value of snprintf may be greater than the actua=
l buffer
> > size, which can lead to truncation issues or cause the
> > skx_show_retry_rd_err_log() function to fail unexpectedly.
>
> Do you have a dmesg log for the *issue* you described here?
>
> Thanks
> -Qiuxu

