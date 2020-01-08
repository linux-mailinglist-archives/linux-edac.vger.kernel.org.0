Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49413490A
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jan 2020 18:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgAHRRx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Jan 2020 12:17:53 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:17320 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728234AbgAHRRw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Jan 2020 12:17:52 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008HGD5U027464;
        Wed, 8 Jan 2020 09:17:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=I1fG9kv5CLR6h4xRTSk0o0xVZKpFfWgrkVSaHI8Xbd0=;
 b=Td87zyiJAmGKnqjKE0RGg6me4qZGULScK5mnlSI2HLAD+V5UJpvwalfDc3GdVaAAeUyA
 OsvdhP+ylfW9oiSqGI5IKsHgPh0iNgMhHj9Hz+i5NwbYlKBjbORwjK0kVoGNQby2tNTw
 PYM0R/wA182qif3uhUHnJsMDGtrMh1pT4RzapMnFM1cxyEWbn10wqCiyM2bPW5PeaX0X
 9JIkwbk64VdXUm2f4I+U9p/1cSpWlyw0MUyNGLvLgjJzpNVabjyrR80FelnapOENFTFw
 MsDzPZvDrtuc3Rhjc3Wf7SfUi/oqTqEKm7Fw7OpPnPBwbOTVOSav9n511+D5/InDkt+a Pg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2xde1916cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 09:17:43 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 8 Jan
 2020 09:17:42 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jan 2020 09:17:41 -0800
Received: from dc5-eodlnx05.marvell.com (dc5-eodlnx05.marvell.com [10.69.113.147])
        by maili.marvell.com (Postfix) with ESMTP id 475053F703F;
        Wed,  8 Jan 2020 09:17:41 -0800 (PST)
From:   Bhaskar Upadhaya <bupadhaya@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <lenb@kernel.org>,
        <rafael@kernel.org>
CC:     <bp@alien8.de>, <gkulkarni@marvell.com>, <rrichter@marvell.com>,
        <bhaskar.upadhaya.linux@gmail.com>,
        Bhaskar Upadhaya <bupadhaya@marvell.com>
Subject: [PATCH V2] apei/ghes: fix ghes_poll_func by registering in non-deferrable mode
Date:   Wed, 8 Jan 2020 09:17:38 -0800
Message-ID: <1578503858-27853-1-git-send-email-bupadhaya@marvell.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_04:2020-01-08,2020-01-08 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently Linux register ghes_poll_func with TIMER_DEFERRABLE flag,
because of which it is serviced when the CPU eventually wakes up with a
subsequent non-deferrable timer and not at the configured polling interval.

For polling mode, the polling interval configured by firmware should not
be exceeded as per ACPI_6_3 spec[refer Table 18-394], So Timer need to
be configured in non-deferrable mode by removing TIMER_DEFERRABLE flag.
With NO_HZ enabled and timer callback being configured in non-deferrable
mode, timer callback will get called exactly after polling interval.

Definition of poll interval as per spec (referred ACPI 6.3):
"Indicates the poll interval in milliseconds OSPM should use to
periodically check the error source for the presence of an error
condition"

We are observing an issue in our ThunderX2 platforms wherein
ghes_poll_func is not called within poll interval when timer is
configured with TIMER_DEFERRABLE flag(For NO_HZ kernel) and hence
we are losing the error records.

Impact of removing TIMER_DEFFERABLE flag
- With NO_HZ enabled, additional timer ticks and unnecessary wakeups of
 the cpu happens exactly after polling interval.

- If polling interval is too small than polling function will be called
 too frequently which may stall the cpu.

Signed-off-by: Bhaskar Upadhaya <bupadhaya@marvell.com>
---
Changes for V2
Incorporated Borislav comments to add below in commit message
- definition of poll interval as per ACPI 6.3
- problem which is occuring on ThunderX2 platform with TIMER_DEFERRABLE flag
   
 drivers/acpi/apei/ghes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 777f6f7122b4..c8f9230f69fb 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1181,7 +1181,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	switch (generic->notify.type) {
 	case ACPI_HEST_NOTIFY_POLLED:
-		timer_setup(&ghes->timer, ghes_poll_func, TIMER_DEFERRABLE);
+		timer_setup(&ghes->timer, ghes_poll_func, 0);
 		ghes_add_timer(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_EXTERNAL:
-- 
2.17.1

