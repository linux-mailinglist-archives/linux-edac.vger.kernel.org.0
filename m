Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566EB6F1DC5
	for <lists+linux-edac@lfdr.de>; Fri, 28 Apr 2023 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346460AbjD1R7l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Fri, 28 Apr 2023 13:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346338AbjD1R7k (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Apr 2023 13:59:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA12159EA;
        Fri, 28 Apr 2023 10:59:37 -0700 (PDT)
Received: from lhrpeml100003.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q7L323YN4z67H7Q;
        Sat, 29 Apr 2023 01:59:26 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100003.china.huawei.com (7.191.160.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 28 Apr 2023 18:59:34 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.023;
 Fri, 28 Apr 2023 18:59:34 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH V6 0/4] rasdaemon: Add support for the CXL error events
Thread-Topic: [PATCH V6 0/4] rasdaemon: Add support for the CXL error events
Thread-Index: AQHZY9bqcqHPirFZW06LN1NEM4B8/q9BLchw
Date:   Fri, 28 Apr 2023 17:59:34 +0000
Message-ID: <c49dd10e62ae4e3d8850c119bba70523@huawei.com>
References: <20230331134404.1315-1-shiju.jose@huawei.com>
In-Reply-To: <20230331134404.1315-1-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.32.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi All,

Pull request has submitted for this series.
https://github.com/mchehab/rasdaemon/pull/96

Thanks,
Shiju

-----Original Message-----
From: Shiju Jose <shiju.jose@huawei.com> 
Sent: 31 March 2023 14:44
To: mchehab@kernel.org; linux-cxl@vger.kernel.org; linux-edac@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>; Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH V6 0/4] rasdaemon: Add support for the CXL error events

From: Shiju Jose <shiju.jose@huawei.com>

Log and record the following CXL error records reported through the kernel trace events. CXL poison errors, CXL AER uncorrectable errors and CXL AER correctable errors.

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
 11 files changed, 1018 insertions(+), 4 deletions(-)  create mode 100644 ras-cxl-handler.c  create mode 100644 ras-cxl-handler.h

--
2.25.1

