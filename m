Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5094855E
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfFQO3h (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 10:29:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18628 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfFQO3h (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 083C5667FD02DDC21EF5;
        Mon, 17 Jun 2019 22:29:34 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 22:29:25 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>
CC:     Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 0/6] rasdaemon:add logging of HiSilicon HIP08 non-standard H/W errors and changes in the error decoding code
Date:   Mon, 17 Jun 2019 15:28:46 +0100
Message-ID: <20190617142852.12140-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <Shiju Jose>
References: <Shiju Jose>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.53]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch set add few changes in the non-standard error decoding code and
logging for the HiSilicon HIP08 non-standard H/W errors.

Shiju Jose (6):
  rasdaemon:print non-standard error data if not decoded
  rasdaemon: rearrange HiSilicon HIP07 decoding function table
  rasdaemon: update iteration logic for the non-standard error decoding
    functions
  rasdaemon:add logging HiSilicon HIP08 H/W errors reported in the OEM
    format1
  rasdaemon:add logging HiSilicon HIP08 H/W errors reported in the OEM
    format2
  rasdaemon:add logging HiSilicon HIP08 PCIe local errors

 Makefile.am                |   2 +-
 non-standard-hisi_hip07.c  |  36 +-
 non-standard-hisi_hip08.c  | 855 +++++++++++++++++++++++++++++++++++++++++++++
 ras-non-standard-handler.c |  36 +-
 ras-non-standard-handler.h |   8 +-
 ras-record.c               |  30 +-
 ras-record.h               |  13 +
 7 files changed, 932 insertions(+), 48 deletions(-)
 create mode 100644 non-standard-hisi_hip08.c

-- 
1.9.1


