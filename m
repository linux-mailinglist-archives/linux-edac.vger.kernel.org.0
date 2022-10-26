Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4860E025
	for <lists+linux-edac@lfdr.de>; Wed, 26 Oct 2022 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiJZMDP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Oct 2022 08:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbiJZMDN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Oct 2022 08:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331AE1EAC7;
        Wed, 26 Oct 2022 05:03:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B672D61E66;
        Wed, 26 Oct 2022 12:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA89BC433D6;
        Wed, 26 Oct 2022 12:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666785791;
        bh=6nSdeLY7Vee3zTn134Svm4OVr3YBNP5jgNn+QKXMSVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLVvkhyQ2pa5HCN+eKkJGW96HlNJqNbUAlfedOV5KjSFWq2yjrck4LiZm4ksRKplm
         T/+mBH4se+pxATjhaKPnXelfg8u51eSSjkoVgxqiPuxOu11SZDfKjDoqzAO/b2OSKL
         5bvI+TLWzFu+ssFg99xbvpxYOpp2LUM/gkI4WLhY=
Date:   Wed, 26 Oct 2022 14:04:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Y1kiNBh3/XBNe6uv@kroah.com>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <Yql9TqFtebd2h9Z9@kroah.com>
 <Yqnj88FPkZ6kBU7k@yaz-fattaah>
 <Y1kJCHBtatohj/JK@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1kJCHBtatohj/JK@zn.tnic>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 26, 2022 at 12:16:40PM +0200, Borislav Petkov wrote:
> On Wed, Jun 15, 2022 at 01:51:47PM +0000, Yazen Ghannam wrote:
> > Yes, I believe that's true based on code inspection. But I'm not aware of any
> > reported issues in this area before the commit listed above. So I decided to
> > switch the Fixes tag from what I had before (shown below). I can switch it
> > back if you think that's best.
> > 
> > Fixes: 019f34fccfd5 ("x86, MCE, AMD: Move shared bank to node descriptor")
> 
> Yeah, that is probably the culprit. I finally got to this and am able to
> repro on my F10h box.
> 
> Here's what I think the fix should be, Greg, please check this
> for no-nos, especially for doing a kobject_put() on the parent in
> remove_shared_bank_kobjects(). But that is basically the reverse
> operation of the kobject_add() I'm doing when sharing the bank, more to
> that below.
> 
> I wonder why we see this now - maybe the kobject reference counting got
> changed since then...
> 
> Anyway, thoughts?
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> x86/MCE/AMD: Correctly drop shared bank references
> 
> Old AMD machines have a shared MCA bank 4 which reports northbridge
> error types. That bank has a bunch of controls which are exposed this
> way in sysfs on CPU0:
> 
>   /sys/devices/system/machinecheck/machinecheck0/northbridge/
>   ├── dram
>   │   ├── error_count
>   │   ├── interrupt_enable
>   │   └── threshold_limit
>   ├── ht_links
>   │   ├── error_count
>   │   ├── interrupt_enable
>   │   └── threshold_limit
>   └── l3_cache
>       ├── error_count
>       ├── interrupt_enable
>       └── threshold_limit
> 
> In order to expose the exact same controls - the bank is shared
> between all CPUs - threshold_create_bank() reuses the bank pointer and
> kobject_add()s it to the parent of the other CPUs:
> 
>   mce: threshold_create_bank: CPU1, yes, use it, kref: 4, parent_kref: 3, name: northbridge
>   mce: threshold_create_bank: CPU1, inc cpus: 2, bank ref: 4
>   mce: __threshold_add_blocks: entry, kobj: 0xffff888100adb218, parent: 0xffff888100c10c00 ref: 1, parent_kref: 4, name: dram
>   mce: __threshold_add_blocks: misc,  kobj: 0xffff888100adb418, parent: 0xffff888100c10c00,  kref: 1, parent_kref: 6, name: l3_cache
>   mce: __threshold_add_blocks: misc,  kobj: 0xffff888100adb318, parent: 0xffff888100c10c00,  kref: 1, parent_kref: 7, name: ht_links
>   ...
> 
> kobject_add() does a kobject_get() on the parent for each sysfs file it
> adds.
> 
> Therefore, in order to unwind the same setup work when the CPU goes
> offline and the bank *references* only are being removed - the other
> CPUs still share it - do a kobject_put() on the parent.

Eeek, no!

You can't decrement the reference on the parent, that could cause you to
get dropped.

And you can not reuse kobjects, is that the issue here?  When you are
done with one, you have to delete it.  Then create a new one.

No need to move anything around, just destory it all and then add new
ones.

> Rename things more properly while at it and add comments.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> 
> ---
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 1c87501e0fa3..b2bdee9e0bae 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -1241,31 +1241,40 @@ static void threshold_block_release(struct kobject *kobj)
>  	kfree(to_block(kobj));
>  }
>  
> +/*
> + * Drop refcounts and delete list heads in order to free the memory.
> + */
>  static void deallocate_threshold_blocks(struct threshold_bank *bank)
>  {
> +	struct list_head *head = &bank->blocks->miscj;
>  	struct threshold_block *pos, *tmp;
>  
> -	list_for_each_entry_safe(pos, tmp, &bank->blocks->miscj, miscj) {
> -		list_del(&pos->miscj);
> +	list_for_each_entry_safe(pos, tmp, head, miscj) {
>  		kobject_put(&pos->kobj);
> +		list_del(&pos->miscj);
>  	}
>  
>  	kobject_put(&bank->blocks->kobj);
>  }
>  
> -static void __threshold_remove_blocks(struct threshold_bank *b)
> +/*
> + * Only put the parent kobject of each block. The inverse of  kobject_add()
> + * above in threshold_create_bank().
> + */
> +static void remove_shared_bank_kobjects(struct threshold_bank *bank)
>  {
> -	struct threshold_block *pos = NULL;
> -	struct threshold_block *tmp = NULL;
> +	struct list_head *head = &bank->blocks->miscj;
> +	struct threshold_block *pos, *tmp;
>  
> -	kobject_del(b->kobj);
> +	list_for_each_entry_safe(pos, tmp, head, miscj)
> +		kobject_put(pos->kobj.parent);

No, please don't do that.

>  
> -	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
> -		kobject_del(&pos->kobj);
> +	kobject_put(bank->kobj);

What changed to cause problems?  the kobject reference logic hasn't
changed, was it some topology stuff?

thanks,

greg k-h
