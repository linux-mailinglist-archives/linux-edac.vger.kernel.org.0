Return-Path: <linux-edac+bounces-2972-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4BCA2C56C
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D6F7A54E9
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1199823ED62;
	Fri,  7 Feb 2025 14:31:00 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C37FD;
	Fri,  7 Feb 2025 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938660; cv=none; b=n33Wt4HT2pdGsmy+LI2kh7mzYoBAhVD1kNb/YRHXOxdm2T/flmcgzgOU2kWpo8FwQJeij8Tt2mWJu9zmZ1jLVWLhZgDo20OEeWzFtNlA7T1R4fSk2T0wczkuaqpIc1HlrFpv/yJ8zbh/vrWhawfDSdW4uMKXrRe8a6BtwgJYuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938660; c=relaxed/simple;
	bh=as13PhiyUIEf/lOSCYYyquZEtq8oZGe2bE1AjMZ0as8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=thk0T6lZsoTaLzKFD1/BauKI35Bc5uaf9vGHIlQjnwZRM8Jnmyo+L6y29gRxxZk8G8MytRtFuFP63LHfsoBjsba+JVXPYpkftt7WaEjA0ueNX64oyy5n9EyRapkkW7HEYNtgTq1MzJbSQlliCtSiSmr9N6k8sWOFFIEuAfh8Jnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGZm6h15z6HJcd;
	Fri,  7 Feb 2025 22:29:52 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 2EE271400D8;
	Fri,  7 Feb 2025 22:30:54 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:30:53 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<bp@alien8.de>, <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 0/4] rasdaemon: cxl: Add support for memory repair operations
Date: Fri, 7 Feb 2025 14:30:21 +0000
Message-ID: <20250207143028.1865-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL devices provide error records for both corrected and uncorrectable
memory errors. These errors may reflect one off corruption event
(no increase in likelihood or repeat) or be related to a hardware problem
(more likely to repeat). There are many factors in predicting which case
we have.  This patch set focuses on one particular case in which the
device is making a judgement on whether a repeated problem is likely and
suggesting to the OS that it take remedial actions.

CXL spec 3.1, Section 8.2.9.2.1, Table 8-43, "Common Event Record Format"
table defines the Event Record Flags: 'Maintenance Needed' flag, which
indicates if the memory device requires maintenance. CXL DRAM and general
media event handlers exports to userspace (via a tracepoint) the attributes
needed for memory sparing or PPR. These are then available for writing back
to the EDAC memory repair sysfs interface, initiating the sparing/PPR
operation in the CXL memory device.

Firstly this series enables rasdaemon to close the loop and perform live
memory sparing and PPR operations.

Rasdaemon supports live memory repair for the CXL DRAM errors reported,
with 'maintenance needed' flag set. However the kernel CXL driver rejects
the request for the live memory repair in the following situations.
1. Memory is online and the repair is disruptive.
2. Memory is online and event record does not match.
In addition, live memory repair is not requested if the auto repair option
is switched off for the rasdaemon.

In the above unrepaired cases, repair-needed information for CXL DRAM
events must be stored in the CXL DRAM event record of the SQLite database.
This allows a boot-up script to read repair status and repair attributes
in the next boot. If the memory has not been repaired, the script will
issue the memory repair operation requested by the memory device in the
previous boot. The kernel CXL driver sends a repair command to the device
if the memory to be repaired is offline.

Add CXL memory repair boot-up script for handling the unrepaired
CXL DRAM errors from the previous boot.

Notes:
1. The series implemented userspace code for CXL memory repairs using the
   proposed EDAC memory repair interface. [1]
   
2. The code is based on v2 of rasdaemon: cxl: Update CXL event logging and
   recording to CXL spec rev 3.1. [2]

1. https://lore.kernel.org/linux-cxl/20250106121017.1620-1-shiju.jose@huawei.com/T/#maf191b2a104591f993da00249e67bd483ab67ce0
2. https://lore.kernel.org/lkml/20250110122641.1668-1-shiju.jose@huawei.com/

Shiju Jose (4):
  rasdaemon: cxl: Add support for memory sparing operation
  rasdaemon: cxl: Add support for memory soft PPR operation
  rasdaemon: cxl: Add storing memory repair needed info in the DRAM
    event record
  rasdaemon: cxl: Add CXL memory repair boot-up script for unrepaired
    memory errors

 misc/rasdaemon.env     |   4 +
 ras-cxl-handler.c      | 386 +++++++++++++++++++++++++++++++++++++++++
 ras-record.c           |   2 +
 ras-record.h           |   1 +
 util/cxl-mem-repair.sh | 189 ++++++++++++++++++++
 5 files changed, 582 insertions(+)
 create mode 100755 util/cxl-mem-repair.sh

-- 
2.43.0


