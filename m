Return-Path: <linux-edac+bounces-2565-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EB9D37BF
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E76E1F22A95
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0166219E83C;
	Wed, 20 Nov 2024 10:00:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ACB17BB2E;
	Wed, 20 Nov 2024 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096824; cv=none; b=lFZSapcR52qO8Gugo2bM7aXHR5jiXsRRGeuzO5RmiCwgSYlOR9Iy1gTWvX3RtaMnRzwiTWPcHLWOOqzw+M1TI00tEduuiNwrJgRJ7k/WA2kUpyPB45O1aD57YO1X40yeNcR76BxprL/D7ULp+ZL3vAnavDG3evn0BYHZZwjZIEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096824; c=relaxed/simple;
	bh=gJuYhytfzP1s0tqg6XZMauahlV3fdl16xGguFwiZfn0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gATOP37chyy2/Rh6VqCJZva5T9YQSWlKkinKTL5FR1OqvGe+d6fB55i++h21XKc4zfyeaK/LKPsGB4W6+7oukRuVwdn1vEsST8Cny0lNxwvZmYXZ2F5FkWzkUwUxDs/ync+jYp5EMPl97wnx5TqdaldxHuWIoEz/rh2LCzqTmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcKm0HKzz6L74b;
	Wed, 20 Nov 2024 17:59:56 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 402EA140F41;
	Wed, 20 Nov 2024 18:00:18 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:17 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 00/13] rasdaemon: cxl: Update CXL event logging and recording to CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:59:10 +0000
Message-ID: <20241120095923.1891-1-shiju.jose@huawei.com>
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
https://lore.kernel.org/lkml/20241120093745.1847-1-shiju.jose@huawei.com/

2. Add following fixes.
 - Fix logging of memory event type field of DRAM trace event.
 - Fix mismatch in 'region' field's name with that in kernel DRAM trace
   event.

Shiju Jose (13):
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

 ras-cxl-handler.c  | 262 ++++++++++++++++++++++++++++++++++++++++++---
 ras-record.c       | 181 ++++++++++++++++++++-----------
 ras-record.h       |  21 ++++
 ras-report.c       |  30 ++++--
 util/ras-mc-ctl.in | 194 ++++++++++++++++++++++++++++-----
 5 files changed, 583 insertions(+), 105 deletions(-)

-- 
2.43.0


