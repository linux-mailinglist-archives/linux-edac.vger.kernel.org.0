Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A451FAE19
	for <lists+linux-edac@lfdr.de>; Tue, 16 Jun 2020 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgFPKhN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 06:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFPKhM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 16 Jun 2020 06:37:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BFF620734;
        Tue, 16 Jun 2020 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592303831;
        bh=z6LDz9/G5pNcQFXdInSqegrHVHuPT3Kls9SWQAPqUyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ivXZbzIEFoy6gy+3lznnGcBN8Tcq5DHKexhF0Wx44juizRN06sl0AESZb+Ay4joU
         d9AtCdIMcLYsb1iT1VVMSY7cHVBKXr0EUBsnQm61HbdqQNZipQoUtcqy7h69T5ps7d
         Qv5BWWrT+7nPW6Ac+78DvZQQ8uUIxlvFxDIf+eIs=
Date:   Tue, 16 Jun 2020 12:37:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Manali Shukla (manashuk)" <manashuk@cisco.com>
Cc:     Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Aristeu Rozanski Filho <arozansk@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Russ Anderson <rja@hpe.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [ PATCH stable v4.19] EDAC: Drop per-memory controller buses
Message-ID: <20200616103706.GA2653240@kroah.com>
References: <20200312052201.49456-1-manashuk@cisco.com>
 <20200317102249.GC1130294@kroah.com>
 <5D56C6A7-B076-47BB-9016-7BD54DFE71E7@cisco.com>
 <20200405180605.GC17324@zn.tnic>
 <994FAF5C-B773-4B09-8C08-91E22ECDB8A9@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <994FAF5C-B773-4B09-8C08-91E22ECDB8A9@cisco.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Apr 05, 2020 at 07:26:01PM +0000, Manali Shukla (manashuk) wrote:
> > On 05/04/20, 11:36 PM, "Borislav Petkov" <bp@suse.de> wrote:
> 
> >    On Sun, Apr 05, 2020 at 06:01:21PM +0000, Manali Shukla (manashuk) wrote:
> >> With this patch , we are removing per-MC bus, this removes dependency on value of max number of controllers (EDAC_MAX_MCS) which is hardcoded to 2 * MAX_NUMNODES  in all stable versions of kernel. 
>  >> On two nodes system MAX_NUMNODES value is ‘1’ , so value of max number of memory controller becomes ‘2’, this patch fixes this issue when there are only 2 nodes on the system and number of memory controllers are more than ‘2'
>     
>  > You basically repeated what you had written already.
>     
>  >  But what is this fixing? Some platform of yours or what? Why does it
>  > need to go to stable?
>     
> Certain MIPS platform can have 2 nodes and number of memory controllers can be more than '2' .
> 
> for above condition, if
> #define EDAC_MAX_MCS 2 * MAX_NUMNODES,
> it fails in this function edac_mc_add_mc_with_groups
> in below condition
> if (mci->mc_idx >= EDAC_MAX_MCS) {
> pr_warn_once("Too many memory controllers: %d\n", mci->mc_idx);
> return -ENODEV;
> }
> That is why this fix is needed.

What fix?

I see no patch in this email, nor do I see a git commit id anywhere :(

Totally confused,

greg k-h
