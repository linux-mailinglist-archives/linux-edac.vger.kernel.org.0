Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF4E3028AB
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 18:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbhAYRSw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 12:18:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2421 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbhAYRSV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jan 2021 12:18:21 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPby16cDcz67glP;
        Tue, 26 Jan 2021 01:11:53 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 18:17:40 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.115) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 17:17:39 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH v2 2/8] rasdaemon: ras-mc-ctl: Modify ARM processor error summary log
Date:   Mon, 25 Jan 2021 17:14:49 +0000
Message-ID: <20210125171455.1886-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210125171455.1886-1-shiju.jose@huawei.com>
References: <20210125171455.1886-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.85.115]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
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
index dd7d56f..d8abdbd 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1123,7 +1123,7 @@ sub summary
     my ($err_type, $label, $mc, $top, $mid, $low, $count, $msg);
     my ($etype, $severity, $etype_string, $severity_string);
     my ($dev_name, $dev);
-    my ($affinity, $mpidr);
+    my ($mpidr);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1160,13 +1160,13 @@ sub summary
     $query_handle->finish;
 
     # ARM processor arm_event errors
-    $query = "select affinity, mpidr, count(*) from arm_event group by affinity, mpidr";
+    $query = "select mpidr, count(*) from arm_event group by mpidr";
     $query_handle = $dbh->prepare($query);
     $query_handle->execute();
-    $query_handle->bind_columns(\($affinity, $mpidr, $count));
+    $query_handle->bind_columns(\($mpidr, $count));
     $out = "";
     while($query_handle->fetch()) {
-        $out .= "\t$count errors\n";
+        $out .= sprintf "\tCPU(mpidr=0x%x) has %d errors\n", $mpidr, $count;
     }
     if ($out ne "") {
         print "ARM processor events summary:\n$out\n";
-- 
2.17.1

