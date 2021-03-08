Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9D03313F8
	for <lists+linux-edac@lfdr.de>; Mon,  8 Mar 2021 18:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCHRAL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 12:00:11 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2657 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCHQ77 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Mar 2021 11:59:59 -0500
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvPZ10k58z67wgC;
        Tue,  9 Mar 2021 00:54:01 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 17:59:55 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.25.24) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 16:59:54 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH v3 0/7] rasdaemon: Add support for memory_failure events and vendor errors 
Date:   Mon, 8 Mar 2021 16:57:25 +0000
Message-ID: <20210308165732.273-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
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

1. Add support for the memory_failure trace event in the rasdaemon.
2. Add improvements & support for the vendor specific errors into the
util/ras-mc-ctl.in script.

Changes:
v2 -> v3
Re-based and removed fix patch for the ras-mc-ctl exception
as another fix patch merged recently.

v1 -> v2
1. Fix the feedback by Mauro for the fix patch for the exception
   in the ras-mc-ctl.in.
2. Rebased and grouped the previous v1 rasdaemon patches posted.

Shiju Jose (7):
  rasdaemon: add support for memory_failure events
  rasdaemon: ras-mc-ctl: Modify ARM processor error summary log
  rasdaemon: ras-mc-ctl: Add memory failure events
  rasdaemon: ras-mc-ctl: Add support for the vendor-specific errors
  rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng920 errors
  rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng9xx common
    errors
  rasdaemon: Modify confiure.ac for Hisilicon Kunpeng errors

 .travis.yml                  |   2 +-
 Makefile.am                  |   7 +-
 configure.ac                 |  13 +-
 ras-events.c                 |  15 ++
 ras-events.h                 |   1 +
 ras-memory-failure-handler.c | 179 +++++++++++++++++++++
 ras-memory-failure-handler.h |  25 +++
 ras-record.c                 |  70 ++++++++
 ras-record.h                 |  13 ++
 ras-report.c                 |  68 ++++++++
 ras-report.h                 |   2 +
 util/ras-mc-ctl.in           | 303 ++++++++++++++++++++++++++++++++++-
 12 files changed, 688 insertions(+), 10 deletions(-)
 create mode 100644 ras-memory-failure-handler.c
 create mode 100644 ras-memory-failure-handler.h

-- 
2.17.1

