Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93CB3557CB
	for <lists+linux-edac@lfdr.de>; Tue,  6 Apr 2021 17:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhDFP3f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Apr 2021 11:29:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50338 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhDFP3e (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Apr 2021 11:29:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136FNQiV187503;
        Tue, 6 Apr 2021 15:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=KAMM11a306xM2ipfm54BMlxObG8E/8Ijj5e8EsmONzE=;
 b=MpoIHIooyGRktmg4ksXKOl6T6P94O/Z0gVu3MHdHV7OABYhNYh6w02zPnHCeu7IPeO8q
 KtWu6gZNp6shcLwF0nNmUs9PpdE/IgnjzskK4BJLZhpUet/n6zd0ywMXud9DE9QhGagw
 KtaAOqQdgmdKwBBzQga/3HVOkls5QD//4xs/l/hxjL4GR/ZwTLcAuyNQntXJVvir82OQ
 5v5gGE2HWKeKvSgWjl5UzKCs3kFVINNL2ZsJbGLV1R0747uFeJlYilL3cxssWF7xnJRn
 Avlvp4EmNMQVd+GdRz7RQpGsZTaqZ0c1XJqtySwnQdMbm5M4N+g+49bMsfcBxlc/xN0S 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 37qfuxd91f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:29:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 136FPtPI067450;
        Tue, 6 Apr 2021 15:29:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 37qa3jkdjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Apr 2021 15:29:15 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 136FTAqb030579;
        Tue, 6 Apr 2021 15:29:11 GMT
Received: from ca-virt2-1.us.oracle.com (/10.211.11.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Apr 2021 08:29:10 -0700
From:   =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To:     bp@alien8.de
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, william.roche@oracle.com
Subject: [PATCH v2] RAS/CEC: Memory Corrected Errors consistent event filtering
Date:   Tue,  6 Apr 2021 11:28:59 -0400
Message-Id: <1617722939-29670-1-git-send-email-william.roche@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20210402170736.GJ28499@zn.tnic>
References: <20210402170736.GJ28499@zn.tnic>
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060105
X-Proofpoint-GUID: HFiLMbGVoIYpXqUlQrF-hDuRuKn4oBnD
X-Proofpoint-ORIG-GUID: HFiLMbGVoIYpXqUlQrF-hDuRuKn4oBnD
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9946 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 malwarescore=0
 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060105
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: William Roche <william.roche@oracle.com>

The Corrected Error events collected by the cec_add_elem() have to be
consistently filtered out.
We fix the case where the value of find_elem() to find the slot of a pfn
was mistakenly used as the return value of the function.
Now the MCE notifiers chain relying on MCE_HANDLED_CEC would only report
filtered corrected errors that reached the action threshold.

Signed-off-by: William Roche <william.roche@oracle.com>
---

Notes:
    This is the new patch version using an additional 'err' variable.
    Unit tested it on a VM instance and a "Bare Metal" machine.
    
    No reporting is done by the MCE_HANDLED_CEC aware notifiers until
    the action threshold is reached.

 drivers/ras/cec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index ddecf25..b926c67 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -312,8 +312,8 @@ static bool sanity_check(struct ce_array *ca)
 static int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
+	int count, err, ret = 0;
 	unsigned int to = 0;
-	int count, ret = 0;
 
 	/*
 	 * We can be called very early on the identify_cpu() path where we are
@@ -330,8 +330,8 @@ static int cec_add_elem(u64 pfn)
 	if (ca->n == MAX_ELEMS)
 		WARN_ON(!del_lru_elem_unlocked(ca));
 
-	ret = find_elem(ca, pfn, &to);
-	if (ret < 0) {
+	err = find_elem(ca, pfn, &to);
+	if (err < 0) {
 		/*
 		 * Shift range [to-end] to make room for one more element.
 		 */
-- 
1.8.3.1

