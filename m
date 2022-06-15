Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D68154C2C4
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jun 2022 09:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbiFOHlR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jun 2022 03:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346821AbiFOHlQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 15 Jun 2022 03:41:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7463D1E0;
        Wed, 15 Jun 2022 00:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E74E618F2;
        Wed, 15 Jun 2022 07:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F6C34115;
        Wed, 15 Jun 2022 07:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655278873;
        bh=TClqVVWZS+qARbIZDVT07arLZRMj8RLyXZnZNh4jzY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w9pZO6vKE9H3Q7I+s9JWjCpI+LgbjrqHoZsWJ4kSMMm58FrfTQuYCYU6/b2g84zwv
         bC0PnHgOOHiPVLJAb4/u4J9XdwTq1tIJQMvmbzoYJ/MXNOK9WVvScPCQfQGR4gnD4i
         aoyovgbg1qtqo9x5bIVzm1eO84QNOTA5kMfqpsIE=
Date:   Wed, 15 Jun 2022 08:33:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Yql9TqFtebd2h9Z9@kroah.com>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614174346.3648305-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 14, 2022 at 05:43:46PM +0000, Yazen Ghannam wrote:
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
> Fixes: 7f99cb5e6039 ("x86/CPU/AMD: Use default_groups in kobj_type")

This predates this fixup, this commit just exposed the root problem here
so odds are it should be backported further, right?

thanks,

greg k-h
