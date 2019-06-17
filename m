Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4096B48435
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 15:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbfFQNhp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 09:37:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfFQNhp (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jun 2019 09:37:45 -0400
Received: from zn.tnic (p200300EC2F061300646339CEC28800AD.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:1300:6463:39ce:c288:ad])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 305971EC096B;
        Mon, 17 Jun 2019 15:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560778664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a/pVno4C9y6jXqKW+DQT3V6RDkIeS5XAS/FCv6w8vG8=;
        b=mrQfIBePabx4vX7+fCMiV1S5cSrGOaOCrzNl0gLJjJABXxR06pcjJ4skpsZ+jYM84sepFJ
        Sk+kKme+B2OAnNhSftO49r5gqgVwqcCVekTFLXMfCWyhE42/etzLz4DccuMDBIdwZIf73q
        a0x1+s3iiDVxZRt60jlME5krBFzffPM=
Date:   Mon, 17 Jun 2019 15:37:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] EDAC/amd64: Fix number of DIMMs and Chip Select
 bases/masks on Family17h
Message-ID: <20190617133735.GJ27127@zn.tnic>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
 <20190531234501.32826-2-Yazen.Ghannam@amd.com>
 <20190613135822.GC11598@zn.tnic>
 <SN6PR12MB263988EC0AC99DA2D29B21F3F8EF0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB263988EC0AC99DA2D29B21F3F8EF0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 13, 2019 at 09:00:19PM +0000, Ghannam, Yazen wrote:
> Do you have any tips on how to handle it? I'm thinking it may be
> tricky because of the ranges and multiple variables.

It ain't pretty. It seems the if-else thing is still better, after all.

---
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 873437be86d9..16235c0ef7e5 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -936,13 +936,25 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
  */
 static void prep_chip_selects(struct amd64_pvt *pvt)
 {
-	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
+	switch (pvt->fam) {
+	case 0xf:
+		if (pvt->ext_model >= K8_REV_F)
+			goto dflt;
+
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 8;
-	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
+		break;
+
+	case 0x15:
+		if (pvt->model != 0x30)
+			goto dflt;
+
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
-	} else {
+		break;
+
+dflt:
+	default:
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
 	}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
