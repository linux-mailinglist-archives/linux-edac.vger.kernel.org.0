Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7114862E4
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jan 2022 11:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbiAFKZx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jan 2022 05:25:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39880 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiAFKZx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jan 2022 05:25:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24DC5B82025;
        Thu,  6 Jan 2022 10:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96469C36AE5;
        Thu,  6 Jan 2022 10:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641464751;
        bh=HUM2x3eITYEG+lXv3DzWOkB+oicFLZNoNnF6+rxzkj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7Cncwhar4LLrGncjvmsocz28NqynLKXuGaBi3vsJTPNxpc2+4Lito/yVF47FLEhZ
         14LBcvCsSl5KAkRGWWjbwedgRTcwzKleZElfSfRtTAxlFeMWxk68p9e/yjLdKON6iG
         0SdqEkVA5eRwMn/ifQx1dIuskkFVWuXEUAjMrNsc=
Date:   Thu, 6 Jan 2022 11:25:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/CPU/AMD: use default_groups in kobj_type
Message-ID: <YdbDrDvzRCH6D9L6@kroah.com>
References: <20220106101516.3309908-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106101516.3309908-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 06, 2022 at 11:15:16AM +0100, Greg Kroah-Hartman wrote:
> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the AMD mce sysfs code to use default_groups field which
> has been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-edac@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/kernel/cpu/mce/amd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index fc85eb17cb6d..08c64884b0a5 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -1171,6 +1171,7 @@ static struct attribute *default_attrs[] = {
>  	NULL,	/* possibly interrupt_enable if supported, see below */
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(default);
>  
>  #define to_block(k)	container_of(k, struct threshold_block, kobj)
>  #define to_attr(a)	container_of(a, struct threshold_attr, attr)
> @@ -1207,7 +1208,7 @@ static void threshold_block_release(struct kobject *kobj);
>  
>  static struct kobj_type threshold_ktype = {
>  	.sysfs_ops		= &threshold_ops,
> -	.default_attrs		= default_attrs,
> +	.default_groups		= default_groups,
>  	.release		= threshold_block_release,
>  };
>  
> -- 
> 2.34.1
> 

Oops, nope, more work needs to happen on this change, sorry.  I'll send
out a v2 soon...

thanks,

greg k-h
