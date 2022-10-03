Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3BF5F3343
	for <lists+linux-edac@lfdr.de>; Mon,  3 Oct 2022 18:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJCQR7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Oct 2022 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJCQRu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Oct 2022 12:17:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D4356C5
        for <linux-edac@vger.kernel.org>; Mon,  3 Oct 2022 09:17:41 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mh5YY3Whsz67xgN;
        Tue,  4 Oct 2022 00:16:17 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 18:17:38 +0200
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.147) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:17:38 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 00/10] rasdaemon: Add cpu fault isolation support and improvements to the HiSilicon vendor specific code
Date:   Mon, 3 Oct 2022 17:17:32 +0100
Message-ID: <20221003161742.1697-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.152.147]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

1. Support cpu fault isolation for the corrected and recoverable errors.
2. Add features and improvements to the HiSilicon vendor specific code.
3. Bug fix for a memory out-of-bounds issue.

Change History:
v1 -> v2
1. Use standard length PATH_MAX for path name space allocation
   to replace the macro MAX_PATH_LEN in the cpu fault isolation
   implementation.

Shengwei Luo (2):
  rasdaemon: Support cpu fault isolation for corrected errors
  rasdaemon: Support cpu fault isolation for recoverable errors

Shiju Jose (8):
  rasdaemon: Modify recording Hisilicon common error data
  rasdaemon: ras-mc-ctl: Modify error statistics for HiSilicon
    KunPeng9xx common errors
  rasdaemon: ras-mc-ctl: Reformat error info of the HiSilicon Kunpeng920
  rasdaemon: ras-mc-ctl: Add printing usage if necessary parameters are
    not passed for the vendor-error options
  rasdaemon: ras-mc-ctl: Add support to display the HiSilicon vendor
    errors for a specified module
  rasdaemon: ras-mc-ctl: Relocate reading and display Kunpeng920 errors
    to under Kunpeng9xx
  rasdaemon: ras-mc-ctl: Updated HiSilicon platform name
  rasdaemon: Fix for a memory out-of-bounds issue and optimized code to
    remove duplicate function.

 Makefile.am                |   6 +-
 configure.ac               |  11 +
 misc/rasdaemon.env         |  17 ++
 non-standard-hisi_hip08.c  |   6 +-
 non-standard-hisilicon.c   | 128 +++++++++---
 queue.c                    | 119 +++++++++++
 queue.h                    |  39 ++++
 ras-arm-handler.c          | 113 +++++++++++
 ras-arm-handler.h          |  18 ++
 ras-cpu-isolation.c        | 405 +++++++++++++++++++++++++++++++++++++
 ras-cpu-isolation.h        |  69 +++++++
 ras-events.c               |   9 +-
 ras-non-standard-handler.c |  16 +-
 util/ras-mc-ctl.in         | 196 ++++++++++--------
 14 files changed, 1027 insertions(+), 125 deletions(-)
 create mode 100644 queue.c
 create mode 100644 queue.h
 create mode 100644 ras-cpu-isolation.c
 create mode 100644 ras-cpu-isolation.h

-- 
2.25.1

