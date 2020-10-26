Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165FE2994B5
	for <lists+linux-edac@lfdr.de>; Mon, 26 Oct 2020 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783096AbgJZSBp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Oct 2020 14:01:45 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:28910 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1788978AbgJZSBo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 26 Oct 2020 14:01:44 -0400
X-Greylist: delayed 812 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 14:01:43 EDT
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QHl5Qm013332;
        Mon, 26 Oct 2020 17:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=JvIb9FWtq+s57zxPOaKuZRhMPRPDSDUUXho58OHBJ3M=;
 b=UoPnrnWN3eXp/yNl6BNIA9C1Hw7lzGadfNm+qjuwmAoJqqx6pUZWfMrA9IQUstOrJ3lA
 osvEaRJjdp0Nq5nP4aAyd9EpeI/Wb2CMWmmIWbDLeap/CmEzUZifDze0iZtvSD5xevR4
 UrYJYnPTI2Lc/zDcS9bxnudG1BdqjdwpwhgT1UHZ2pWjuugULfJvgOD4sCAiL+bLxfbq
 oTGClHX19Sck8EVJKqTKIx/a7G0Mnnpur+ODbFdw1Mh7xcGJbcu+JzRY6U7Fx92PJT47
 HzbCY+fddbqDclJY8aMRHAy5DSzb/jFt5xUUttoe4+eeETtMG4mlkKryHxRmfOCbpuBw bw== 
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 34ccbeheur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Oct 2020 17:47:07 +0000
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
        by prod-mail-ppoint5.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 09QHVBhV003219;
        Mon, 26 Oct 2020 10:47:06 -0700
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint5.akamai.com with ESMTP id 34cj8accjs-1;
        Mon, 26 Oct 2020 10:47:05 -0700
Received: from [0.0.0.0] (stag-ssh-gw01.bos01.corp.akamai.com [172.27.113.23])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id B4CEE3D806;
        Mon, 26 Oct 2020 17:47:05 +0000 (GMT)
Subject: Re: Constant output in syslog of EDAC message
To:     Borislav Petkov <bp@alien8.de>
Cc:     Raymond Bennett <raymond.bennett@gmail.com>,
        linux-edac@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
References: <CAKpodDyWSY+Wt5Q04o5EyjZZU4PFST8U9UNcjwrJZ6C=Tc744g@mail.gmail.com>
 <20201019205658.GI24325@zn.tnic>
 <e0fda286-d8e3-dabb-6cf5-fcd974e048b5@akamai.com>
 <20201020091940.GA11583@zn.tnic>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <3d0f6dfa-850c-a4e1-c9fa-4b4ca1983650@akamai.com>
Date:   Mon, 26 Oct 2020 13:47:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020091940.GA11583@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_08:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260117
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_08:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260119
X-Agari-Authentication-Results: mx.akamai.com; spf=${SPFResult} (sender IP is 184.51.33.60)
 smtp.mailfrom=jbaron@akamai.com smtp.helo=prod-mail-ppoint5
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 10/20/20 5:19 AM, Borislav Petkov wrote:
> On Mon, Oct 19, 2020 at 05:25:43PM -0400, Jason Baron wrote:
>> Yes, I likely was just following what was in other edac drivers at
>> the time - for example, i3200_check() has a similar debug. I guess
>> it could have a higher level. But if we remove this one, we may
>> want to audit some of the other edac drivers as well.
> 
> Sounds good. So one patch removing them all would make sense. If
> you feel like doing it, be my guest. Otherwise, it'll land on my
> ever-growing todo. :-\
> 
> Thx.
> 

Hi Boris,

I thought a bit about this - and was wondering if it made sense to
hook the edac debug messages up to 'dynamic debug'. The idea is that
different users may want different debug messages enabled, and this
way they can control each message as desired. Jim (added to 'cc)
recently exported 'ddebug_exec_queries()' to make that easier to do:
https://lore.kernel.org/lkml/20200620180643.887546-16-jim.cromie@gmail.com/

So, we would still continue to support edac_debug_level=N but the
user would have additional control. I tried it out (below) and
doesn't look too bad (at least to me).

Thanks,

-Jason

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7a47680d6f07..0c1c97e42a63 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -34,6 +34,7 @@ config EDAC_LEGACY_SYSFS
 config EDAC_DEBUG
 	bool "Debugging"
 	select DEBUG_FS
+	select DYNAMIC_DEBUG_CORE
 	help
 	  This turns on debugging information for the entire EDAC subsystem.
 	  You do so by inserting edac_module with "edac_debug_level=x." Valid
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 3a849168780d..21ad452f1193 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -8,6 +8,10 @@

 obj-$(CONFIG_EDAC)			:= edac_core.o

+ifdef CONFIG_EDAC_DEBUG
+ccflags-y += -DDYNAMIC_DEBUG_MODULE
+endif
+
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o

diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..75dd4357d430 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -48,6 +48,9 @@
 #define edac_printk(level, prefix, fmt, arg...) \
 	printk(level "EDAC " prefix ": " fmt, ##arg)

+#define edac_dbg_printk(level, prefix, fmt, arg...) \
+	pr_debug("EDAC " prefix #level ": " fmt, ##arg)
+
 #define edac_mc_printk(mci, level, fmt, arg...) \
 	printk(level "EDAC MC%d: " fmt, mci->mc_idx, ##arg)

@@ -70,11 +73,9 @@ extern const char * const edac_mem_types[];
 #ifdef CONFIG_EDAC_DEBUG
 extern int edac_debug_level;

-#define edac_dbg(level, fmt, ...)					\
-do {									\
-	if (level <= edac_debug_level)					\
-		edac_printk(KERN_DEBUG, EDAC_DEBUG,			\
-			    "%s: " fmt, __func__, ##__VA_ARGS__);	\
+#define edac_dbg(level, fmt, ...)					    \
+do {									    \
+	edac_dbg_printk(level, EDAC_DEBUG, "%s: " fmt, __func__, ##__VA_ARGS__);\
 } while (0)

 #else				/* !CONFIG_EDAC_DEBUG */
diff --git a/drivers/edac/edac_module.c b/drivers/edac/edac_module.c
index 32a931d0cb71..6109589858c0 100644
--- a/drivers/edac/edac_module.c
+++ b/drivers/edac/edac_module.c
@@ -11,6 +11,7 @@
  *
  */
 #include <linux/edac.h>
+#include <linux/dynamic_debug.h>

 #include "edac_mc.h"
 #include "edac_module.h"
@@ -19,6 +20,29 @@

 #ifdef CONFIG_EDAC_DEBUG

+static int edac_debug_level_initialized;
+/* Values of 0 to 4 will generate output */
+int edac_debug_level = 2;
+EXPORT_SYMBOL_GPL(edac_debug_level);
+
+static void edac_set_dynamic_debug_level(int level)
+{
+	char buf[32];
+	int i;
+
+	edac_debug_level_initialized = 1;
+	for (i = 0; i <= 4; i++) {
+		snprintf(buf, 32, "format '^EDAC DEBUG%d' %cp", i, i <= level ? '+' : '-');
+		dynamic_debug_exec_queries(buf, NULL);
+	}
+}
+
+static void edac_set_debug_level_init(void)
+{
+	if (!edac_debug_level_initialized)
+		edac_set_dynamic_debug_level(edac_debug_level);
+}
+
 static int edac_set_debug_level(const char *buf,
 				const struct kernel_param *kp)
 {
@@ -32,13 +56,11 @@ static int edac_set_debug_level(const char *buf,
 	if (val > 4)
 		return -EINVAL;

+	edac_set_dynamic_debug_level(val);
+
 	return param_set_int(buf, kp);
 }

-/* Values of 0 to 4 will generate output */
-int edac_debug_level = 2;
-EXPORT_SYMBOL_GPL(edac_debug_level);
-
 module_param_call(edac_debug_level, edac_set_debug_level, param_get_int,
 		  &edac_debug_level, 0644);
 MODULE_PARM_DESC(edac_debug_level, "EDAC debug level: [0-4], default: 2");
@@ -130,6 +152,8 @@ static int __init edac_init(void)
 		goto err_wq;
 	}

+	edac_set_debug_level_init();
+
 	return 0;

 err_wq:
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index aa1f91688eb8..7f16428a266a 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -99,6 +99,7 @@ static inline void edac_debugfs_create_x16(const char *name, umode_t mode,
 					   struct dentry *parent, u16 *value)	{ }
 static inline void edac_debugfs_create_x32(const char *name, umode_t mode,
 		       struct dentry *parent, u32 *value)			{ }
+static inline void edac_set_debug_level_init(void)				{ }
 #endif

 /*
