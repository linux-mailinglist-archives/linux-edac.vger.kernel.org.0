Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC634AEA4
	for <lists+linux-edac@lfdr.de>; Fri, 26 Mar 2021 19:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCZSbl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Mar 2021 14:31:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50492 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhCZSbH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Mar 2021 14:31:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QITLiL018886;
        Fri, 26 Mar 2021 18:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=3fYCke3IE9cN0HFDDRQ0W/5M8V/wPVDphEc8wkk4Odc=;
 b=r1k6f0sF9pI5JgRI2b8/Ht6EIcb0W6k+GbAu6sG11MV+Nqa+CPbPO5O2a6OSTBLyKVNC
 WqZHzQk638ddLSgtxChR6pCZJoa6W2QRgI/bJPq8AvHdLYCBGiCZbpiezKei4vOE0eHl
 zgVaMp4ixPwjJZjYiyUE8pv8dgX1BfkTHk25yLLR8RznB2ds/pn2OvIw7BnC5QQV24Oh
 i8vwo/2fzdB9j6h/CMsHIrPmS/16e3VNNxhqTOxpRA9mMwehhuP3jGY4Qfg4VmDAPzX4
 WXzAp11ifNduB3Wz2DzxnQWdzjRUH2eOYoYdydsKQpbEC+SVVz/vN4g8foPFpY48Yfbr sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37h13ru0x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 18:30:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12QIQZk1041132;
        Fri, 26 Mar 2021 18:30:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 37h14neymn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Mar 2021 18:30:49 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12QIUmaG026962;
        Fri, 26 Mar 2021 18:30:48 GMT
Received: from ca-virt2-1.us.oracle.com (/10.211.11.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Mar 2021 11:30:48 -0700
From:   =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org, william.roche@oracle.com
Subject: [PATCH v1] RAS/CEC: Memory Corrected Errors consistent event filtering
Date:   Fri, 26 Mar 2021 14:30:29 -0400
Message-Id: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260137
X-Proofpoint-ORIG-GUID: 1IAQ-U0_Nfej0ThZF2Z6nLwIj2OXplrv
X-Proofpoint-GUID: 1IAQ-U0_Nfej0ThZF2Z6nLwIj2OXplrv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9935 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1011 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260137
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
    Some machines are reporting Corrected Errors events without any
    information about a PFN Soft-offlining or Invalid pfn (report given by
    the EDAC module or the mcelog daemon).
    
    A research showed that it reflected the first occurrence of a CE error
    on the system which should have been filtered by the RAS_CEC component.
    We could also notice that if 2 PFNs are impacted by CE errors, the PFN
    on the non-zero slot gets its CE errors reported every-time instead of
    being filtered out.
    
    This problem has appeared with the introduction of commit
    de0e0624d86ff9fc512dedb297f8978698abf21a where the filtering logic has
    been modified.
    
    Could you please review this small suggested fix ?
    
    Thanks in advance for any feedback you could have.
    William.

 drivers/ras/cec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index ddecf25..fdb9762 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -313,7 +313,7 @@ static int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
 	unsigned int to = 0;
-	int count, ret = 0;
+	int count, ret;
 
 	/*
 	 * We can be called very early on the identify_cpu() path where we are
@@ -372,6 +372,9 @@ static int cec_add_elem(u64 pfn)
 		goto unlock;
 	}
 
+	/* action threshold not reached */
+	ret = 0;
+
 	ca->decay_count++;
 
 	if (ca->decay_count >= CLEAN_ELEMS)
-- 
1.8.3.1

