Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB050C49
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jun 2019 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfFXNrr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jun 2019 09:47:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58764 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfFXNrq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Jun 2019 09:47:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODd7QX174815;
        Mon, 24 Jun 2019 13:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=ru5BHNeWilfdn0D38ISTbXcMTHrw/PL5SmFYWLHmge8=;
 b=yjMB6VlsgLV7STc9GzCICcenKC0/AXlXCRdw37mzEV8VfXiCBc2IcMB/qJ3a6tKBHGHp
 C02+t1XNWa6TzPFT45XtLdVPFWAwkSUY1iWnNshYU2hShhcpztXmpZdoLiF9wIV7Q0rt
 RnI6/OzrMoBCOchbuLqtYysCZrOUoSetV1lJZH4bXDl1b8QZAm1B2yn+dYXaugRtRco3
 Yp5UfipeaQbtL8/YrMPxHsG+Jxn+KtjQMsSj+UuI0o59lpjMG9RFxQXbL7BtkEe1Qs7n
 8E4rJt1i79tTNTiJPsM75yultM5L9ltthTrlHzY1jUIMbjzhb3uyw+P8yffpkTl7oBAY Pg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brsxhxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:47:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5ODlRFc169351;
        Mon, 24 Jun 2019 13:47:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9acbgxgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 13:47:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5ODlPCU026291;
        Mon, 24 Jun 2019 13:47:25 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 06:47:25 -0700
Date:   Mon, 24 Jun 2019 16:47:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] EDAC/altera: Silence an endian warning
Message-ID: <20190624134717.GA1754@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240112
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Smatch complains that we're casting a u32 pointer to unsigned long.

    drivers/edac/altera_edac.c:1878 altr_edac_a10_irq_handler()
    warn: passing casted pointer '&irq_status' to 'find_first_bit()'

This code wouldn't work on a 64 bit big endian system because we would
read past the end of &irq_status.

Fixes: 13ab8448d2c9 ("EDAC, altera: Add ECC Manager IRQ controller support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static analysis obviously and I don't know this subsystem at all.
Probably we're never going to run this on a 64 bit big endian system...
Feel free to ignore this if you want.

 drivers/edac/altera_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index c2e693e34d43..bf024ec0116c 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1866,6 +1866,7 @@ static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 	struct altr_arria10_edac *edac = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	int irq = irq_desc_get_irq(desc);
+	unsigned long bits;
 
 	dberr = (irq == edac->db_irq) ? 1 : 0;
 	sm_offset = dberr ? A10_SYSMGR_ECC_INTSTAT_DERR_OFST :
@@ -1875,7 +1876,8 @@ static void altr_edac_a10_irq_handler(struct irq_desc *desc)
 
 	regmap_read(edac->ecc_mgr_map, sm_offset, &irq_status);
 
-	for_each_set_bit(bit, (unsigned long *)&irq_status, 32) {
+	bits = irq_status;
+	for_each_set_bit(bit, &bits, 32) {
 		irq = irq_linear_revmap(edac->domain, dberr * 32 + bit);
 		if (irq)
 			generic_handle_irq(irq);
-- 
2.20.1

