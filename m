Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103862CEBF3
	for <lists+linux-edac@lfdr.de>; Fri,  4 Dec 2020 11:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgLDKPA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Dec 2020 05:15:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2204 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDKO7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Dec 2020 05:14:59 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CnT5L4TMtz67LfW;
        Fri,  4 Dec 2020 18:11:50 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 4 Dec 2020 11:14:16 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.85.97) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 4 Dec 2020 10:14:15 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <xuwei5@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <tanxiaofei@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 0/3] rasdaemon: ras-mc-ctl: Support vendor-specific error events
Date:   Fri, 4 Dec 2020 10:13:35 +0000
Message-ID: <20201204101338.1060-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.85.97]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support for logging the vendor-specific error events and
add support for the HiSilicon KunPeng9xx server errors
to the ras-mc-ctl.

Shiju Jose (3):
  rasdaemon: ras-mc-ctl: Add support for the vendor-specific errors
  rasdaemon: ras-mc-ctl: Add support for HiSilicon KunPeng920 errors
  rasdaemon: ras-mc-ctl: Add support for HiSilicon KunPeng9xx common
    errors

 util/ras-mc-ctl.in | 289 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 288 insertions(+), 1 deletion(-)

-- 
2.17.1

