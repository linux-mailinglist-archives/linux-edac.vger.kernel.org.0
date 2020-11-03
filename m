Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4005A2A4811
	for <lists+linux-edac@lfdr.de>; Tue,  3 Nov 2020 15:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgKCO0L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Nov 2020 09:26:11 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:3029 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729248AbgKCOZX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 3 Nov 2020 09:25:23 -0500
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 196C1C6CBC2714B9E76F;
        Tue,  3 Nov 2020 14:25:22 +0000 (GMT)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.30) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 3 Nov 2020 14:25:21 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH 1/3] rasdaemon: ras-mc-ctl: Modify ARM processor error summary log
Date:   Tue, 3 Nov 2020 14:22:56 +0000
Message-ID: <20201103142258.1253-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201103142258.1253-1-shiju.jose@huawei.com>
References: <20201103142258.1253-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.85.30]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
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

