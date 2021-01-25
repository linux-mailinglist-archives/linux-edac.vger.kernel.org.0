Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2973028BA
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jan 2021 18:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbhAYRWl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jan 2021 12:22:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2427 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730978AbhAYRWV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jan 2021 12:22:21 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPc5H3nBNz67h8M;
        Tue, 26 Jan 2021 01:18:11 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 18:21:28 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.115) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 17:21:27 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@openeuler.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH v2 8/8] rasdaemon: Modify confiure.ac for Hisilicon Kunpeng errors
Date:   Mon, 25 Jan 2021 17:14:55 +0000
Message-ID: <20210125171455.1886-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210125171455.1886-1-shiju.jose@huawei.com>
References: <20210125171455.1886-1-shiju.jose@huawei.com>
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

Modify  HIP07 SAS HW errors : $USE_HISI_NS_DECODE to
HISI Kunpeng errors : $USE_HISI_NS_DECODE.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 9893bb4..3a8b0c7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -191,7 +191,7 @@ compile time options summary
     EXTLOG              : $USE_EXTLOG
     CPER non-standard   : $USE_NON_STANDARD
     ABRT report         : $USE_ABRT_REPORT
-    HIP07 SAS HW errors : $USE_HISI_NS_DECODE
+    HISI Kunpeng errors : $USE_HISI_NS_DECODE
     ARM events          : $USE_ARM
     DEVLINK             : $USE_DEVLINK
     Disk I/O errors     : $USE_DISKERROR
-- 
2.17.1

