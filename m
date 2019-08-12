Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB26889B09
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfHLKMZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 06:12:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35112 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727605AbfHLKMZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 06:12:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED999F36D83503C6D975;
        Mon, 12 Aug 2019 18:12:19 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.45) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 12 Aug 2019 18:12:11 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <baicar@os.amperecomputing.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH RFC 0/4] ACPI: APEI: Add support to notify the vendor specific HW errors
Date:   Mon, 12 Aug 2019 11:11:45 +0100
Message-ID: <20190812101149.26036-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <Shiju Jose>
References: <Shiju Jose>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Presently kernel does not support reporting the vendor specific HW errors,
in the non-standard format, to the vendor drivers for the recovery.

This patch set add this support and also move the existing handler
functions for the standard errors to the new callback method.
Also the CCIX RAS patches could be move to the proposed callback method.
https://www.spinics.net/lists/linux-edac/msg10508.html
https://patchwork.kernel.org/patch/10979491/

Shiju Jose (4):
  ACPI: APEI: Add support to notify the vendor specific HW errors
  ACPI: APEI: Add ghes_handle_memory_failure to the new notification
    method
  ACPI: APEI: Add ghes_handle_aer to the new notification method
  ACPI: APEI: Add log_arm_hw_error to the new notification method

 drivers/acpi/apei/ghes.c | 170 +++++++++++++++++++++++++++++++++++++++++------
 drivers/ras/ras.c        |   5 +-
 include/acpi/ghes.h      |  47 +++++++++++++
 include/linux/ras.h      |   7 +-
 4 files changed, 205 insertions(+), 24 deletions(-)

-- 
1.9.1


