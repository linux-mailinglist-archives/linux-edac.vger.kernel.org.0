Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD45C3028DB
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 18:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbhAYRXg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 12:23:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2419 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbhAYRQ5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jan 2021 12:16:57 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPbwG5jfXz67gld;
        Tue, 26 Jan 2021 01:10:22 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 18:16:08 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.115) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 17:16:08 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH v2 0/8] rasdaemon: add support for memory_failure events,
Date:   Mon, 25 Jan 2021 17:14:47 +0000
Message-ID: <20210125171455.1886-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
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

Add support for the memory_failure trace event in the rasdaemon and
add improvements & support for the vendor specific errors in the
util/ras-mc-ctl.in.

Changes:
v1 -> v2
1. Fix the feedback by Mauro for the fix patch for the exception
   in the ras-mc-ctl.in.
2. Rebased and grouped the previous v1 rasdaemon patches posted.

Shiju Jose (8):
  rasdaemon: add support for memory_failure events
  rasdaemon: ras-mc-ctl: Modify ARM processor error summary log
  rasdaemon: ras-mc-ctl: Add memory failure events
  rasdaemon: ras-mc-ctl: Fix for exception when an event is not enabled
  rasdaemon: ras-mc-ctl: Add support for the vendor-specific errors
  rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng920 errors
  rasdaemon: ras-mc-ctl: Add support for HiSilicon Kunpeng9xx common
    errors
  rasdaemon: Modify confiure.ac for Hisilicon Kunpeng errors

 .travis.yml                  |   2 +-
 Makefile.am                  |   7 +-
 configure.ac                 |  20 +-
 ras-events.c                 |  15 +
 ras-events.h                 |   1 +
 ras-memory-failure-handler.c | 179 +++++++++
 ras-memory-failure-handler.h |  25 ++
 ras-record.c                 |  70 ++++
 ras-record.h                 |  13 +
 ras-report.c                 |  68 ++++
 ras-report.h                 |   2 +
 util/ras-mc-ctl.in           | 737 +++++++++++++++++++++++++----------
 12 files changed, 927 insertions(+), 212 deletions(-)
 create mode 100644 ras-memory-failure-handler.c
 create mode 100644 ras-memory-failure-handler.h

-- 
2.17.1

