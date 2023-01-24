Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC30679F4A
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jan 2023 17:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjAXQ6F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Jan 2023 11:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjAXQ6C (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 24 Jan 2023 11:58:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B19138658;
        Tue, 24 Jan 2023 08:58:01 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1Y2p060cz67y8F;
        Wed, 25 Jan 2023 00:53:53 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.158.45) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 24 Jan 2023 16:57:57 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mchehab@kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH V2 0/4] rasdaemon: Add support for the CXL error events
Date:   Tue, 24 Jan 2023 16:57:29 +0000
Message-ID: <20230124165733.1452-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.158.45]
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

Log and record the following CXL errors reported through the kernel
trace events. CXL poison errors, CXL AER uncorrectable errors and CXL AER
correctable errors.

Note: The default poll method in the rasdaemon to receive the trace events
didn't work in the QEMU. Thus instead used the pthread way for
testing the CXL error events.
To do so, please make following change in the ras-events.c
<change start ...>
/* rc = read_ras_event_all_cpus(data, cpus); */
rc = -255;
< ...change end >
/* Poll doesn't work on this kernel. Fallback to pthread way */
if (rc == -255) {
...

Shiju Jose (4):
  rasdaemon: Move definition for BIT and BIT_ULL to a common file
  rasdaemon: Add support for the CXL poison events
  rasdaemon: Add support for the CXL AER uncorrectable errors
  rasdaemon: Add support for the CXL AER correctable errors

Changes:
RFC V1 -> V2
1. Rename uuid to region_uuid in the log and SQLite DB.
2. Rebase to the latest rasdaemon code.
3. Modify to match the name changes of interface structures and
   functions in the latest libtraceevent-dev, use in the rasdaemon.   

 Makefile.am                |   7 +-
 configure.ac               |  11 ++
 ras-cxl-handler.c          | 351 +++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h          |  32 ++++
 ras-events.c               |  33 ++++
 ras-events.h               |   3 +
 ras-non-standard-handler.h |   3 -
 ras-record.c               | 203 +++++++++++++++++++++
 ras-record.h               |  49 ++++++
 ras-report.c               | 219 +++++++++++++++++++++++
 ras-report.h               |   6 +
 11 files changed, 913 insertions(+), 4 deletions(-)
 create mode 100644 ras-cxl-handler.c
 create mode 100644 ras-cxl-handler.h

-- 
2.25.1

