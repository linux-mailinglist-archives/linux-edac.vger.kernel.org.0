Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9FA14BB34
	for <lists+linux-edac@lfdr.de>; Tue, 28 Jan 2020 15:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgA1OK0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Jan 2020 09:10:26 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46690 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgA1OK0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Jan 2020 09:10:26 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SE8dGe078441;
        Tue, 28 Jan 2020 14:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2019-08-05; bh=6sI9w95RE9ntuRPBN1xCR88PYQMobQNMf51VK1QN8k4=;
 b=KV7izEhwVBxWBQi/IJssDt3DBZ5oIktau1jI+Y3CToBT/PaakoIsnP/0fdQSoiub/ueA
 KWMwf477xC652CrJRw/DzovbWeTtVXM1DBuE1fQ1pjO2NQgKIdn+Bp8uUiqJ670249me
 f7lajR6z8eboYGA7aHnPKV+7ECd/GNeRFrq0IHTmWuI5D4gvfBVohmVwh3GpiODu8b2M
 6Y8lnN5DyxCzHC/N3/GJBvxLcWwcjAM5irCPYNE7Lzs7jOa/Dw4Ujr9XAggKIagAkWJO
 gEptq8E2+8d30LBY5sl6ukiXRHhjCqXKi0i3u1JmyoANA5ZladjRdlT0mXrTVoMXyr/R Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xrdmqegca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 14:10:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00SE8dRY110827;
        Tue, 28 Jan 2020 14:10:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xtmr27bg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 14:10:04 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00SEA1BF032615;
        Tue, 28 Jan 2020 14:10:01 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jan 2020 06:10:00 -0800
Date:   Tue, 28 Jan 2020 17:09:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, Saar Amar <Saar.Amar@microsoft.com>,
        "security@kernel.org" <security@kernel.org>
Subject: [PATCH] x86/MCE/AMD: Fix use after free in error handling
Message-ID: <20200128140846.phctkvx5btiexvbx@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813100752.GM1935@kadam>
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001280114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9513 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001280114
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

If an error occurs in the threshold_create_bank() function then the real
clean up is supposed to happen in mce_threshold_remove_device().  The
problem here is that if allocate_threshold_blocks() fails, then we
kfree(b) before returning.  Then we use "b" again in
mce_threshold_remove_device() when we do the rest of the clean up work.

Fixes: 019f34fccfd5 ("x86, MCE, AMD: Move shared bank to node descriptor")
Reported-by: Saar Amar <Saar.Amar@microsoft.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I believe Saar found this through reading the code and there is no test
case.  I have don't have a way to test it.

 arch/x86/kernel/cpu/mce/amd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b3a50d962851..ff01b789066e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1342,7 +1342,8 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 	b->kobj = kobject_create_and_add(name, &dev->kobj);
 	if (!b->kobj) {
 		err = -EINVAL;
-		goto out_free;
+		kfree(b);
+		goto out;
 	}
 
 	per_cpu(threshold_banks, cpu)[bank] = b;
@@ -1358,12 +1359,6 @@ static int threshold_create_bank(unsigned int cpu, unsigned int bank)
 	}
 
 	err = allocate_threshold_blocks(cpu, bank, 0, msr_ops.misc(bank));
-	if (!err)
-		goto out;
-
- out_free:
-	kfree(b);
-
  out:
 	return err;
 }
-- 
2.11.0

