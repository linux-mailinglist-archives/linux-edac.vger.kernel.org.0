Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B2BD712E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 10:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbfJOIhH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Oct 2019 04:37:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36662 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbfJOIhG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Oct 2019 04:37:06 -0400
Received: from zn.tnic (p200300EC2F1578003065FDC9422CE4B3.dip0.t-ipconnect.de [IPv6:2003:ec:2f15:7800:3065:fdc9:422c:e4b3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 908F51EC0C7C;
        Tue, 15 Oct 2019 10:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571128624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8sov+h0vFQOe5kE1o7orJQXepes6WUS0r1wSlfopMX0=;
        b=k+aQjWCHhArFGYXIkvBrNJ7zuSa267yG62TjAjCgfs17/fxC1c3M0JaGmpNtaIuV83Tife
        r3Pt53dJ4eieq+NoRJrksTtUQQ+12SZo+vNtTHxxDfCYyjSLBLElwgcSP4xRlVUuURPryJ
        F77tE10KZSX1lgP/UE0udNNCflDGxUA=
Date:   Tue, 15 Oct 2019 10:36:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        bberg@redhat.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        ckellner@redhat.com
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191015083655.GA596@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191014213618.GK4715@zn.tnic>
 <20191014222735.GA25203@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191014222735.GA25203@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 03:27:35PM -0700, Luck, Tony wrote:
> You need a plausible start point for the "when to worry the user"
> message.  Maybe that is your "max value"?

Yes, that would be a good start.

You need that anyway because the experimentations you guys did to get
your numbers have been done in some ambient temperature of X. I betcha
when the ambient temperature differs considerably from yours, the
numbers don't mean a whole lot.

Which makes a dynamic adjustment even more important.

> So if the system has a couple of excursions above temperature lasting
> 1 second and then 2 seconds ... would you like to see those ignored
> (because they are below the initial max)? But now we have a couple
> of data points pick some new value to be the threshold for reporting?
> 
> What value should we pick (based on 1 sec, then 2 sec)?
> 
> I would be worried that it would self tune to the point where it
> does report something that it really didn't need to (e.g. as a result
> of a few consecutive very short excursions).

You select a history feedback formula with which sudden changes
influence the timeout value relatively slowly and keep the current
timeout value rather inert. They would take effect only when such spikes
hold on for a longer time, i.e., take up a longer chunk of the sampling
interval.

> We also need to take into account the "typical sampling interval"
> for user space thermal control software.

Yes to the sampling interval, not so sure about doing anything in
luserspace. This should all be done in the kernel automatically.

> My fault ... during review process I pretty much re-wrote the
> whole commit message to follow the form of:
> 	"What is the problem?"
> 	"How are we fixing it"

Cool.

> But I didn't want Srinivas to take the heat for any mistakes
> that were my fault. "Co-developed-by" really didn't explain
> what happened (since I didn't write any code, just made suggestions
> on things that needed to be changed/improved).

Yeah, so stuff like that is usually added with free text at the end of
the commit message where you have more than a couple of words in a tag
to explain what happened.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
