Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C299246486
	for <lists+linux-edac@lfdr.de>; Mon, 17 Aug 2020 12:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHQKaa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Aug 2020 06:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHQKa3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Aug 2020 06:30:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1888C061389;
        Mon, 17 Aug 2020 03:30:29 -0700 (PDT)
Received: from zn.tnic (p200300ec2f26be0071e1cf3fa1f5ba15.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:71e1:cf3f:a1f5:ba15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53FBC1EC02C3;
        Mon, 17 Aug 2020 12:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597660225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0uSq9qk/RW8bveLRIOi0gn3aCCuOfz0gR3ySVhVswAI=;
        b=pGAVTOhBS76mB5TZG2zXGksNaiYoOycCZ+tjVARYWosgItgDF9WcPI8PQSEnQTOxhXnwL9
        H5lr8ShVXvmRyDz6urOoJcGC4BSN6hdvaggbOxLdTDoZ64Ph5dauUntDo+IRixwDOMd0C+
        A9loz87jTm8P7dy54ny19aYqi0SWlnU=
Date:   Mon, 17 Aug 2020 12:31:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200817103121.GF549@zn.tnic>
References: <20200716085834.11484-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716085834.11484-1-miaoqinglang@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 16, 2020 at 04:58:34PM +0800, Qinglang Miao wrote:
> From: Yongqiang Liu <liuyongqiang13@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>  drivers/ras/cec.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index a992bb426..ed47b59e4 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -435,7 +435,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(action_threshold_ops, u64_get, action_threshold_set, "%
>  
>  static const char * const bins[] = { "00", "01", "10", "11" };
>  
> -static int array_dump(struct seq_file *m, void *v)
> +static int array_show(struct seq_file *m, void *v)
>  {
>  	struct ce_array *ca = &ce_arr;
>  	int i;
> @@ -467,18 +467,7 @@ static int array_dump(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> -static int array_open(struct inode *inode, struct file *filp)
> -{
> -	return single_open(filp, array_dump, NULL);
> -}
> -
> -static const struct file_operations array_ops = {
> -	.owner	 = THIS_MODULE,
> -	.open	 = array_open,
> -	.read_iter	 = seq_read_iter,

$ test-apply.sh /tmp/01-ras-cec-convert_to_define_show_attribute.patch
checking file drivers/ras/cec.c
Hunk #2 FAILED at 467.
1 out of 3 hunks FAILED
Apply? (y/n) n

Where did this .read_iter come from?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
