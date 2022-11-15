Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C80629E65
	for <lists+linux-edac@lfdr.de>; Tue, 15 Nov 2022 17:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKOQEl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Nov 2022 11:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiKOQEj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Nov 2022 11:04:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E551236
        for <linux-edac@vger.kernel.org>; Tue, 15 Nov 2022 08:04:36 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBWCQ4v06z6H75W;
        Wed, 16 Nov 2022 00:02:10 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:04:33 +0100
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.200) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 16:04:33 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 00/11] rasdaemon: Add cpu fault isolation support and improvements to the HiSilicon vendor specific code
Date:   Tue, 15 Nov 2022 16:04:08 +0000
Message-ID: <20221115160419.355-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.156.200]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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
4. Add four new modules supported by HiSilicon common error section

Change History:
v1 -> v2
1. Use standard length PATH_MAX for path name space allocation
   to replace the macro MAX_PATH_LEN in the cpu fault isolation
   implementation.

v2 -> v3
1. Add four new modules supported by HiSilicon common error section.

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

Xiaofei Tan (1):
  rasdaemon: Add four modules supported by HiSilicon common section

 Makefile.am                |   6 +-
 configure.ac               |  11 +
 misc/rasdaemon.env         |  17 ++
 non-standard-hisi_hip08.c  |   6 +-
 non-standard-hisilicon.c   | 134 +++++++++---
 queue.c                    | 119 +++++++++++
 queue.h                    |  39 ++++
 ras-arm-handler.c          | 113 +++++++++++
 ras-arm-handler.h          |  18 ++
 ras-cpu-isolation.c        | 405 +++++++++++++++++++++++++++++++++++++
 ras-cpu-isolation.h        |  69 +++++++
 ras-events.c               |   9 +-
 ras-non-standard-handler.c |  16 +-
 util/ras-mc-ctl.in         | 196 ++++++++++--------
 14 files changed, 1032 insertions(+), 126 deletions(-)
 create mode 100644 queue.c
 create mode 100644 queue.h
 create mode 100644 ras-cpu-isolation.c
 create mode 100644 ras-cpu-isolation.h

-- 
2.25.1

