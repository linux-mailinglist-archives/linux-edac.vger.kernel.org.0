Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812E6D2199
	for <lists+linux-edac@lfdr.de>; Fri, 31 Mar 2023 15:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjCaNod (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 Mar 2023 09:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjCaNod (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 31 Mar 2023 09:44:33 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D159765;
        Fri, 31 Mar 2023 06:44:31 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pp1j01dSZz6J7dD;
        Fri, 31 Mar 2023 21:43:48 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 14:44:28 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH V6 0/4] rasdaemon: Add support for the CXL error events
Date:   Fri, 31 Mar 2023 21:44:00 +0800
Message-ID: <20230331134404.1315-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Log and record the following CXL error records reported through the kernel
trace events. CXL poison errors, CXL AER uncorrectable errors and CXL AER
correctable errors.

Shiju Jose (4):
  rasdaemon: Move definition for BIT and BIT_ULL to a common file
  rasdaemon: Add support for the CXL poison events
  rasdaemon: Add support for the CXL AER uncorrectable errors
  rasdaemon: Add support for the CXL AER correctable errors

Changes:
V5 -> V6
1. Following modification in the CXL poison due to
   changes in the kernel patches for the cxl_poison.
  - length -> dpa_length
  - add field trace_type
  
V4 -> V5
1. Add logging of device serial number for the CXL AER uncorrectable and
    CXL AER correctable errors.
2. Rebased.
3. Updated the patches description.	

V3 -> V4
1. Modification for the changes in the kernel patches
   a) https://lore.kernel.org/lkml/cover.1675983077.git.alison.schofield@intel.com/
   b) https://lore.kernel.org/linux-cxl/63e5ed38d77d9_138fbc2947a@iweiny-mobl.notmuch/T/#t

V2 -> V3
1. Fix for the comments from Dave Jiang.

RFC V1 -> V2
1. Rename uuid to region_uuid in the log and SQLite DB.
2. Rebase to the latest rasdaemon code.
3. Modify to match the name changes of interface structures and
   functions in the latest libtraceevent-dev, use in the rasdaemon. 

 Makefile.am                |   7 +-
 configure.ac               |  11 +
 ras-cxl-handler.c          | 426 +++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h          |  32 +++
 ras-events.c               |  33 +++
 ras-events.h               |   3 +
 ras-non-standard-handler.h |   3 -
 ras-record.c               | 215 +++++++++++++++++++
 ras-record.h               |  55 +++++
 ras-report.c               | 231 ++++++++++++++++++++
 ras-report.h               |   6 +
 11 files changed, 1018 insertions(+), 4 deletions(-)
 create mode 100644 ras-cxl-handler.c
 create mode 100644 ras-cxl-handler.h

-- 
2.25.1

