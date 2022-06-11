Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E9A5473BF
	for <lists+linux-edac@lfdr.de>; Sat, 11 Jun 2022 12:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiFKKcS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 11 Jun 2022 06:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiFKKcO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 11 Jun 2022 06:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32D98131
        for <linux-edac@vger.kernel.org>; Sat, 11 Jun 2022 03:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654943531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JD69J2sLUFBpAYD/xB2JKlPgocy/ryA5OTBJSpAmob4=;
        b=XWrpXxXgRM7+4l6CBbJuYGdYIqQY9xSzpIO6DVzvCJWZeo3WwucYpLQJGaxST0iufilh1R
        rFXyb1hAbMpv9I/kftMufRN2jYOGb8By5zL3Qji+Mmy2MEbNrPTr2tNGyrZIAqz3yVjbGi
        I70o2b4Ih/KfycB+B2TKDeW8opKqWH0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-Ktr_Xw39O5WI9C1k7jIHXA-1; Sat, 11 Jun 2022 06:32:05 -0400
X-MC-Unique: Ktr_Xw39O5WI9C1k7jIHXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 773A485A580;
        Sat, 11 Jun 2022 10:32:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A1A22166B26;
        Sat, 11 Jun 2022 10:32:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 25BAW4bZ010370;
        Sat, 11 Jun 2022 06:32:04 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 25BAW3gg010366;
        Sat, 11 Jun 2022 06:32:03 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 11 Jun 2022 06:32:03 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Yazen Ghannam <yazen.ghannam@amd.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: Warnings when suspending to disk
In-Reply-To: <YqD1YjeovGu28xsP@yaz-fattaah>
Message-ID: <alpine.LRH.2.02.2206110625280.9999@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com> <YpUcf19E+qgb6Eyu@kroah.com> <alpine.LRH.2.02.2205310324410.13770@file01.intranet.prod.int.rdu2.redhat.com> <Ypjr5yIMan1N0bqH@yaz-fattaah>
 <alpine.LRH.2.02.2206031327190.25179@file01.intranet.prod.int.rdu2.redhat.com> <YqD1YjeovGu28xsP@yaz-fattaah>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Wed, 8 Jun 2022, Yazen Ghannam wrote:

> On Fri, Jun 03, 2022 at 01:34:26PM -0400, Mikulas Patocka wrote:
> 
> ...
> 
> > I tried this patch and it doesn't help.
> 
> Thanks Mikulas for testing.
> 
> I'm still not able to reproduce the exact issue. But I was able to reproduce
> the same symptom by hacking the kernel and doing CPU hotplug.

I also see the warnings when disabling cores.

> Can you please try the following patch? This seems to work in my hacked case.
> I also tried to write out a detailed description of the issue to the best of
> my knowledge.

This patch works - there are no longer any warnings on CPU disable or on 
suspend to disk.

Mikulas

> Thanks,
> Yazen
> 
> ========================
> 
> >From d1fa5cdc7f29bf810215f0a83f16bc7435e55240 Mon Sep 17 00:00:00 2001
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Mon, 6 Jun 2022 19:45:56 +0000
> Subject: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when removing
>  threshold blocks
> 
> AMD systems from Family 10h to 16h share MCA bank 4 across multiple CPUs.
> Therefore, the threshold_bank structure for bank 4, and its threshold_block
> structures, will be initialized once at boot time. And the kobject for the
> shared bank will be added to each of the CPUs that share it. Furthermore,
> the threshold_blocks for the shared bank will be added again to the bank's
> kobject. These additions will increase the refcount for the bank's kobject.
> 
> For example, a shared bank with two blocks and shared across two CPUs will
> be set up like this:
> 
> CPU0 init
>   bank create and add; bank refcount = 1; threshold_create_bank()
>     block 0 init and add; bank refcount = 2; allocate_threshold_blocks()
>     block 1 init and add; bank refcount = 3; allocate_threshold_blocks()
> CPU1 init
>   bank add; bank refcount = 3; threshold_create_bank()
>     block 0 add; bank refcount = 4; __threshold_add_blocks()
>     block 1 add; bank refcount = 5; __threshold_add_blocks()
> 
> Currently in threshold_remove_bank(), if the bank is shared then
> __threshold_remove_blocks() is called. Here the shared bank's kobject and
> the bank's blocks' kobjects are deleted. This is done on the first call
> even while the structures are still shared. Subsequent calls from other
> CPUs that share the structures will attempt to delete the kobjects.
> 
> During kobject_del(), kobject->sd is removed. If the kobject is not part of
> a kset with default_groups, then subsequent kobject_del() calls seem safe
> even with kobject->sd == NULL.
> 
> Originally, the AMD MCA thresholding structures did not use default_groups.
> And so the above behavior was not apparent.
> 
> However, a recent change implemented default_groups for the thresholding
> structures. Therefore, kobject_del() will go down the sysfs_remove_groups()
> code path. In this case, the first kobject_del() may succeed and remove
> kobject->sd. But subsequent kobject_del() calls will give a WARNing in
> kernfs_remove_by_name_ns() since kobject->sd == NULL.
> 
> Use kobject_put() on the shared bank's kobject when "removing" blocks. This
> decrements the bank's refcount while keeping kobjects enabled until the
> bank is no longer shared. At that point, kobject_put() will be called on
> the blocks which drives their refcount to 0 and deletes them and also
> decrementing the bank's refcount. And finally kobject_put() will be called
> on the bank driving its refcount to 0 and deleting it.
> 
> With this patch and the example above:
> 
> CPU1 shutdown
>   bank is shared; bank refcount = 5; threshold_remove_bank()
>     block 0 put parent bank; bank refcount = 4; __threshold_remove_blocks()
>     block 1 put parent bank; bank refcount = 3; __threshold_remove_blocks()
> CPU0 shutdown
>   bank is no longer shared; bank refcount = 3; threshold_remove_bank()
>     block 0 put block; bank refcount = 2; deallocate_threshold_blocks()
>     block 1 put block; bank refcount = 1; deallocate_threshold_blocks()
>   put bank; bank refcount = 0; threshold_remove_bank()
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Tested-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
>  arch/x86/kernel/cpu/mce/amd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 2b7ee4a6c6ba..680b75d23a03 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -1260,10 +1260,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
>  	struct threshold_block *pos = NULL;
>  	struct threshold_block *tmp = NULL;
>  
> -	kobject_del(b->kobj);
> +	kobject_put(b->kobj);
>  
>  	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
> -		kobject_del(&pos->kobj);
> +		kobject_put(b->kobj);
>  }
>  
>  static void threshold_remove_bank(struct threshold_bank *bank)
> -- 
> 2.25.1
> 

