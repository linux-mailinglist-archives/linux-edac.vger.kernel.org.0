Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61462351A37
	for <lists+linux-edac@lfdr.de>; Thu,  1 Apr 2021 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhDAR6m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Apr 2021 13:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236883AbhDARzg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Apr 2021 13:55:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F03C02FEA8;
        Thu,  1 Apr 2021 09:12:42 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08870070b45f06e9fedc1b.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8700:70b4:5f06:e9fe:dc1b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB3DC1EC0516;
        Thu,  1 Apr 2021 18:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1617293560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=D5AcjEpLI6NGptAOcU3s8MiJCsw0QoCR1oFeiyhm3WI=;
        b=ICGT7NtqfpvmcbkOCvNVXfUSW4DiRDjsdi0Vfd1AnVEq9yQ03QGiNrhU8M9mztVs53ktGI
        QvcFxQNBAszJ08e0c4IkAcajOFOUfOHHuPSEYOnp4dtBxuBzBzxCnJfHyrjYZwSwZLtk5V
        sb7NQpWtiZStw5rQZ37/DaMnXqZQryA=
Date:   Thu, 1 Apr 2021 18:12:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     William Roche <william.roche@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1] RAS/CEC: Memory Corrected Errors consistent event
 filtering
Message-ID: <20210401161237.GC28954@zn.tnic>
References: <1616783429-6793-1-git-send-email-william.roche@oracle.com>
 <20210326190242.GI25229@zn.tnic>
 <fac89612-e15c-2940-9d6d-70a812dbe99c@oracle.com>
 <20210326224310.GL25229@zn.tnic>
 <3ee5551c-d311-1939-315f-a4712e3821ff@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3ee5551c-d311-1939-315f-a4712e3821ff@oracle.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 29, 2021 at 11:44:05AM +0200, William Roche wrote:
> I totally agree with you, and in order to schedule a replacement, MCEs
> information (enriched by the notifiers chain) are more meaningful than
> only PFN values.

Well, if you want to collect errors and analyze patterns in order to
detect hw going bad, you're probably better off disabling the CEC
altogether - either disable it in Kconfig or boot with ras=cec_disable.

> 1/ Giving back ras_cec a consistent behavior where the first occurrence
> of a CE doesn't generate an MCE message from the MCE_HANDLED_CEC
> notifiers, and a consistent behavior between the slot 0 and the other
> pfn slots.

If by this you mean the issue with the return value, then sure.

If you mean something else, you'd have to be more specific.

> 2/ Give the CE MCE information when the action threshold is reached to
> help the administrator identify what generated the PFN "Soft-offlining"
> or "Invalid pfn" message.
> 
> When ras_cec is enabled it hides most of the CE errors, but when the
> action threshold is reached all notifiers can generate their indication
> about the error that appeared too often.
> 
> An administrator getting too many action threshold CE errors can
> schedule a replacement based on the indications provided by his EDAC
> module etc...

Well, this works probably only in theory.

First of all, the CEC sees the error first, before the EDAC drivers.

But, in order to map from the virtual address to the actual DIMM, you
need the EDAC drivers to have a go at the error. In many cases not even
the EDAC drivers can give you that mapping because, well, hw/fw does its
own stuff underneath, predictive fault bla, added value crap, whatever,
so that we can't even get a "DIMM X on processor Y caused the error."

I know, your assumption is that if a page gets offlined by the CEC, then
all the errors' addresses are coming from the same physical DIMM. And
that is probably correct in most cases but I'm not convinced for all.

In any case, what we could do - which is pretty easy and cheap - is to
fix the retval of cec_add_elem() to communicate to the caller that it
offlined a page and this way tell the notifier chain that the error
needs to be printed into dmesg with a statement sayin that DIMM Y got
just one more page offlined.

Over time, if a DIMM is going bad, one should be able to grep dmesg and
correlate all those offlined pages to DIMMs and then maybe see a pattern
and eventually schedule a downtime.

A lot of ifs, I know. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
