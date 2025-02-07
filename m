Return-Path: <linux-edac+bounces-2976-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A0A2C56E
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B5623AABBD
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8FC246359;
	Fri,  7 Feb 2025 14:31:02 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5F23F29F;
	Fri,  7 Feb 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938662; cv=none; b=VuMMbzvVeX6x+qRmzl9SXw+gqVI7V5Jw4cksNIpfoHmNkwtVDPHhVb++iugglTVlfMpJEgFSVm3BveduBpmKbyQZsq0Z7Dd5gD3iMiTNDKIQNnnsXblGmC8fdO9F/YLQoNBA8xheYNVB44Sc6jaIJZYMAT+z+q8Bs//o1DGgbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938662; c=relaxed/simple;
	bh=ZF9f7jGUfMLnxque3loxIfAs4Ce34nahszkMvVP6Nlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBFcBH7LWYIt6HPvmnRIId288c/7UhLYj+ojgOpfaSynqBdgIiLAQgXUtkZWTIaze6S2LLR4D+j7KOgEd7pAFDOZr/xfiadKwJvScKHF7ZyXePkFfw/HHQ5SyISNo88+YwT8wfJwUltYGL0wjMO1JwTrrzhxO1Ul9V3CVeHOOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGXs5yHfz6L5Bh;
	Fri,  7 Feb 2025 22:28:13 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id C317F1402A5;
	Fri,  7 Feb 2025 22:30:58 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:30:57 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<bp@alien8.de>, <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 4/4] rasdaemon: cxl: Add CXL memory repair boot-up script for unrepaired memory errors
Date: Fri, 7 Feb 2025 14:30:25 +0000
Message-ID: <20250207143028.1865-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250207143028.1865-1-shiju.jose@huawei.com>
References: <20250207143028.1865-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Rasdaemon supports live memory repair for the CXL DRAM errors reported,
with 'maintenance needed' flag set. However the kernel CXL driver rejects
the request for the live memory repair in the following situations.
1. Memory is online and the repair is disruptive.
2. Memory is online and event record does not match.
In addition, live memory repair is not requested if the auto repair option
is switched off for the rasdaemon.

In the above unrepaired cases, rasdaemon stores the repair-needed
information in the DRAM event record of the SQLite database. This allows
a boot-up script to read repair needed flag and repair attributes from
the database. If the memory has not been repaired, the script will
issue the memory repair operation needed by the CXL memory device
in the previous boot. kernel CXL driver sends a repair command to the
device if the memory to be repaired is offline.

Add boot-up script for handling the unrepaired CXL DRAM memory errors
from the previous boot.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 util/cxl-mem-repair.sh | 189 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100755 util/cxl-mem-repair.sh

diff --git a/util/cxl-mem-repair.sh b/util/cxl-mem-repair.sh
new file mode 100755
index 0000000..2e3d261
--- /dev/null
+++ b/util/cxl-mem-repair.sh
@@ -0,0 +1,189 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
+#
+# Boot-up script for CXL memory repair features.
+#
+
+CXL_MAINT_CLASS_SPARING=2
+
+CXL_MAINT_SUBCLASS_CACHELINE_SPARING=0
+CXL_MAINT_SUBCLASS_ROW_SPARING=1
+CXL_MAINT_SUBCLASS_BANK_SPARING=2
+CXL_MAINT_SUBCLASS_RANK_SPARING=3
+
+RASDAEMON_SQL_DB=/usr/local/var/lib/rasdaemon/ras-mc_event.db
+EDAC_CXL_BUS_PATH=/sys/bus/edac/devices/cxl_
+
+id=1
+idx=-1
+found_repair=-1
+repair_type=''
+
+while [ "$id" ]
+do
+	id=$(sqlite3  $RASDAEMON_SQL_DB "select id from cxl_dram_event where id=$id")
+	if [ -z "$id" ]
+	then
+		break;
+	fi
+
+	repair_needed=$(sqlite3 $RASDAEMON_SQL_DB "select repair_needed from cxl_dram_event where id=$id")
+	if [[ -z "$repair_needed" || $repair_needed -eq 0 ]]
+	then
+		id=$((id+1))
+		continue;
+	fi
+
+	maint_op_class=$(sqlite3  $RASDAEMON_SQL_DB "select hdr_maint_op_class from cxl_dram_event where id=$id")
+	if [ $maint_op_class -ne $CXL_MAINT_CLASS_SPARING ]
+	then
+		id=$((id+1))
+		continue;
+	fi
+
+	maint_op_sub_class=$(sqlite3 $RASDAEMON_SQL_DB "select hdr_maint_op_sub_class from cxl_dram_event where id=$id")
+	if [ -z "$maint_op_sub_class" ]
+	then
+		id=$((id+1))
+		continue;
+	fi
+
+	repair_type=''
+	if [ $maint_op_sub_class -eq $CXL_MAINT_SUBCLASS_CACHELINE_SPARING ]
+	then
+		repair_type='cacheline-sparing'
+	fi
+	if [ $maint_op_sub_class -eq $CXL_MAINT_SUBCLASS_ROW_SPARING ]
+	then
+		repair_type='row-sparing'
+	fi
+	if [ $maint_op_sub_class -eq $CXL_MAINT_SUBCLASS_BANK_SPARING ]
+	then
+		repair_type='bank-sparing'
+	fi
+	if [ $maint_op_sub_class -eq $CXL_MAINT_SUBCLASS_RANK_SPARING ]
+	then
+		repair_type='rank-sparing'
+	fi
+
+	memdev=$(sqlite3 $RASDAEMON_SQL_DB "select memdev from cxl_dram_event where id=$id")
+	if [ -z "$memdev" ]
+	then
+		id=$((id+1))
+		continue;
+	fi
+
+	# find the matching sparing type in sysfs
+	idx=0
+	found_repair=0
+	while [ 1 ]
+	do
+		out=$(cat "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/repair_type")
+		if [ -z "$out" ]
+		then
+			break;
+		fi
+
+		if [ "$repair_type" = "$out" ]
+		then
+			found_repair=1
+			break;
+		fi
+		idx=$((idx+1))
+	done
+	if [ $found_repair -eq 0 ]
+	then
+		id=$((id+1))
+		continue;
+	fi
+
+	if [[ $maint_op_sub_class == $CXL_MAINT_SUBCLASS_CACHELINE_SPARING  || $maint_op_sub_class == $CXL_MAINT_SUBCLASS_ROW_SPARING || $maint_op_sub_class == $CXL_MAINT_SUBCLASS_BANK_SPARING ]]
+		then
+		bank_group=$(sqlite3 $RASDAEMON_SQL_DB "select bank_group from cxl_dram_event where id=$id")
+		if [ "$bank_group" ]
+		then
+			echo $bank_group > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/bank_group"
+		else
+			id=$((id+1))
+			continue;
+		fi
+
+		bank=$(sqlite3 $RASDAEMON_SQL_DB "select bank from cxl_dram_event where id=$id")
+		if [ "$bank" ]
+		then
+			echo $bank > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/bank"
+		else
+			id=$((id+1))
+			continue;
+		fi
+
+		if [[ $maint_op_sub_class == $CXL_MAINT_SUBCLASS_CACHELINE_SPARING || $maint_op_sub_class == $CXL_MAINT_SUBCLASS_ROW_SPARING ]]
+		then
+			row=$(sqlite3 $RASDAEMON_SQL_DB "select row from cxl_dram_event where id=$id")
+			if [ "$row" ]
+			then
+				echo $row > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/row"
+			else
+				id=$((id+1))
+				continue;
+			fi
+		fi
+
+		if [ $maint_op_sub_class -eq $CXL_MAINT_SUBCLASS_CACHELINE_SPARING ]
+		then
+			column=$(sqlite3 $RASDAEMON_SQL_DB "select column from cxl_dram_event where id=$id")
+			if [ "$column" ]
+			then
+				echo $column > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/column"
+			else
+				id=$((id+1))
+				continue;
+			fi
+
+			sub_channel=$(sqlite3 $RASDAEMON_SQL_DB "select sub_channel from cxl_dram_event where id=$id")
+			if [ "$sub_channel" ]
+			then
+				echo $sub_channel > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/sub_channel"
+			else
+				id=$((id+1))
+				continue;
+			fi
+		fi
+	fi
+
+	channel=$(sqlite3 $RASDAEMON_SQL_DB "select channel from cxl_dram_event where id=$id")
+	if [ "$channel" ]
+	then
+		echo $channel > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/channel"
+	else
+		id=$((id+1))
+		continue;
+	fi
+
+	rank=$(sqlite3 $RASDAEMON_SQL_DB "select rank from cxl_dram_event where id=$id")
+	if [ "$rank" ]
+	then
+		echo $rank > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/rank"
+	else
+		id=$((id+1))
+		continue;
+	fi
+
+	nibble_mask=$(sqlite3 $RASDAEMON_SQL_DB "select nibble_mask from cxl_dram_event where id=$id")
+	if [ "$nibble_mask" ]
+	then
+		echo $nibble_mask > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/nibble_mask"
+	else
+		id=$((id+1))
+		continue;
+	fi
+
+	echo 1 > "$EDAC_CXL_BUS_PATH""$memdev""/mem_repair"$idx"/repair"
+
+	#Clear repair_needed field of cxl_dram_event table
+	$(sqlite3 $RASDAEMON_SQL_DB "update cxl_dram_event set repair_needed = 0 where id=$id")
+
+	id=$((id+1))
+done
-- 
2.43.0


