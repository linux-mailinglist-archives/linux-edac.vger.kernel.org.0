Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427E03313FE
	for <lists+linux-edac@lfdr.de>; Mon,  8 Mar 2021 18:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCHRBs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 12:01:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2659 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHRBS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Mar 2021 12:01:18 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvPdM4gvxz67wch;
        Tue,  9 Mar 2021 00:56:55 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 18:01:16 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.25.24) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 17:01:16 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH v3 2/7] rasdaemon: ras-mc-ctl: Modify ARM processor error summary log
Date:   Mon, 8 Mar 2021 16:57:27 +0000
Message-ID: <20210308165732.273-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210308165732.273-1-shiju.jose@huawei.com>
References: <20210308165732.273-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.25.24]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add CPU's mpidr information to the ARM processor error
summary log.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 1fbeb63..21e9d29 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1137,7 +1137,7 @@ sub summary
     my ($err_type, $label, $mc, $top, $mid, $low, $count, $msg);
     my ($etype, $severity, $etype_string, $severity_string);
     my ($dev_name, $dev);
-    my ($affinity, $mpidr);
+    my ($mpidr);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1177,13 +1177,13 @@ sub summary
 
     # ARM processor arm_event errors
     if ($has_arm == 1) {
-        $query = "select affinity, mpidr, count(*) from arm_event group by affinity, mpidr";
+        $query = "select mpidr, count(*) from arm_event group by mpidr";
         $query_handle = $dbh->prepare($query);
         $query_handle->execute();
-        $query_handle->bind_columns(\($affinity, $mpidr, $count));
+        $query_handle->bind_columns(\($mpidr, $count));
         $out = "";
         while($query_handle->fetch()) {
-            $out .= "\t$count errors\n";
+            $out .= sprintf "\tCPU(mpidr=0x%x) has %d errors\n", $mpidr, $count;
         }
         if ($out ne "") {
             print "ARM processor events summary:\n$out\n";
-- 
2.17.1

