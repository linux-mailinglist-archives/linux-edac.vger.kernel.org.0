Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C6F629E68
	for <lists+linux-edac@lfdr.de>; Tue, 15 Nov 2022 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiKOQEn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Nov 2022 11:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiKOQEk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Nov 2022 11:04:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BBD62F7
        for <linux-edac@vger.kernel.org>; Tue, 15 Nov 2022 08:04:39 -0800 (PST)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBWCX2DDDz6HJW0;
        Wed, 16 Nov 2022 00:02:16 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:04:37 +0100
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.200) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 16:04:36 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 06/11] rasdaemon: ras-mc-ctl: Add printing usage if necessary parameters are not passed for the vendor-error options
Date:   Tue, 15 Nov 2022 16:04:14 +0000
Message-ID: <20221115160419.355-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20221115160419.355-1-shiju.jose@huawei.com>
References: <20221115160419.355-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.156.200]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add printing usage if necessary parameters are not passed
for the vendor-errors options.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 8755b6f..959ea6b 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1544,6 +1544,7 @@ sub vendor_errors_summary
     if ($num_args ne 0) {
         $platform_id = $ARGV[0];
     } else {
+        usage(1);
         return;
     }
 
@@ -1651,6 +1652,7 @@ sub vendor_errors
     if ($num_args ne 0) {
         $platform_id = $ARGV[0];
     } else {
+        usage(1);
         return;
     }
 
-- 
2.25.1

