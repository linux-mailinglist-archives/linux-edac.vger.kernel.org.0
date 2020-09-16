Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07826C61A
	for <lists+linux-edac@lfdr.de>; Wed, 16 Sep 2020 19:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgIPReW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Sep 2020 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgIPRdp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Sep 2020 13:33:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79466C035433;
        Wed, 16 Sep 2020 10:01:01 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c3e00db2f62bd592f04a0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:db2f:62bd:592f:4a0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 153991EC0380;
        Wed, 16 Sep 2020 19:01:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600275660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LkvwYUOfny5INeLJrbeKgLZhTjk6a4VOIrstYBGgPu4=;
        b=Toq2quLW5TpQcsGP5DrMm+RsrcWMdI9imdYdNvge5DpZB18SQP3QeRLa/Pgzi6qUdI5RB5
        5TAbcTwPjU0bIBRXPQGE+I9R7CbhbgrJscGlti7j70pjvYe86MEVI5cjJnNRTubDd5i60D
        jae3m9HuKdzGOk24rLnTScrSvac4WWw=
Date:   Wed, 16 Sep 2020 19:00:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/mc_sysfs: Add missing newlines when printing
 {max,dimm}_location
Message-ID: <20200916170052.GO2643@zn.tnic>
References: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1600051734-8993-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 14, 2020 at 10:48:54AM +0800, Xiongfeng Wang wrote:
> @@ -813,15 +817,21 @@ static ssize_t mci_max_location_show(struct device *dev,
>  				     char *data)
>  {
>  	struct mem_ctl_info *mci = to_mci(dev);
> -	int i;
> +	int i, n;
>  	char *p = data;
> +	unsigned int len = PAGE_SIZE;
>  
>  	for (i = 0; i < mci->n_layers; i++) {
> -		p += sprintf(p, "%s %d ",
> +		n = snprintf(p, len, "%s %d ",
>  			     edac_layer_name[mci->layers[i].type],
>  			     mci->layers[i].size - 1);
> +		p += n;
> +		len -= n;

What happens if that subtraction causes len to wrap around and become a
huge positive unsigned integer?

> +		if (!len)

Would that test still work?

IOW, I did this to your patch ontop. Note that I've moved the "p"
pointer incrementation after the length check so that the pointer
doesn't overflow too:

---
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index bf0e075fb635..fa0551c81e63 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -817,19 +817,22 @@ static ssize_t mci_max_location_show(struct device *dev,
 				     char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	int i, n;
+	int len = PAGE_SIZE;
 	char *p = data;
-	unsigned int len = PAGE_SIZE;
+	int i, n;
 
 	for (i = 0; i < mci->n_layers; i++) {
 		n = snprintf(p, len, "%s %d ",
 			     edac_layer_name[mci->layers[i].type],
 			     mci->layers[i].size - 1);
-		p += n;
+
 		len -= n;
-		if (!len)
+		if (len < 0)
 			goto out;
+
+		p += n;
 	}
+
 	p += snprintf(p, len, "\n");
 out:
 	return p - data;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
