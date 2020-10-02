Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398002812B3
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbgJBM3y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:29:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2946 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgJBM3x (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:29:53 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id BE7E84547CA7565F6D7E;
        Fri,  2 Oct 2020 13:29:51 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:29:51 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 4/7] RAS/CEC: Modify cec_mod_work() for common use
Date:   Fri, 2 Oct 2020 13:22:32 +0100
Message-ID: <20201002122235.1280-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201002122235.1280-1-shiju.jose@huawei.com>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.84.119]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Modify the function cec_mod_work() for the common use
with the other error sources.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/ras/cec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 803e641d8e5c..f869e7a270b8 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -167,12 +167,12 @@ static void do_spring_cleaning(struct ce_array *ca)
 /*
  * @interval in seconds
  */
-static void cec_mod_work(unsigned long interval)
+static void cec_mod_work(struct delayed_work *dwork, unsigned long interval)
 {
 	unsigned long iv;
 
 	iv = interval * HZ;
-	mod_delayed_work(system_wq, &cec_work, round_jiffies(iv));
+	mod_delayed_work(system_wq, dwork, round_jiffies(iv));
 }
 
 static void cec_work_fn(struct work_struct *work)
@@ -181,7 +181,7 @@ static void cec_work_fn(struct work_struct *work)
 	do_spring_cleaning(&ce_arr);
 	mutex_unlock(&ce_mutex);
 
-	cec_mod_work(decay_interval);
+	cec_mod_work(&cec_work, decay_interval);
 }
 
 /*
@@ -420,7 +420,7 @@ static int decay_interval_set(void *data, u64 val)
 	*(u64 *)data   = val;
 	decay_interval = val;
 
-	cec_mod_work(decay_interval);
+	cec_mod_work(&cec_work, decay_interval);
 
 	return 0;
 }
-- 
2.17.1


