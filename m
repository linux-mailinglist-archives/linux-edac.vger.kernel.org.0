Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0671F51D986
	for <lists+linux-edac@lfdr.de>; Fri,  6 May 2022 15:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441862AbiEFNpl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 May 2022 09:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441903AbiEFNpb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 May 2022 09:45:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD469292
        for <linux-edac@vger.kernel.org>; Fri,  6 May 2022 06:41:45 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kvs7D1m8Pz67xr5;
        Fri,  6 May 2022 21:37:12 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 15:41:43 +0200
Received: from P_UKIT01-A7bmah.china.huawei.com (10.47.73.106) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 14:41:42 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH 05/10] rasdaemon: ras-mc-ctl: Reformat error info of the HiSilicon Kunpeng920
Date:   Fri, 6 May 2022 14:33:02 +0100
Message-ID: <20220506133307.1799-6-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20220506133307.1799-1-shiju.jose@huawei.com>
References: <20220506133307.1799-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.73.106]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Reformat the code to display the error info of HiSilicon Kunpeng920.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 08eb287..8755b6f 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1671,8 +1671,9 @@ sub vendor_errors
             $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
             $out .= "module_id=$module_id, " if ($module_id);
             $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-            $out .= "err_severity=$err_severity, \n" if ($err_severity);
-            $out .= "Error Registers: $regs\n\n" if ($regs);
+            $out .= "err_severity=$err_severity, " if ($err_severity);
+            $out .= "Error Registers: $regs " if ($regs);
+            $out .= "\n\n";
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng920 OEM type1 error events:\n$out\n";
@@ -1694,8 +1695,9 @@ sub vendor_errors
             $out .= "nimbus_id=$nimbus_id, " if ($nimbus_id);
             $out .= "module_id=$module_id, " if ($module_id);
             $out .= "sub_module_id=$sub_module_id, " if ($sub_module_id);
-            $out .= "err_severity=$err_severity, \n" if ($err_severity);
-            $out .= "Error Registers: $regs\n\n" if ($regs);
+            $out .= "err_severity=$err_severity, " if ($err_severity);
+            $out .= "Error Registers: $regs " if ($regs);
+            $out .= "\n\n";
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng920 OEM type2 error events:\n$out\n";
@@ -1719,8 +1721,9 @@ sub vendor_errors
             $out .= "core_id=$core_id, " if ($core_id);
             $out .= "port_id=$port_id, " if ($port_id);
             $out .= "err_severity=$err_severity, " if ($err_severity);
-            $out .= "err_type=$err_type, \n" if ($err_type);
-            $out .= "Error Registers: $regs\n\n" if ($regs);
+            $out .= "err_type=$err_type, " if ($err_type);
+            $out .= "Error Registers: $regs " if ($regs);
+            $out .= "\n\n";
         }
         if ($out ne "") {
             print "HiSilicon Kunpeng920 PCIe controller error events:\n$out\n";
-- 
2.25.1

