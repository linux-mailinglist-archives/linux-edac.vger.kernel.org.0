Return-Path: <linux-edac+bounces-594-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9873B8561C7
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D181F28985
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087F12C7FE;
	Thu, 15 Feb 2024 11:33:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE712C54E;
	Thu, 15 Feb 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996830; cv=none; b=qYvqhNrhy0KCDxHdQzcf0g8D3jLTWdQKsRzE72x4jpss3u11k1Ef90+IZfCd83StIHHgIIfYvltrnKk+t9Sw6XXPYNw/72plQdEXJ/r/VCRbVnotVtEOdicgjNWrJbMnWrjzi38x6R9IA1rV1+G9vX36TN5ur6FmOEkbfDy+YSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996830; c=relaxed/simple;
	bh=Z4zLins1INTCTDqGGK3jX5LkroiYpIYairS0xeK28CM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ph3VjHvJAGAWRiA93NEviIZCtlIJEJuy5fhFW1QB0fg7GnDo9CVWd6CkB549MkIG/7Y5XtmJWggt5xQp8CCuVh04QXQ2Jw0kZ/qhyi7DKEruIeyHMyiT81Fhrhf5L31fBItty8DGAs5rEjA8Y82F+6tiXIHK8ebHG/BZ8RMQKWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCX83hvJz6JB1b;
	Thu, 15 Feb 2024 19:29:44 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id B57D11400CD;
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
Subject: [RFC PATCH 4/8] rasdaemon: ras-mc-ctl: Add support for CXL poison trace events
Date: Thu, 15 Feb 2024 19:32:31 +0800
Message-ID: <20240215113235.1498-6-shiju.jose@huawei.com>
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

Add support for CXL poison events to the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index b1175dc..d8c1dec 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1393,6 +1393,22 @@ sub summary
             print "No CXL overflow errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL poison errors
+        $query = "select memdev, count(*) from cxl_poison_event$conf{opt}{since} group by memdev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($memdev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$memdev errors: $count\n";
+        }
+        if ($out ne "") {
+            print "CXL poison events summary:\n$out\n";
+        } else {
+            print "No CXL poison errors.\n\n";
+        }
+        $query_handle->finish;
     }
 
     # extlog errors
@@ -1502,6 +1518,7 @@ sub errors
     my ($pfn, $page_type, $action_result);
     my ($memdev, $host, $serial, $error_status, $first_error, $header_log);
     my ($log_type, $first_ts, $last_ts);
+    my ($trace_type, $region, $region_uuid, $hpa, $dpa, $dpa_length, $source, $flags, $overflow_ts);
 
     my $dbh = DBI->connect("dbi:SQLite:dbname=$dbname", "", "", {});
 
@@ -1647,6 +1664,34 @@ sub errors
         } else {
             print "No CXL overflow errors.\n\n";
         }
+
+        # CXL poison errors
+        $query = "select id, timestamp, memdev, host, serial, trace_type, region, region_uuid, hpa, dpa, dpa_length, source, flags, overflow_ts from cxl_poison_event$conf{opt}{since} order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $trace_type, $region, $region_uuid, $hpa, $dpa, $dpa_length, $source, $flags, $overflow_ts));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "memdev=$memdev, "  if (defined $memdev && length $memdev);
+            $out .= "host=$host, " if (defined $host && length $host);
+            $out .= sprintf "serial=0x%llx, ", $serial if (defined $serial && length $serial);
+            $out .= "trace_type=$trace_type, " if (defined $trace_type && length $trace_type);
+            $out .= "region=$region, " if (defined $region && length $region);
+            $out .= "region_uuid=$region_uuid, " if (defined $region_uuid && length $region_uuid);
+            $out .= sprintf "hpa=0x%llx, ", $hpa if (defined $hpa && length $hpa);
+            $out .= sprintf "dpa=0x%llx, ", $dpa if (defined $dpa && length $dpa);
+            $out .= sprintf "dpa_length=0x%x, ", $dpa_length if (defined $dpa_length && length $dpa_length);
+            $out .= "source=$source, " if (defined $source && length $source);
+            $out .= sprintf "flags=%d, ", $flags if (defined $flags && length $flags);
+            $out .= "overflow timestamp=$overflow_ts " if (defined $overflow_ts && length $overflow_ts);
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "CXL poison events:\n$out\n";
+        } else {
+            print "No CXL poison errors.\n\n";
+        }
     }
 
     # Extlog errors
-- 
2.34.1


