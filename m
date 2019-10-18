Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41DDCF74
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 21:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634564AbfJRTk1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 15:40:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50884 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634531AbfJRTk1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 15:40:27 -0400
Received: from zn.tnic (p200300EC2F0DFC00B10F655CBDDB26D7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:fc00:b10f:655c:bddb:26d7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E56291EC0CED;
        Fri, 18 Oct 2019 21:40:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571427626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iewD9vPSIWGz1bjjA+UNy0j+ZZ2OvCwBO2+HWiabPhs=;
        b=moNJ/PZSE7Aff8oGARRMGz6NPrNiGJtcU5UdXvdc0/tPZReDNw2mwvaIgiKLVB9PLyW36/
        KiYAOQCMKJGFGxl/RBfkyEYmom5G+Tevx2aTUce7onEmvJEAv3A2+KkjInJnRiTVzAMyPo
        pUm/cFewqn1MyMZuruBhUY4plUX2QgI=
Date:   Fri, 18 Oct 2019 21:40:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ckellner@redhat.com" <ckellner@redhat.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191018194017.GE17053@zn.tnic>
References: <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
 <c2ce4ef128aad84616b2dc21f6230ad4db12194b.camel@linux.intel.com>
 <20191018132309.GD17053@zn.tnic>
 <0f78feb77feba6d3add74a46a16b9d0b3b9c3653.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f78feb77feba6d3add74a46a16b9d0b3b9c3653.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 08:55:17AM -0700, Srinivas Pandruvada wrote:
> I assume that someone is having performance issues or occasion reboots,
> look at the logs. Is it a fair assumption?

Yes, that is a valid use case IMO.

> But if a system is running at up to 87.5% of duty cycle on top of
> lowest possible frequency of around 800MHz, someone will notice.

Yes, but that doesn't justify for those printk statements to be
KERN_CRIT. They're just fine as warnings.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
