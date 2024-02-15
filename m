Return-Path: <linux-edac+bounces-593-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC338561C6
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A01F288CC
	for <lists+linux-edac@lfdr.de>; Thu, 15 Feb 2024 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A2F12C7FB;
	Thu, 15 Feb 2024 11:33:50 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14D12C542;
	Thu, 15 Feb 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996830; cv=none; b=htLpywQZ2P2wCJQUn1sTP+waAgnlhiFQ+NQ8piJ4tKPiBHba8gvE3bFCLo8X0wyLx9zw/5RqdgtDflBE6jSqlHXy/WsAZqN+aAdwYZ5PSWZiggAUFiFkgUmmgtzTpzaZ53+kJIOPx7TAhboDE7/gXOJpeyw78JI+puBnXWh4kxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996830; c=relaxed/simple;
	bh=pRbS/fS9qqvajQXy9MM7kbSll/pa2rMaQJYQxThhazE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooy/wmQ4+Ce/MIbvIf8+IDPBxB9IfT5kqIg/RJaUY2p2RH6Pl1cXm/l811NH++sVxnJEe0mNt4DODReMuf7XuXRiwBsirpSsg4EKNLXBW7O9F674y/jK903m/g2QliYxEtSMNzPDS6p0k7I8nAfKp0GvXgqdIBsYb7dlhUWFf2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbCX80BJhz6JB1C;
	Thu, 15 Feb 2024 19:29:44 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C5AE1411CE;
	Thu, 15 Feb 2024 19:33:46 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:33:45 +0000
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 2/8] rasdaemon: ras-mc-ctl: Add support for CXL AER correctable trace events
Date: Thu, 15 Feb 2024 19:32:29 +0800
Message-ID: <20240215113235.1498-4-shiju.jose@huawei.com>
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

Add support for CXL AER correctable events to the ras-mc-ctl tool.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/ras-mc-ctl.in | 79 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/util/ras-mc-ctl.in b/util/ras-mc-ctl.in
index 630edde..7e2a921 100755
--- a/util/ras-mc-ctl.in
+++ b/util/ras-mc-ctl.in
@@ -1241,6 +1241,46 @@ sub get_cxl_ue_error_status_text
     return join (", ", @out);
 }
 
+use constant {
+    CXL_AER_CE_CACHE_DATA_ECC => 0x0001,
+    CXL_AER_CE_MEM_DATA_ECC => 0x0002,
+    CXL_AER_CE_CRC_THRESH => 0x0004,
+    CXL_AER_CE_RETRY_THRESH => 0x0008,
+    CXL_AER_CE_CACHE_POISON => 0x0010,
+    CXL_AER_CE_MEM_POISON => 0x0020,
+    CXL_AER_CE_PHYS_LAYER_ERR => 0x0040,
+};
+
+sub get_cxl_ce_error_status_text
+{
+    my $error_status = $_[0];
+    my @out;
+
+    if ($error_status & CXL_AER_CE_CACHE_DATA_ECC) {
+        push @out, (sprintf "\'Cache Data ECC Error\' ");
+    }
+    if ($error_status & CXL_AER_CE_MEM_DATA_ECC) {
+        push @out, (sprintf "\'Memory Data ECC Error\' ");
+    }
+    if ($error_status & CXL_AER_CE_CRC_THRESH) {
+        push @out, (sprintf "\'CRC Threshold Hit\' ");
+    }
+    if ($error_status & CXL_AER_CE_RETRY_THRESH) {
+        push @out, (sprintf "\'Retry Threshold\' ");
+    }
+    if ($error_status & CXL_AER_CE_CACHE_POISON) {
+        push @out, (sprintf "\'Received Cache Poison From Peer\' ");
+    }
+    if ($error_status & CXL_AER_CE_MEM_POISON) {
+        push @out, (sprintf "\'Received Memory Poison From Peer\' ");
+    }
+    if ($error_status & CXL_AER_CE_PHYS_LAYER_ERR) {
+        push @out, (sprintf "\'Received Error From Physical Layer\' ");
+    }
+
+    return join (", ", @out);
+}
+
 sub summary
 {
     require DBI;
@@ -1321,6 +1361,22 @@ sub summary
             print "No CXL AER uncorrectable errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL AER correctable errors
+        $query = "select memdev, count(*) from cxl_aer_ce_event$conf{opt}{since} group by memdev";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($memdev, $count));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "\t$memdev errors: $count\n";
+        }
+        if ($out ne "") {
+            print "CXL AER correctable events summary:\n$out\n";
+        } else {
+            print "No CXL AER correctable errors.\n\n";
+        }
+        $query_handle->finish;
     }
 
     # extlog errors
@@ -1530,6 +1586,29 @@ sub errors
             print "No CXL AER uncorrectable errors.\n\n";
         }
         $query_handle->finish;
+
+        # CXL AER correctable errors
+        $query = "select id, timestamp, memdev, host, serial, error_status from cxl_aer_ce_event$conf{opt}{since} order by id";
+        $query_handle = $dbh->prepare($query);
+        $query_handle->execute();
+        $query_handle->bind_columns(\($id, $timestamp, $memdev, $host, $serial, $error_status));
+        $out = "";
+        while($query_handle->fetch()) {
+            $out .= "$id $timestamp error: ";
+            $out .= "memdev=$memdev, "  if (defined $memdev && length $memdev);
+            $out .= "host=$host, " if (defined $host && length $host);
+            $out .= sprintf "serial=0x%llx, ", $serial if (defined $serial && length $serial);
+            if (defined $error_status && length $error_status) {
+                $out .= sprintf "error_status: %s, ", get_cxl_ce_error_status_text($error_status);
+            }
+            $out .= "\n";
+        }
+        if ($out ne "") {
+            print "CXL AER correctable events:\n$out\n";
+        } else {
+            print "No CXL AER correctable errors.\n\n";
+        }
+        $query_handle->finish;
     }
 
     # Extlog errors
-- 
2.34.1


