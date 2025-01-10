Return-Path: <linux-edac+bounces-2860-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1F8A09042
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 13:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84468188C659
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B3120D4ED;
	Fri, 10 Jan 2025 12:27:01 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D420CCE3;
	Fri, 10 Jan 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512021; cv=none; b=VnaB06RfntLoyaEHpav0zwrQ3dmmfKBHp08rTnnGcwQptrv21FsJdfMXQV0aBgaXHvMZ23tT3/hznvwJ5d2u9nNmtBw+Fn/zZbwo7H7BddgUp8q4/8+mgT6sjGrtrFftbz+98fOeRuLf1EXr5vJyl8Rls/5GvxaQZ716EX5yCio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512021; c=relaxed/simple;
	bh=CZJ5qVQUmZxjajS+18bJR2Ms/rDK7xzy17Be/a0ILFk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQ7WKH2HuQGRflxmAI6WNWZmqCnLa3yp9+lVkpPkJuRrhT0fuXYOmjLEnS/8Qc7Yox2RnPLIjWpZZrVZTkKh4p5XVOjvkYwyjiWwIk+QyV/naFo6mHMhRatAOQSVsYmO6HY9jajZB+g9cfXSTuxkyrwL8EWNlFsXXHYBPMFiZwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV18P6Kdfz67Qgw;
	Fri, 10 Jan 2025 20:25:41 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 22F5F140A08;
	Fri, 10 Jan 2025 20:26:56 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.14) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 13:26:55 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 00/14]  rasdaemon: cxl: Update CXL event logging and recording to CXL spec rev 3.1
Date: Fri, 10 Jan 2025 12:26:26 +0000
Message-ID: <20250110122641.1668-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

1. Update CXL event logging and recording for CXL spec rev 3.1 and for the
following and corresponding kernel CXL trace events changes.
https://lore.kernel.org/all/20250110115556.1654-1-shiju.jose@huawei.com/

2. Add following fixes.
 - Fix logging of memory event type field of DRAM trace event.
 - Fix mismatch in 'region' field's name with that in kernel DRAM trace
   event.
 - Fix for parsing error when trace event's format file is
    larger than PAGE_SIZE 

Shiju Jose (14):
  rasdaemon: Fix for parsing error when trace event's format file is
    larger than PAGE_SIZE
  rasdaemon: cxl: Fix logging of memory event type of DRAM trace event
  rasdaemon: cxl: Fix mismatch in region field's name with kernel DRAM
    trace event
  rasdaemon: cxl: Add automatic indexing for storing CXL fields in
    SQLite database
  rasdaemon: cxl: Update common event to CXL spec rev 3.1
  rasdaemon: cxl: Add Component Identifier formatting for CXL spec rev
    3.1
  rasdaemon: cxl: Update CXL general media event to CXL spec rev 3.1
  rasdaemon: cxl: Update CXL DRAM event to CXL spec rev 3.1
  rasdaemon: cxl: Update memory module event to CXL spec rev 3.1
  rasdaemon: ras-mc-ctl: Fix logging of memory event type in CXL DRAM
    error table
  rasdaemon: ras-mc-ctl: Update logging of common event data to align
    with CXL spec rev 3.1
  rasdaemon: ras-mc-ctl: Update logging of CXL general media event data
    to align with CXL spec rev 3.1
  rasdaemon: ras-mc-ctl: Update logging of CXL DRAM event data to align
    with CXL spec rev 3.1
  rasdaemon: ras-mc-ctl: Update logging of CXL memory module data to
    align with CXL spec rev 3.1

Changes
V1 -> V2
1. Fixed follwoing comments from Jonathan on V1,
   - Return negative error code in the patch
     rasdaemon: cxl: Add automatic indexing for storing CXL fields in SQLite database
   - Removed line break in the patch description rasdaemon: cxl: Fix mismatch
     in region field's name with kernel DRAM trace event.
2. Added fix for parsing error when trace event's format file is
    larger than PAGE_SIZE.
3. Rebased to latest code.

 ras-cxl-handler.c  | 262 ++++++++++++++++++++++++++++++++++++++++++---
 ras-events.c       |  21 ++--
 ras-record.c       | 192 ++++++++++++++++++++++-----------
 ras-record.h       |  21 ++++
 ras-report.c       |  30 ++++--
 util/ras-mc-ctl.in | 190 +++++++++++++++++++++++++++-----
 6 files changed, 600 insertions(+), 116 deletions(-)

-- 
2.43.0


