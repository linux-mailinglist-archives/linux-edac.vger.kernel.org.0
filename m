Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 163D2561C9
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2019 07:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbfFZFkg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jun 2019 01:40:36 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44309 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfFZFkf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jun 2019 01:40:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so625184pgp.11
        for <linux-edac@vger.kernel.org>; Tue, 25 Jun 2019 22:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Uj33jAIt5GZeZZQprloN6xbUK/Qk/3xj+XwqjOyyMA=;
        b=JJVDLMoVQi5LJgeevxmw5i6yoh2Pqa5Vcnnnlp50HeKhJI9NK/pDy1KYa9ZmmA9oVI
         xQkGBu0ZUsO5yxyysMB9yrOwdaT1pTSrgvJschsboV/j/Xlc8Usj6cDkL0Og7ndW2C+k
         aPSkT970cYFVvxl4xMRfpaIIbv+gzRFij3e4pne9uvR4vuLPV72bVjiGPmc9P6apIJ7r
         cXly+5a4cZzbuAVXEP5NBQNZSmEkGLzVZn5zn6kivy9BS0m2W9CdlKayfvCqWJu9vD2L
         1Rx5l97R8weeZ5tOlth/g56GZyhRXGw/Jb5dHAr1qiCgUEGAohi+45XeuwcybfIZlX9p
         t+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Uj33jAIt5GZeZZQprloN6xbUK/Qk/3xj+XwqjOyyMA=;
        b=OpbIhRg/QPiVCDvoxzOxlwq2agb3aDeEb89kQPNmBuDWUlZerfmeNb0eqgSy125ths
         WbkDSq67FfIcnoBiF+Qphir0l1ygqgXoiPGqhwqMGEBZP/SoOiDrzeZrJof5BllHgZ9d
         BNNmz6dzyLE0FjZSgxxjfd/TRR91ZefC4gWfpTyS6LnelpGpxYKP5bJxcYFLUB+zOkmV
         Yyu33GmE1AMHgg6JssiIrBv9Zpr91FDaaNIu6jbnFGwFJAoCrj6dxZ1HOaD5abUCeSZ4
         RYeskhFBikACanA2vZkzcoIE4Rmae5qT0/ovWuWiZU4jcgOFfuMXZTwA4atU4lNdBEuZ
         qe2g==
X-Gm-Message-State: APjAAAWeC/rGQQikECftPU9HdM3xt0cBEulOGjDK6CZvPGr/v+kLFrY5
        zVfttLnMko0dQer0oIn+wR3jBg==
X-Google-Smtp-Source: APXvYqzd1+YwHq8nK/momI1hqzW7Xpry7ONQA+Y0zfmHPWh5OwmodQk5xJiphq4WBr9zRaw2bcUH4w==
X-Received: by 2002:a17:90a:cb87:: with SMTP id a7mr2503628pju.130.1561527634600;
        Tue, 25 Jun 2019 22:40:34 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id f14sm21204884pfn.53.2019.06.25.22.40.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 22:40:33 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH] EDAC: Fix global-out-of-bounds write when setting edac_mc_poll_msec
Date:   Wed, 26 Jun 2019 14:40:11 +0900
Message-Id: <20190626054011.30044-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit 9da21b1509d8 ("EDAC: Poll timeout cannot be zero, p2") assumes
edac_mc_poll_msec to be unsigned long, but the type of the variable still
remained as int. Setting edac_mc_poll_msec can trigger out-of-bounds
write.

Reproducer:

  # echo 1001 > /sys/module/edac_core/parameters/edac_mc_poll_msec

KASAN report:

  BUG: KASAN: global-out-of-bounds in edac_set_poll_msec+0x140/0x150
  Write of size 8 at addr ffffffffb91b2d00 by task bash/1996

  CPU: 1 PID: 1996 Comm: bash Not tainted 5.2.0-rc6+ #23
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-2.fc30 04/01/2014
  Call Trace:
   dump_stack+0xca/0x13e
   print_address_description.cold+0x5/0x246
   __kasan_report.cold+0x75/0x9a
   ? edac_set_poll_msec+0x140/0x150
   kasan_report+0xe/0x20
   edac_set_poll_msec+0x140/0x150
   ? dimmdev_location_show+0x30/0x30
   ? vfs_lock_file+0xe0/0xe0
   ? _raw_spin_lock+0x87/0xe0
   param_attr_store+0x1b5/0x310
   ? param_array_set+0x4f0/0x4f0
   module_attr_store+0x58/0x80
   ? module_attr_show+0x80/0x80
   sysfs_kf_write+0x13d/0x1a0
   kernfs_fop_write+0x2bc/0x460
   ? sysfs_kf_bin_read+0x270/0x270
   ? kernfs_notify+0x1f0/0x1f0
   __vfs_write+0x81/0x100
   vfs_write+0x1e1/0x560
   ksys_write+0x126/0x250
   ? __ia32_sys_read+0xb0/0xb0
   ? do_syscall_64+0x1f/0x390
   do_syscall_64+0xc1/0x390
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
  RIP: 0033:0x7fa7caa5e970
  Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 04
  RSP: 002b:00007fff6acfdfe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fa7caa5e970
  RDX: 0000000000000005 RSI: 0000000000e95c08 RDI: 0000000000000001
  RBP: 0000000000e95c08 R08: 00007fa7cad1e760 R09: 00007fa7cb36a700
  R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000005
  R13: 0000000000000001 R14: 00007fa7cad1d600 R15: 0000000000000005

  The buggy address belongs to the variable:
   edac_mc_poll_msec+0x0/0x40

  Memory state around the buggy address:
   ffffffffb91b2c00: 00 00 00 00 fa fa fa fa 00 00 00 00 fa fa fa fa
   ffffffffb91b2c80: 00 00 00 00 fa fa fa fa 00 00 00 00 fa fa fa fa
  >ffffffffb91b2d00: 04 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
                     ^
   ffffffffb91b2d80: 04 fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
   ffffffffb91b2e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Fix it by changing the type of edac_mc_poll_msec to unsigned int.
The reason why this patch adopts unsigned int rather than unsigned long
is msecs_to_jiffies() assumes arg to be unsigned int. We can avoid
integer conversion bugs and unsigned int will be large enough for
edac_mc_poll_msec.

Fixes: 9da21b1509d8 ("EDAC: Poll timeout cannot be zero, p2")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
---
 drivers/edac/edac_mc_sysfs.c | 16 ++++++++--------
 drivers/edac/edac_module.h   |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 7c01e1cc030c..4386ea4b9b5a 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -26,7 +26,7 @@
 static int edac_mc_log_ue = 1;
 static int edac_mc_log_ce = 1;
 static int edac_mc_panic_on_ue;
-static int edac_mc_poll_msec = 1000;
+static unsigned int edac_mc_poll_msec = 1000;
 
 /* Getter functions for above */
 int edac_mc_get_log_ue(void)
@@ -45,30 +45,30 @@ int edac_mc_get_panic_on_ue(void)
 }
 
 /* this is temporary */
-int edac_mc_get_poll_msec(void)
+unsigned int edac_mc_get_poll_msec(void)
 {
 	return edac_mc_poll_msec;
 }
 
 static int edac_set_poll_msec(const char *val, const struct kernel_param *kp)
 {
-	unsigned long l;
+	unsigned int i;
 	int ret;
 
 	if (!val)
 		return -EINVAL;
 
-	ret = kstrtoul(val, 0, &l);
+	ret = kstrtouint(val, 0, &i);
 	if (ret)
 		return ret;
 
-	if (l < 1000)
+	if (i < 1000)
 		return -EINVAL;
 
-	*((unsigned long *)kp->arg) = l;
+	*((unsigned int *)kp->arg) = i;
 
 	/* notify edac_mc engine to reset the poll period */
-	edac_mc_reset_delay_period(l);
+	edac_mc_reset_delay_period(i);
 
 	return 0;
 }
@@ -82,7 +82,7 @@ MODULE_PARM_DESC(edac_mc_log_ue,
 module_param(edac_mc_log_ce, int, 0644);
 MODULE_PARM_DESC(edac_mc_log_ce,
 		 "Log correctable error to console: 0=off 1=on");
-module_param_call(edac_mc_poll_msec, edac_set_poll_msec, param_get_int,
+module_param_call(edac_mc_poll_msec, edac_set_poll_msec, param_get_uint,
 		  &edac_mc_poll_msec, 0644);
 MODULE_PARM_DESC(edac_mc_poll_msec, "Polling period in milliseconds");
 
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index bc4b806dc9cc..b2f59ee76c22 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -36,7 +36,7 @@ extern int edac_mc_get_log_ue(void);
 extern int edac_mc_get_log_ce(void);
 extern int edac_mc_get_panic_on_ue(void);
 extern int edac_get_poll_msec(void);
-extern int edac_mc_get_poll_msec(void);
+extern unsigned int edac_mc_get_poll_msec(void);
 
 unsigned edac_dimm_info_location(struct dimm_info *dimm, char *buf,
 				 unsigned len);
-- 
2.21.0

