Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88ADA2A1505
	for <lists+linux-edac@lfdr.de>; Sat, 31 Oct 2020 10:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgJaJ61 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 31 Oct 2020 05:58:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7124 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgJaJ61 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 31 Oct 2020 05:58:27 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNZPX6PXSzLrCb;
        Sat, 31 Oct 2020 17:58:24 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 17:58:17 +0800
From:   lvying6 <lvying6@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <fanwentao@huawei.com>
Subject: [PATCH rasdaemon 0/2] ras-page-isolation bugfix
Date:   Sat, 31 Oct 2020 17:57:13 +0800
Message-ID: <1604138235-7142-1-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset fix two problems in ras-page-isolation.c:
1. fix do_page_offline always considers kernel page offline is
successful
2. fix page which is PAGE_OFFLINE_FAILED can not be offlined again

lvying (1):
  ras-page-isolation: fix do_page_offline always considers page offline
    is successful

lvying6 (1):
  ras-page-isolation: page which is PAGE_OFFLINE_FAILED can be offlined
    again

 ras-page-isolation.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

-- 
1.8.3.1

