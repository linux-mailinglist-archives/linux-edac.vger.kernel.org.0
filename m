Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A497E673FBC
	for <lists+linux-edac@lfdr.de>; Thu, 19 Jan 2023 18:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjASRTA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Jan 2023 12:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjASRSy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Jan 2023 12:18:54 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFF144BC1;
        Thu, 19 Jan 2023 09:18:34 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NyTq13kZDz685b0;
        Fri, 20 Jan 2023 01:18:05 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.145.221) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 17:18:32 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mchehab@kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/4] rasdaemon: Add support for the CXL error events
Date:   Thu, 19 Jan 2023 17:18:05 +0000
Message-ID: <20230119171809.1406-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.145.221]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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
	  To do so, in the ras-events.c, make following change
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

 Makefile.am                |   8 +-
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
 11 files changed, 914 insertions(+), 4 deletions(-)
 create mode 100644 ras-cxl-handler.c
 create mode 100644 ras-cxl-handler.h

-- 
2.25.1

