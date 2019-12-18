Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9A124003
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2019 08:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfLRHEP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Dec 2019 02:04:15 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34230 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfLRHEP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Dec 2019 02:04:15 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBI71A3a029583;
        Tue, 17 Dec 2019 23:04:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=UZcnCwq10j0m/Je2ObzEn/jzRkw3tFD03EzMMVd90kY=;
 b=oNB3FkYU6UFk2BbZIlzIFPRlb7hS0SOAZz3YIeonFMpyMwy+VzoJME8H7yzUtAJIe0p3
 ELYr1mpPucVMM3+4MZNnBZkcqTqlB66XbodqS2Amt/2rhavt1lVa9/HZnK4emnJ2bVWP
 80KClpDX05wvybw/NkIx6V61kjCuxJsLucbocvZotwTl5MjQPWbfr35dT5Z7ZEP/dGWM
 fFKkNEcsctusOvsMOw2T/FsrvabKEc86ggKyFPVA3pCFnDax4ANcDj0K5EGqz+qjnv2X
 uIAQBAPC3Z/Xq+uvQqZd1TZ5z0jIb3PB+q6qGfV7MK2WPi2hDFaLYNfJqc6mX34duCjk RQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wxn0wnjy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Dec 2019 23:04:12 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 17 Dec
 2019 23:04:10 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 17 Dec 2019 23:04:10 -0800
Received: from dc5-eodlnx05.marvell.com (dc5-eodlnx05.marvell.com [10.69.113.147])
        by maili.marvell.com (Postfix) with ESMTP id 4CDA33F703F;
        Tue, 17 Dec 2019 23:04:10 -0800 (PST)
From:   Bhaskar Upadhaya <bupadhaya@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <lenb@kernel.org>,
        <rafael@kernel.org>
CC:     <gkulkarni@marvell.com>, <rrichter@marvell.com>,
        <bhaskar.upadhaya.linux@gmail.com>,
        Bhaskar Upadhaya <bupadhaya@marvell.com>
Subject: [RFC PATCH] apei/ghes: fix ghes_poll_func by registering in non-deferrable mode
Date:   Tue, 17 Dec 2019 23:03:38 -0800
Message-ID: <1576652618-27017-1-git-send-email-bupadhaya@marvell.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_01:2019-12-17,2019-12-18 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently Linux register ghes_poll_func with TIMER_DEFERRABLE flag,
because of which it is serviced when the CPU eventually wakes up with a
subsequent non-deferrable timer and not at the configured polling interval.

For polling mode, the polling interval configured by firmware should not
be exceeded as per ACPI_6_3 spec[refer Table 18-394], So Timer need to
be configured in non-deferrable mode by removing TIMER_DEFERRABLE flag.
With NO_HZ enabled and timer callback being configured in non-deferrable
mode, timer callback will get called exactly after polling interval.

Impact of removing TIMER_DEFFERABLE flag
- With NO_HZ enabled, additional timer ticks and unnecessary wakeups of
 the cpu happens exactly after polling interval.

- If polling interval is too small than polling function will be called
 too frequently which may stall the cpu.

Signed-off-by: Bhaskar Upadhaya <bupadhaya@marvell.com>
---
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 777f6f7122b4..c8f9230f69fb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1181,7 +1181,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	switch (generic->notify.type) {
 	case ACPI_HEST_NOTIFY_POLLED:
-		timer_setup(&ghes->timer, ghes_poll_func, TIMER_DEFERRABLE);
+		timer_setup(&ghes->timer, ghes_poll_func, 0);
 		ghes_add_timer(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_EXTERNAL:
-- 
2.17.1

