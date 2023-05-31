Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B954E7186FD
	for <lists+linux-edac@lfdr.de>; Wed, 31 May 2023 18:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEaQGy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 31 May 2023 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjEaQGx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 31 May 2023 12:06:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4CB2
        for <linux-edac@vger.kernel.org>; Wed, 31 May 2023 09:06:50 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWYxt4vpbz6D8WG;
        Thu,  1 Jun 2023 00:05:06 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 17:06:48 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <tanxiaofei@huawei.com>, <lvying6@huawei.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH V2 0/3] rasdaemon: Fix return value type issue, some clean-ups and add support for creating vendor tables at startup
Date:   Thu, 1 Jun 2023 00:06:23 +0800
Message-ID: <20230531160627.1506-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

1. Fix return value type issue and some clean-up.
2. Fix issue of signed and unsigned integer comparison.
3. Add support for creating the vendor error tables at startup.
4. Make changes in the HiSilicon error handling code for the same.

Shiju Jose (1):
  rasdaemon: Add support for creating the vendor error tables at startup

Xiaofei Tan (2):
  rasdaemon: fix return value type issue of read/write function from
    unistd.h
  rasdaemon: fix issue of signed and unsigned integer comparison and
    remove redundant header file

Changes:
- V1 -> V2
1. Combine 2 fix patches together.
2. Remove patch ras-mc-ctl: Add handling of run-time errors reported when
    querying HiSilicon KunPeng9xx OEM errors.
3. Add support for creating the vendor error tables at rasdaemon startup.
   and make changes in the HiSilicon error handling code for the same.

 non-standard-hisi_hip08.c    | 78 +++++++++++++++++++++---------------
 non-standard-hisilicon.c     | 36 ++++++++++-------
 ras-diskerror-handler.c      |  2 +-
 ras-events.c                 | 62 ++++++++++++++++++++--------
 ras-memory-failure-handler.c |  7 ++--
 ras-non-standard-handler.c   | 35 +++++++++++++++-
 ras-non-standard-handler.h   |  3 ++
 7 files changed, 155 insertions(+), 68 deletions(-)

-- 
2.25.1

