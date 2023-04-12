Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC29E6DEFF5
	for <lists+linux-edac@lfdr.de>; Wed, 12 Apr 2023 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDLI7C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Apr 2023 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjDLI7A (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Apr 2023 04:59:00 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA01430C8;
        Wed, 12 Apr 2023 01:58:43 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxGBt1rMpz6J7DH;
        Wed, 12 Apr 2023 16:31:18 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 09:33:39 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 0/7] rasdaemon: Process the generic CXL trace events
Date:   Wed, 12 Apr 2023 16:33:04 +0800
Message-ID: <20230412083312.1384-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

Log and record the following generic CXL error records reported through
the kernel trace events.
- cxl_overflow
- cxl_generic_event
- cxl_general_media
- cxl_dram
- cxl_memory_module

Shiju Jose (7):
  rasdaemon: Add common function to convert timestamp in the CXL event
    records to the broken-down time format
  rasdaemon: Add common function to get timestamp for the event
  rasdaemon: Add support for the CXL overflow events
  rasdaemon: Add support for the CXL generic events
  rasdaemon: Add support for the CXL general media events
  rasdaemon: Add support for the CXL dram events
  rasdaemon: Add support for the CXL memory module events

 ras-cxl-handler.c | 826 +++++++++++++++++++++++++++++++++++++++++++---
 ras-cxl-handler.h |  15 +
 ras-events.c      |  45 +++
 ras-events.h      |   5 +
 ras-record.c      | 420 +++++++++++++++++++++++
 ras-record.h      |  99 ++++++
 ras-report.c      | 476 ++++++++++++++++++++++++++
 ras-report.h      |  10 +
 8 files changed, 1853 insertions(+), 43 deletions(-)

-- 
2.25.1

