Return-Path: <linux-edac+bounces-592-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12963856273
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 13:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD3FB2BEF9
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F512C7F1;
	Thu, 15 Feb 2024 11:33:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F10A12AAF7;
	Thu, 15 Feb 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996830; cv=none; b=S/YO4PTI5vuiDQ1wlDIUhrjl+MUzMKq2A7y34nsbEKHK/cyZHEwwWhblYOG6h70MKEJf7s9flPVLu+NO+a1ASrwoeCLXoHyBD1VwcRfgOZloES8Yx+E1HPaA840nOylVOBQGLOXNRzbgtFhsx577QMHT4opioE3jEAjtrSCJjq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996830; c=relaxed/simple;
	bh=wf8TnzCNfwQdO1ondE8t5/Utrvl0AFYZzhG7vHjCe+Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQwRN/4q2QcLJ26WVh9D7rI7sUUhoh7PrOtbbMTanfa10bHz5oR+BPOIGTz9aA6GAsKymKAizWfWHciQdnQaNxx8vjD2WZxqMr461X9Vs1vrUSFK3sQ3XnAjCPJG7TC59MfCmWOUozZis4v30TBM2gAfXmcfPxAP7KK1cD38Qr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCXp3TTgz67Lqc;
	Thu, 15 Feb 2024 19:30:18 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 555F9141DD2;
	Thu, 15 Feb 2024 19:33:46 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:33:46 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 3/8] rasdaemon: ras-mc-ctl: Add support for CXL overflow trace events
Date: Thu, 15 Feb 2024 19:32:30 +0800
Message-ID: <20240215113235.1498-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240215113235.1498-1-shiju.jose@huawei.com>
References: <20240215113235.1498-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

Add support for CXL overflow events to the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 7e2a921..b1175dc 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1377,6 +1377,22 @@ sub summary
             print "No CXL AER correctable errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL overflow errors
+        $query = "select memdev, count(*) from cxl_overflow_event$conf{opt}{since} group by memdev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($memdev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$memdev errors: $count\n";
+        }
+        if ($out ne "") {
+            print "CXL overflow events summary:\n$out\n";
+        } else {
+            print "No CXL overflow errors.\n\n";
+        }
+        $query_handle->finish;
     }
 
     # extlog errors
@@ -1485,6 +1501,7 @@ sub errors
     my ($error_count, $affinity, $mpidr, $r_state, $psci_state);
     my ($pfn, $page_type, $action_result);
     my ($memdev, $host, $serial, $error_status, $first_error, $header_log);
+    my ($log_type, $first_ts, $last_ts);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1609,6 +1626,27 @@ sub errors
             print "No CXL AER correctable errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL overflow errors
+        $query = "select id, timestamp, memdev, host, serial, log_type, count, first_ts, last_ts from cxl_overflow_event$conf{opt}{since} order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $log_type, $count, $first_ts, $last_ts));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "memdev=$memdev, "  if (defined $memdev && length $memdev);
+            $out .= "host=$host, " if (defined $host && length $host);
+            $out .= sprintf "serial=0x%llx, ", $serial if (defined $serial && length $serial);
+            $out .= "log=$log_type, " if (defined $log_type && length $log_type);
+            $out .= sprintf "%u records from $first_ts to $last_ts", $count if (defined $count && length $count);
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "CXL overflow events:\n$out\n";
+        } else {
+            print "No CXL overflow errors.\n\n";
+        }
     }
 
     # Extlog errors
-- 
2.34.1


