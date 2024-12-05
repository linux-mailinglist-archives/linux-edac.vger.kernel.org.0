Return-Path: <linux-edac+bounces-2644-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5DA9E547D
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AF8283221
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7F721323D;
	Thu,  5 Dec 2024 11:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dKldkP44"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1721322B
	for <linux-edac@vger.kernel.org>; Thu,  5 Dec 2024 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733399268; cv=none; b=WfmZBjgq8EW/1IXCn1/nydfjesSKHpFtldbNzRaBysmRZIjbTEQQM9kWYRtrsEyKGDPATM5Mh/l8FT1yzzUvccgXsu+NCEPObiMW+yNgUIyE1dYvEy+Tdc4c6noGMBbU8VYkG5MMPsDrKnkX74bEGPn1E1SUsapezzAfP6wLqPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733399268; c=relaxed/simple;
	bh=GBkRAM5TCtv2WBOqsRETR7GBtGr+P4Iqz3LhQbY/XX8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e/1RODTh+swTR3fnWadOCyU6CmVWZU4+IH2BKDjI1pxcr6qNyQ0qQ95/oVEUE9OFbxDO+IDvBpnCEK/ochapRJPuSxWhNQq1KDYznUElWJXMtpK2cyn3CVDkZ8rIdWWPlIHxCTqfTYdr+kwu97UCdcCPzXzi+CrejZ3LrpFqQmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dKldkP44; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733399266; x=1764935266;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=3QKVebxt5F9onu1sVPyC3m6LQnqlNzj6gxgWzYmoEFA=;
  b=dKldkP44esGIYFyeBZV5JMYa+/IuwYguibKu5NZbR876Haz5mcs6riIA
   mHdRG1TnwxZ4HsPq2PxoZhpb6p4LpZeBdsSjnmNPbFiHt2H84whce9GzC
   3K+SHJHnn/4tU6i7mZ0JH9tXXuFIDXD0+SDkj2TJAcm+x4iaAuVzVyuYA
   E=;
X-IronPort-AV: E=Sophos;i="6.12,210,1728950400"; 
   d="scan'208";a="46910564"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 11:47:42 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:50246]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.207:2525] with esmtp (Farcaster)
 id 48415fd9-3183-4fc2-b898-17e9d1bce08e; Thu, 5 Dec 2024 11:47:41 +0000 (UTC)
X-Farcaster-Flow-ID: 48415fd9-3183-4fc2-b898-17e9d1bce08e
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Dec 2024 11:47:40 +0000
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX19D001EUA003.ant.amazon.com (10.252.50.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Dec 2024 11:47:40 +0000
Received: from EX19D001EUA003.ant.amazon.com ([fe80::2d24:976:8781:258c]) by
 EX19D001EUA003.ant.amazon.com ([fe80::2d24:976:8781:258c%3]) with mapi id
 15.02.1258.035; Thu, 5 Dec 2024 11:47:40 +0000
From: "Shenhar, Talel" <talel@amazon.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, "bp@alien8.de" <bp@alien8.de>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "james.morse@arm.com"
	<james.morse@arm.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"rric@kernel.org" <rric@kernel.org>, "Kudrjavets, Gunnar"
	<gunnarku@amazon.com>, "Shenhar, Talel" <talel@amazon.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] edac: al_mc: free mem_ctl_info on error path in .probe()
Thread-Topic: [PATCH] edac: al_mc: free mem_ctl_info on error path in .probe()
Thread-Index: AdtHCx7j+bfeWMpNQU6LXFVNQHY70g==
Date: Thu, 5 Dec 2024 11:47:40 +0000
Message-ID: <bdce9341621b4b089a9d04614f06bb1e@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks, Joe, for reaching out.

I noticed that your patch explicitly calls edac_mc_free() in the error path=
, but it seems this is already handled by the devm framework.
Specifically, in devm_add_action_or_reset():
static void devm_al_mc_edac_free(void *data)
{
    edac_mc_free(data);
}

This ensures that edac_mc_free() is called automatically if an error occurs=
 during initialization or the device is removed.
Could you clarify the memory leak scenario you're addressing? Are there spe=
cific cases where the devm handling might not be triggered, leading to the =
observed leak?
If such a scenario exists, understanding the exact path where devm_al_mc_ed=
ac_free() is bypassed would help evaluate whether the explicit call is nece=
ssary.
Without such a case, the patch might introduce redundant cleanup logic.

Looking forward to your insights!

Best regards,
Talel


-----Original Message-----
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>=20
Sent: Thursday, December 5, 2024 12:58 PM
To: Shenhar, Talel <talel@amazon.com>; bp@alien8.de; tony.luck@intel.com; j=
ames.morse@arm.com; mchehab@kernel.org; rric@kernel.org
Cc: linux-edac@vger.kernel.org; Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [EXTERNAL] [PATCH] edac: al_mc: free mem_ctl_info on error path in=
 .probe()

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.



In al_mc_edac_probe(), the mem_ctl_info allocated by edac_mc_alloc() is not=
 freed in the error path, resulting in a memory leak. Add a
edac_mc_free() call to fix this.

Fixes: e23a7cdeb3da ("EDAC/al-mc-edac: Add Amazon's Annapurna Labs Memory C=
ontroller driver")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/edac/al_mc_edac.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c index 17=
8b9e581a72..3908e999f4ff 100644
--- a/drivers/edac/al_mc_edac.c
+++ b/drivers/edac/al_mc_edac.c
@@ -240,7 +240,7 @@ static int al_mc_edac_probe(struct platform_device *pde=
v)

        ret =3D devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_free, =
mci);
        if (ret)
-               return ret;
+               goto free;

        platform_set_drvdata(pdev, mci);
        al_mc =3D mci->pvt_info;
@@ -288,12 +288,12 @@ static int al_mc_edac_probe(struct platform_device *p=
dev)
                dev_err(&pdev->dev,
                        "fail to add memory controller device (%d)\n",
                        ret);
-               return ret;
+               goto free;
        }

        ret =3D devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_del, &=
pdev->dev);
        if (ret)
-               return ret;
+               goto free;

        if (al_mc->irq_ue > 0) {
                ret =3D devm_request_irq(&pdev->dev, @@ -306,7 +306,7 @@ st=
atic int al_mc_edac_probe(struct platform_device *pdev)
                        dev_err(&pdev->dev,
                                "failed to request UE IRQ %d (%d)\n",
                                al_mc->irq_ue, ret);
-                       return ret;
+                       goto free;
                }
        }

@@ -321,11 +321,15 @@ static int al_mc_edac_probe(struct platform_device *p=
dev)
                        dev_err(&pdev->dev,
                                "failed to request CE IRQ %d (%d)\n",
                                al_mc->irq_ce, ret);
-                       return ret;
+                       goto free;
                }
        }

        return 0;
+
+free:
+       edac_mc_free(mci);
+       return ret;
 }

 static const struct of_device_id al_mc_edac_of_match[] =3D {
--
2.34.1


