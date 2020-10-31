Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB12A1507
	for <lists+linux-edac@lfdr.de>; Sat, 31 Oct 2020 10:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgJaJ62 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 31 Oct 2020 05:58:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7126 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgJaJ62 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 31 Oct 2020 05:58:28 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNZPX6YFyzLrH0;
        Sat, 31 Oct 2020 17:58:24 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 17:58:17 +0800
From:   lvying6 <lvying6@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <fanwentao@huawei.com>
Subject: [PATCH rasdaemon 1/2] ras-page-isolation: fix do_page_offline always considers page offline is successful
Date:   Sat, 31 Oct 2020 17:57:14 +0800
Message-ID: <1604138235-7142-2-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604138235-7142-1-git-send-email-lvying6@huawei.com>
References: <1604138235-7142-1-git-send-email-lvying6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: lvying <lvying6@huawei.com>

do_page_offline always consider page offline is successful even if kernel
soft/hard offline page failed

when I set /etc/sysconfig/rasdaemon PAGE_CE_THRESHOLD="1" i.e when a
page's address occurs Corrected Error, rasdaemon will trigger this page
soft offline. Also I put a livepatch into kernel's
store_soft_offline_page to observe this function's return vlaue.

When I inject a CE into address 0x3f7ec30000
kernel log:
soft_offline: 0x3f7ec30: unknown non LRU page type ffffe0000000000 ()
[store_soft_offline_page]return from soft_offline_page: -5

rasdaemon log:
rasdaemon[73711]: cpu 00:rasdaemon: Corrected Errors at 0x3f7ec30000 exceed threshold
rasdaemon[73711]: rasdaemon: Result of offlining page at 0x3f7ec30000: offlined

At the same time, I use strace to record rasdaemon's system call:
strace -p 73711
openat(AT_FDCWD, "/sys/devices/system/memory/soft_offline_page",
	O_WRONLY|O_CREAT|O_TRUNC, 0666) = 28
fstat(28, {st_mode=S_IFREG|0200, st_size=4096, ...}) = 0
write(28, "0x3f7ec30000", 12)           = -1 EIO (Input/output error)
close(28)                               = 0

So, kernel actually soft offline pfn 0x3f7ec30 failed, store_soft_offline_page
return -EIO. However, rasdaemon always considers the page offline is
successful.
According to strace display, ferror is unaware of the failure of the
write syscall. So I change fopen-fprintf-ferror-fclose process to
open-write-close process which can be aware of the failure of the write
syscall.

Signed-off-by: lvying <lvying6@huawei.com>
---
 ras-page-isolation.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/ras-page-isolation.c b/ras-page-isolation.c
index 50e4406..dc07545 100644
--- a/ras-page-isolation.c
+++ b/ras-page-isolation.c
@@ -17,6 +17,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
 #include "ras-logger.h"
 #include "ras-page-isolation.h"
 
@@ -210,18 +213,22 @@ void ras_page_account_init(void)
 
 static int do_page_offline(unsigned long long addr, enum otype type)
 {
-	FILE *offline_file;
-	int err;
+	int fd, rc;
+	char buf[20];
 
-	offline_file = fopen(kernel_offline[type], "w");
-	if (!offline_file)
+	fd = open(kernel_offline[type], O_WRONLY);
+	if (fd == -1) {
+		log(TERM, LOG_ERR, "[%s]:open file: %s failed\n", __func__, kernel_offline[type]);
 		return -1;
+	}
 
-	fprintf(offline_file, "%#llx", addr);
-	err = ferror(offline_file) ? -1 : 0;
-	fclose(offline_file);
-
-	return err;
+	sprintf(buf, "%#llx", addr);
+	rc = write(fd, buf, strlen(buf));
+	if (rc < 0) {
+		log(TERM, LOG_ERR, "page offline addr(%s) by %s failed, errno:%d\n", buf, kernel_offline[type], errno);
+	}
+	close(fd);
+	return rc;
 }
 
 static void page_offline(struct page_record *pr)
-- 
1.8.3.1

